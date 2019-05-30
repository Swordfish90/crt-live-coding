#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "qoscreceiver.h"

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
    QOSCReceiver *_oscReceiver;
public slots:
    void onMessageReceived(QOSCMessage *msg);

private:
    QSlider *_slider;
    QPushButton *_toggle;
    QLineEdit *_lineEdit;
    QDoubleSpinBox *_spinBox;
};

#endif // MAINWINDOW_H
