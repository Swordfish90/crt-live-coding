#include "mainwindow.h"
#include <QDebug>
#include <QVBoxLayout>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent),
      _oscSender(new QOSCSender("127.0.0.1", 8000, this)),
      _slider(new QSlider(this)),
      _lineEdit(new QLineEdit(this)),
      _toggle(new QPushButton(this)),
      _spinBox(new QDoubleSpinBox),
      _sendAllButton(new QPushButton("send all", this))
{
    _toggle->setCheckable(true);

    connect(_slider, SIGNAL(valueChanged(int)), this, SLOT(onSliderChange(int)));
    connect(_lineEdit, SIGNAL(textChanged(QString)), this, SLOT(onLineEditChange(QString)));
    connect(_toggle, SIGNAL(clicked(bool)), this, SLOT(onToggleChange(bool)));
    connect(_spinBox, SIGNAL(valueChanged(double)), SLOT(onSpinBoxChange(double)));
    connect(_sendAllButton, SIGNAL(clicked(bool)), SLOT(onSendAllButtonClick(bool)));

    setWindowTitle("QOSCSendExample");
    QWidget *mainWidget = new QWidget(this);
    QVBoxLayout *mainLayout = new QVBoxLayout(mainWidget);
    mainLayout->addWidget(_slider);
    mainLayout->addWidget(_lineEdit);
    mainLayout->addWidget(_toggle);
    mainLayout->addWidget(_spinBox);
    mainLayout->addWidget(_sendAllButton);
    setCentralWidget(mainWidget);
}

MainWindow::~MainWindow()
{

}

void MainWindow::onSliderChange(int value)
{

    QOSCMessage *message = new QOSCMessage("/slider");
    message->addInt(value);
    _oscSender->send(message);
}

void MainWindow::onToggleChange(bool value)
{
    QOSCMessage *message = new QOSCMessage("/toggle");
    message->addBool(value);
    _oscSender->send(message);
}

void MainWindow::onLineEditChange(QString value)
{
    QOSCMessage *message = new QOSCMessage("/lineEdit");
    message->addString(value);
    _oscSender->send(message);
}

void MainWindow::onSpinBoxChange(double value)
{
    QOSCMessage *message = new QOSCMessage("/spinBox");
    message->addFloat(value);
    _oscSender->send(message);
}

void MainWindow::onSendAllButtonClick(bool value)
{
    Q_UNUSED(value);
    QOSCMessage *message = new QOSCMessage("/values");
    message->addInt(_slider->value());
    message->addString(_lineEdit->text());
    message->addBool(_toggle->isChecked());
    message->addFloat(_spinBox->value());
    _oscSender->send(message);
}
