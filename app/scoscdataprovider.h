#ifndef SCOSCDATAPROVIDER_H
#define SCOSCDATAPROVIDER_H

#include <QObject>
#include "QOSC/src/qoscreceiver.h"
#include "QOSC/src/qoscmessage.h"

class SCOSCDataProvider : public QObject
{
    Q_OBJECT
public:
    explicit SCOSCDataProvider(QObject *parent = nullptr);

signals:
    void newData(float loudness, float pw0, float pw1, float pw2, float pw3, float pw4, float pw5, float pw6, float pw7);

public slots:
    void onMessageReceived(QOSCMessage* message);

private:
    QOSCReceiver* oscReceiver;
};

#endif // SCOSCDATAPROVIDER_H
