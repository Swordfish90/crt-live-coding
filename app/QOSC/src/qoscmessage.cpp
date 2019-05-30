#include "qoscmessage.h"

QOSCMessage::QOSCMessage(QString address, QObject *parent):
    QObject(parent),
    _address(address),
    _packet(_buffer, 1024)
{

}

QOSCMessage::~QOSCMessage()
{

}

QOSCMessage* QOSCMessage::add(int value)
{
    addInt(value);
    return this;
}
QOSCMessage* QOSCMessage::addInt(int value)
{
    _arguments << new QOSCArgument_int(value);
    return this;
}
QOSCMessage* QOSCMessage::add(QString value)
{
    addString(value);
    return this;
}
QOSCMessage* QOSCMessage::addString(QString value)
{
    _arguments << new QOSCArgument_string(value);
    return this;
}
QOSCMessage* QOSCMessage::add(bool value)
{
    addBool(value);
    return this;
}
QOSCMessage* QOSCMessage::addBool(bool value)
{
    _arguments << new QOSCArgument_bool(value);
    return this;
}

QOSCMessage* QOSCMessage::addT()
{
    add(true);
    return this;
}

QOSCMessage* QOSCMessage::addF()
{
    add(false);
    return this;
}

QOSCMessage* QOSCMessage::add(float value)
{
    _arguments << new QOSCArgument_float(value);
    return this;
}
QOSCMessage* QOSCMessage::addFloat(float value)
{
    add(value);
    return this;
}

QOSCMessage* QOSCMessage::add(QByteArray value)
{
    _arguments << new QOSCArgument_blob(value);
    return this;
}
QOSCMessage* QOSCMessage::addBlob(QByteArray value)
{
    //TODO
    return this;
}

QOSCMessage* QOSCMessage::addImpulse()
{
    _arguments << new QOSCArgument_impulse();
    return this;
}

QOSCMessage* QOSCMessage::addNull()
{
    _arguments << new QOSCArgument_null();
    return this;
}

QOSCMessage *QOSCMessage::addTime(int value)
{
    //TODO
    return this;
}

osc::OutboundPacketStream* QOSCMessage::getPacket()
{
    _packet.Clear();
    _packet << osc::BeginBundleImmediate << osc::BeginMessage(_address.toStdString().c_str());
    foreach(QOSCArgument* argument, _arguments)
    {

        if(argument->_type == QOSCARGUMENT_INT)
        {
            _packet << static_cast<QOSCArgument_int*>(argument)->_value;
        }
        else if(argument->_type == QOSCARGUMENT_FLOAT)
        {
            _packet << (float) static_cast<QOSCArgument_float*>(argument)->_value;
        }
        else if(argument->_type == QOSCARGUMENT_BOOL)

        {
            _packet << static_cast<QOSCArgument_bool*>(argument)->_value;
        }
        else if(argument->_type == QOSCARGUMENT_STRING)
        {
            _packet << static_cast<QOSCArgument_string*>(argument)->_value.toStdString().c_str();
        }
    }


    _packet << osc::EndMessage;
    _packet << osc::EndBundle;
    return &_packet;
}
QVector<QOSCArgument*> QOSCMessage::getArguments()
{
    return _arguments;
}

int QOSCMessage::getSize()
{
    return _arguments.size();
}
QString QOSCMessage::getAddress()
{
    return _address;
}

bool QOSCMessage::isIntArgument(int index)
{
    if(index >= _arguments.size()) return false;
    return _arguments[index]->getType() == QOSCARGUMENT_INT;
}
bool QOSCMessage::isStringArgument(int index)
{
    if(index >= _arguments.size()) return false;
    return _arguments[index]->getType() == QOSCARGUMENT_STRING;
}
bool QOSCMessage::isBoolArgument(int index)
{
    if(index >= _arguments.size()) return false;
    return _arguments[index]->getType() == QOSCARGUMENT_BOOL;
}
bool QOSCMessage::isFloatArgument(int index)
{
    if(index >= _arguments.size()) return false;
    return _arguments[index]->getType() == QOSCARGUMENT_FLOAT;
}
bool QOSCMessage::isBlobArgument(int index)
{
    if(index >= _arguments.size()) return false;
    return _arguments[index]->getType() == QOSCARGUMENT_BLOB;
}
bool QOSCMessage::isImpulseArgument(int index)
{
    if(index >= _arguments.size()) return false;
    return _arguments[index]->getType() == QOSCARGUMENT_IMPULSE;
}
bool QOSCMessage::isNullArgument(int index)
{
    if(index >= _arguments.size()) return false;
    return _arguments[index]->getType() == QOSCARGUMENT_NULL;
}
bool QOSCMessage::isTimeArgument(int index)
{
    if(index >= _arguments.size()) return false;
    return _arguments[index]->getType() == QOSCARGUMENT_TIME;
}

int QOSCMessage::getArgumentAsInt(int index)
{
    return ((QOSCArgument_int*) _arguments[index])->_value;
}
QString QOSCMessage::getArgumentAsString(int index)
{
    return ((QOSCArgument_string*) _arguments[index])->_value;
}
bool QOSCMessage::getArgumentAsBool(int index)
{
    return ((QOSCArgument_bool*) _arguments[index])->_value;
}
float QOSCMessage::getArgumentAsFloat(int index)
{
    return ((QOSCArgument_float*) _arguments[index])->_value;
}
QByteArray QOSCMessage::getArgumentAsBlob(int index)
{
    return ((QOSCArgument_blob*) _arguments[index])->_value;
}

int QOSCMessage::getArgumentAsTime(int index)
{
    return ((QOSCArgument_time*) _arguments[index])->_value;
}

