# QCustomPlot-PyQt5
Bindings for graphics lib QCustomPlot for PyQt5.

## In this fork:
  - Build system is upgraded to recent sip versions, obsolate `sipconfig` is not needed anymore
  - Added a possibility to create own plottables and items as Python classes (added bindings for all protected members)
  - Added wrappers to `QCPItemBracket`, `QCPItemCurve`, `QCPItemEllipse`, `QCPItemPixmap`, `QCPItemRect` and `QCPItemText`

## Requirements:
  - PyQt5
  - sip
  - qmake (Qt5)
  - make/nmake/jom
  - Linux/Windows operating systems
  - gcc/msvc compilers

## Build & install:
Currently QCustomPlot is statically linked and downloaded as GIT submodule.

  - git submodule update --init
  - python -m build
  
Or to build and install run: pip install .

## TODO:
  - No debug builds are currently supported
  - Test on other than Linux & Windows systems
  - Test on compilers other than gcc/MSVC and specify minimum versions
