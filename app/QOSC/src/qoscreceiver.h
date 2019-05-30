#ifndef QOSCRECEIVERER_H
#define QOSCRECEIVERER_H
#include "osc/OscOutboundPacketStream.h"
#include "osc/OscPacketListener.h"
#include "ip/UdpSocket.h"

#include <QObject>
#include <QString>
#include <QThread>
#include "qoscmessage.h"
#include "qoscbundle.h"

using namespace osc;
class QOSCReceiver :
        public QThread,
        public osc::OscPacketListener
{
    Q_OBJECT
public:
    explicit QOSCReceiver(unsigned int localPortUI, QObject *parent = nullptr);
    void stop();

protected:
    void run();
private:
    virtual void ProcessMessage( const osc::ReceivedMessage &m, const IpEndpointName& remoteEndpoint );

private:
    UdpListeningReceiveSocket *_socket;
    unsigned int _localPortUI;
signals:
    void messageReceived(QOSCMessage *msg);
};

#endif // QOSCRECEIVER_H
