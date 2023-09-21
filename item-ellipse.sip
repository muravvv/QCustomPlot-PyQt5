/** PyQt5 binding for QCustomPlot v2.0.0
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Viktor Muraviev
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */

class QCPItemEllipse : public QCPAbstractItem
{
%TypeHeaderCode
#include <QCustomPlot/src/qcp.h>
%End

public:
  QCPItemEllipse(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPItemEllipse();
  
  // getters:
  QPen pen() const;
  QPen selectedPen() const;
  QBrush brush() const;
  QBrush selectedBrush() const;
  
  // setters;
  void setPen(const QPen &pen);
  void setSelectedPen(const QPen &pen);
  void setBrush(const QBrush &brush);
  void setSelectedBrush(const QBrush &brush);
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  
  // There's nothing like 'const' in python
  QCPItemPosition *topLeft
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemPosition*>(sipCpp->topLeft), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'topLeft' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemPosition *bottomRight
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemPosition*>(sipCpp->bottomRight), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'bottomRight' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor *topLeftRim
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->topLeftRim), sipType_QCPItemAnchor, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'topLeftRim' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor *top
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->top), sipType_QCPItemAnchor, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'top' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor *topRightRim
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->topRightRim), sipType_QCPItemAnchor, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'topRightRim' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor *right
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->right), sipType_QCPItemAnchor, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'right' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor *bottomRightRim
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->bottomRightRim), sipType_QCPItemAnchor, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'bottomRightRim' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor *bottom
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->bottom), sipType_QCPItemAnchor, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'bottom' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor *bottomLeftRim
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->bottomLeftRim), sipType_QCPItemAnchor, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'bottomLeftRim' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor *left
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->left), sipType_QCPItemAnchor, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'left' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor *center
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->center), sipType_QCPItemAnchor, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'center' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  
protected:
  enum AnchorIndex {aiTopLeftRim, aiTop, aiTopRightRim, aiRight, aiBottomRightRim, aiBottom, aiBottomLeftRim, aiLeft, aiCenter};
  
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual QPointF anchorPixelPosition(int anchorId) const;
  
  // non-virtual methods:
  QPen mainPen() const;
  QBrush mainBrush() const;
};
