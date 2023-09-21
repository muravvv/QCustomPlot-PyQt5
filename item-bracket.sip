/** PyQt5 binding for QCustomPlot v2.0.0
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Viktor Muraviev
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */

class QCPItemBracket : public QCPAbstractItem
{
%TypeHeaderCode
#include <QCustomPlot/src/qcp.h>
%End

public:
  /*!
    Defines the various visual shapes of the bracket item. The appearance can be further modified
    by \ref setLength and \ref setPen.
    
    \see setStyle
  */
  enum BracketStyle { bsSquare  ///< A brace with angled edges
                      ,bsRound  ///< A brace with round edges
                      ,bsCurly  ///< A curly brace
                      ,bsCalligraphic ///< A curly brace with varying stroke width giving a calligraphic impression
  };

  QCPItemBracket(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPItemBracket();
  
  // getters:
  QPen pen() const;
  QPen selectedPen() const;
  double length() const;
  BracketStyle style() const;
  
  // setters;
  void setPen(const QPen &pen);
  void setSelectedPen(const QPen &pen);
  void setLength(double length);
  void setStyle(BracketStyle style);
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  
  // There's nothing like 'const' in python
  QCPItemPosition *left
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemPosition*>(sipCpp->left), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'left' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemPosition *right
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemPosition*>(sipCpp->right), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'right' attribute cannot be assigned");
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
  // property members:
  enum AnchorIndex {aiCenter};
  
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual QPointF anchorPixelPosition(int anchorId) const;
  
  // non-virtual methods:
  QPen mainPen() const;
};
