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
    void newData(float loudness, float flat, float centroid);

public slots:
    void onMessageReceived(QOSCMessage* message);

private:
    QOSCReceiver* oscReceiver;
};

#endif // SCOSCDATAPROVIDER_H
