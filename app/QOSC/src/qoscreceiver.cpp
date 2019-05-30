#include "qoscreceiver.h"
#include <QDebug>

QOSCReceiver::QOSCReceiver(unsigned int localPortUI, QObject *parent):
    QThread(parent),
    _localPortUI(localPortUI),
    _socket( new UdpListeningReceiveSocket(IpEndpointName( IpEndpointName::ANY_ADDRESS, localPortUI ), this))
{
}
void QOSCReceiver::stop()
{
//    _socket->AsynchronousBreak();
}

void QOSCReceiver::run()
{
    qDebug()<<"started thread";
    _socket->Run();
    qDebug()<<"ended thread";

}

void QOSCReceiver::ProcessMessage(const ReceivedMessage &m, const IpEndpointName &remoteEndpoint)
{
    //qDebug()<<"new oscmessage";
    QOSCMessage *msg = new QOSCMessage(QString::fromStdString(m.AddressPattern()));
    for(osc::ReceivedMessage::const_iterator arg = m.ArgumentsBegin(); arg != m.ArgumentsEnd(); ++arg)
    {
        if(arg->IsInt32()){
            msg->addInt(arg->AsInt32());
        }
        else if(arg->IsString())
        {
            msg->addString(arg->AsString());
        }
        else if(arg->IsBool())
        {
            msg->addBool(arg->AsBool());
        }
        else if(arg->IsFloat())
        {
            msg->addFloat(arg->AsFloat());
        }
        else if(arg->IsBlob())
        {
            //TODO:
        }

    }
    emit messageReceived(msg);
}
