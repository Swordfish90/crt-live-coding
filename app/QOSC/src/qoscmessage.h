#ifndef QOSCMESSAGE_H
#define QOSCMESSAGE_H

#include <QObject>
#include <QString>
#include <QVector>

#include "osc/OscOutboundPacketStream.h"
#include "qoscargument.h"

class QOSCMessage : public QObject
{
    Q_OBJECT
public:
    explicit QOSCMessage(QString address, QObject *parent = nullptr);
    virtual ~QOSCMessage();

    QOSCMessage* add(int value);
    QOSCMessage* addInt(int value);
    QOSCMessage* add(QString value);
    QOSCMessage* addString(QString value);
    QOSCMessage* add(bool value);
    QOSCMessage* addBool(bool value);
    QOSCMessage* addT();
    QOSCMessage* addF();
    QOSCMessage* add(float value);
    QOSCMessage* addFloat(float value);
    QOSCMessage* add(QByteArray value);
    QOSCMessage* addBlob(QByteArray value);
    QOSCMessage* addImpulse();
    QOSCMessage* addNull();
    QOSCMessage* addTime(int value);

    osc::OutboundPacketStream* getPacket();
    QVector<QOSCArgument*> getArguments();
    int getSize();
    QString getAddress();

    bool isIntArgument(int index);
    bool isStringArgument(int index);
    bool isBoolArgument(int index);
    bool isFloatArgument(int index);
    bool isBlobArgument(int index);
    bool isImpulseArgument(int index);
    bool isNullArgument(int index);
    bool isTimeArgument(int index);

    int getArgumentAsInt(int index);
    QString getArgumentAsString(int index);
    bool getArgumentAsBool(int index);
    float getArgumentAsFloat(int index);
    QByteArray getArgumentAsBlob(int index);
    int getArgumentAsTime(int index);


private:
    QString _address;
    QVector<QOSCArgument*> _arguments;

    char _buffer[1024];
    osc::OutboundPacketStream _packet;//(_buffer, 1024);
};
#endif // QOSCMESSAGE_H
