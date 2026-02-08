# -*- coding: utf-8 -*-

from os.path import join, exists, abspath, dirname
import os
import datetime
import shlex
import subprocess
import sys

from pyqtbuild import PyQtBindings, PyQtProject, QmakeBuilder

ROOT = abspath(dirname(__file__))

def get_git_build_number():
    TAG = "UNKNOWN"
    exe_extension = ".exe" if (sys.platform == "win32") else ""
    exe_name = "git{0}".format(exe_extension)

    TAG = DISTANCE = COMMIT = DATE = MODIFIED = None

    command = shlex.split(u"{0} describe --tags --always".format(exe_name))
    pipe = subprocess.run(command, stdout=subprocess.PIPE, check=True, shell=False)
    for line in pipe.stdout.split(b'\n'):
        parts = line.strip().split(b'-')
        COMMIT = parts[-1].replace(b'g', b'').decode('utf8')
        DISTANCE = int(parts[-2])
        TAG = b'-'.join(parts[:-2]).decode('utf8')
        break

    command = shlex.split(u"{0} status --porcelain -uno".format(exe_name))
    pipe = subprocess.run(command, stdout=subprocess.PIPE, check=True, shell=False)
    MODIFIED = True if len(pipe.stdout) else False

    command = shlex.split(u"{0} show -s --format=%cI".format(exe_name))
    pipe = subprocess.run(command, stdout=subprocess.PIPE, check=True, shell=False)
    for line in pipe.stdout.split(b'\n'):
        line = line.strip().decode('ascii')
        # Something like '2019-06-20T09:04:10+02:00'
        # Python 3.5 %z strptime format does not like the ':' in TZ
        date_part, tz_part = line.split('+')
        line = '+'.join((date_part, tz_part.replace(':', '')))
        DATE = datetime.datetime.strptime(line, "%Y-%m-%dT%H:%M:%S%z")
        break

    return TAG, DISTANCE, COMMIT, DATE, MODIFIED

class QCustomPlotProject(PyQtProject):
    def __init__(self):
        super().__init__()
        
    def _get_qcustomplot_static(self):
        self.lib_build_dir = join(self.build_dir, "qcustomplot_lib")
        if self.py_platform == 'win32':
            return join(self.lib_build_dir, 'release', 'qcustomplot.lib')
        else:
            return join(self.lib_build_dir, 'libqcustomplot.a')

    def __build_qcustomplot_library(self):
        qcustomplot_static = self._get_qcustomplot_static()
        if exists(qcustomplot_static):
            return

        os.makedirs(self.lib_build_dir, exist_ok=True)
        os.chdir(self.lib_build_dir)
        print('Make static qcustomplot library...')
        self.run_command([self.builder.qmake, join(ROOT, 'QCustomPlot/src/qcp-staticlib.pro')])
        # AFAIK only nmake does not support -j option
        make = self.builder._find_make()
        has_multiprocess = not(self.py_platform == 'win32' and "nmake" in make)
        make_cmdline = [make]
        if has_multiprocess:
            make_cmdline.extend(('-j', str(os.cpu_count())))
        make_cmdline.append('release')
        self.run_command(make_cmdline)

        os.chdir(ROOT)
        self.static_lib = qcustomplot_static

    def build(self):
        self.__build_qcustomplot_library()
        super().build()

    def build_wheel(self, wheel_directory):
        self.__build_qcustomplot_library()
        return super().build_wheel(wheel_directory)
        
    def update(self, tool):
        QCustomPlotBinding = self.bindings['QCustomPlot']
        # QCustomPlotBinding.extra_objects += [self._get_qcustomplot_static()] # does not work due to bug in pyqtbuild.QmakeBuilder
        QCustomPlotBinding.builder_settings += [f'OBJECTS += {QmakeBuilder.qmake_quote(self._get_qcustomplot_static())}']
        if self.py_platform == 'win32':
            QCustomPlotBinding.libraries += ['Opengl32']
    def get_metadata_overrides(self):
        ret = super().get_metadata_overrides()

        TAG, DISTANCE, COMMIT, DATE, MODIFIED = get_git_build_number()

        if not DISTANCE:
            # We're on a tag, good
            version = TAG
        else:
            # Revert to year.month.dev{distance}+{commit}
            version = "{0.year}.{0.month}.dev{1}+{2}".format(DATE, DISTANCE, COMMIT)
        print(f'Version: {version}')
        ret["version"] = version
        return ret
