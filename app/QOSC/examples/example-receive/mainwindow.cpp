#include "mainwindow.h"
#include <QDebug>
#include <QVBoxLayout>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent),
      _oscReceiver(new QOSCReceiver(8000, this)),
      _slider(new QSlider(this)),
      _toggle(new QPushButton(this)),
      _lineEdit(new QLineEdit(this)),
      _spinBox(new QDoubleSpinBox)
{
    connect(_oscReceiver, SIGNAL(messageReceived(QOSCMessage*)), this, SLOT(onMessageReceived(QOSCMessage*)));
    _oscReceiver->start();


    setWindowTitle("QOSCReceiveExample");
    QWidget *mainWidget = new QWidget(this);
    QVBoxLayout *mainLayout = new QVBoxLayout(mainWidget);
    mainLayout->addWidget(_slider);
    mainLayout->addWidget(_lineEdit);
    mainLayout->addWidget(_toggle);
    mainLayout->addWidget(_spinBox);
    setCentralWidget(mainWidget);

    mainWidget->setEnabled(false);
    _toggle->setCheckable(true);

}

MainWindow::~MainWindow()
{

}

void MainWindow::onMessageReceived(QOSCMessage *msg)
{
    qDebug()<<"new message"<<msg->getAddress();
//    foreach(QOSCArgument *arg, msg->getArguments())
//    {
//        arg->_type

//    }
//    for(int i = 0; i < msg->getSize(); i++)
//    {
//        if(msg->isIntArgument(i))
//        {
//            qDebug()<<"arg"<<i<<msg->getArgumentAsInt(i);
//        }
//        else if(msg->isStringArgument(i))
//        {
//            qDebug()<<"arg"<<i<<msg->getArgumentAsString(i);
//        }
//        else if(msg->isBoolArgument(i))
//        {
//            qDebug()<<"arg"<<i<<msg->getArgumentAsBool(i);
//        }
//        else if(msg->isFloatArgument(i))
//        {
//            qDebug()<<"arg"<<i<<msg->getArgumentAsFloat(i);
//        }
//    }
    if(msg->getAddress() == "/slider" && msg->isIntArgument(0))
    {
        _slider->setValue(msg->getArgumentAsInt(0));
    }
    else if(msg->getAddress() == "/lineEdit" && msg->isStringArgument(0))
    {
        _lineEdit->setText(msg->getArgumentAsString(0));
    }
    else if(msg->getAddress() == "/toggle" && msg->isBoolArgument(0))
    {
        _toggle->setChecked(msg->getArgumentAsBool(0));
    }
    else if(msg->getAddress() == "/spinBox" && msg->isFloatArgument(0))
    {
        _spinBox->setValue(msg->getArgumentAsFloat(0));
    }
    else if(msg->getAddress() == "/values" &&
            msg->isIntArgument(0) &&
            msg->isStringArgument(1) &&
            msg->isBoolArgument(2) &&
            msg->isFloatArgument(3))
    {
        _slider->setValue(msg->getArgumentAsInt(0));
        _lineEdit->setText(msg->getArgumentAsString(1));
        _toggle->setChecked(msg->getArgumentAsBool(2));
        _spinBox->setValue(msg->getArgumentAsFloat(3));
    }
}


