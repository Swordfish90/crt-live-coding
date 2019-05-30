#ifndef QOSCBUNDLE_H
#define QOSCBUNDLE_H
#include <QVector>
#include "qoscmessage.h"

class QOSCBundle
{
public:
    QOSCBundle();
    void addMessage(QOSCMessage *message);
    QVector<QOSCMessage*> getMessages();
private:
    QVector<QOSCMessage*> _messages;
};

#endif // QOSCBUNDLE_H
