#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "qoscsender.h"

#include <QDoubleSpinBox>
#include <QLineEdit>
#include <QPushButton>
#include <QSlider>

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();
private slots:
    void onSliderChange(int value);
    void onToggleChange(bool value);
    void onLineEditChange(QString value);
    void onSpinBoxChange(double value);
    void onSendAllButtonClick(bool value);
private:
    QOSCSender *_oscSender;
    QSlider *_slider;
    QPushButton *_toggle;
    QLineEdit *_lineEdit;
    QDoubleSpinBox *_spinBox;

    QPushButton *_sendAllButton;
};

#endif // MAINWINDOW_H
