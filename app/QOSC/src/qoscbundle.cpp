#include "qoscbundle.h"

QOSCBundle::QOSCBundle()
{
}
void QOSCBundle::addMessage(QOSCMessage *message)
{
    _messages << message;
}

QVector<QOSCMessage*> QOSCBundle::getMessages()
{
    return _messages;
}
