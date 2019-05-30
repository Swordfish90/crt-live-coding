#ifndef QOSCSENDER_H
#define QOSCSENDER_H

#include "osc/OscOutboundPacketStream.h"
#include "osc/OscTypes.h"
#include "ip/UdpSocket.h"
#include <QObject>
#include <QString>
#include "qoscmessage.h"
#include "qoscbundle.h"

class QOSCSender : public QObject
{
    Q_OBJECT
public:
    explicit QOSCSender(QObject *parent = nullptr);
    explicit QOSCSender(QString remoteHost, int remotePort, QObject *parent = nullptr);
    void send(QOSCMessage *message, bool bundled = true);
    void send(QOSCBundle bundle);
protected:
private:
    UdpTransmitSocket *_socket;
    QString _remoteHost;
    int _remotePort;
public slots:
    void setRemoteHost(QString remoteHost);
    void setRemotePort(int remotePort);
    void setup(QString remoteHost, int remotePort);
    void setup();
};

#endif // QOSCSENDER_H
