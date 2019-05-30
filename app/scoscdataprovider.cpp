#include "scoscdataprovider.h"
#include <QDebug>

SCOSCDataProvider::SCOSCDataProvider(QObject *parent) : QObject(parent),
    oscReceiver(new QOSCReceiver(7089, this))
{
    connect(oscReceiver, SIGNAL(messageReceived(QOSCMessage*)), this, SLOT(onMessageReceived(QOSCMessage*)));
    oscReceiver->start();
}

void SCOSCDataProvider::onMessageReceived(QOSCMessage* message)
{
//    qDebug() << "Message received!";
    //qDebug() << message->getAddress();

    if (message->getAddress() == "/scdata") {
        float loudness = message->getArgumentAsFloat(1);
        float flat = message->getArgumentAsFloat(3);
        float centroid = message->getArgumentAsFloat(5);

        emit newData(loudness, flat, centroid);
    }

//    if (message->getAddress() == "/debug/loud") {
//        float loudness = message->getArgumentAsFloat(0);
//        emit newLoudness(loudness);
//    }

//    if (message->getAddress() == "/s_new") {
//        if (message->isStringArgument(0)) {
//            if (message->getArgumentAsString(0) == "makeSound" || message->getArgumentAsString(0) == "startSound")
//                return;

//            if (message->getArgumentAsString(0).startsWith("play") && message->isFloatArgument(11)) {
//                emit newSampleSound(message->getArgumentAsFloat(11), extractAmplitudeFromMessage(message));
//            } else {
//                emit newSynthSound(message->getArgumentAsString(0), extractAmplitudeFromMessage(message));
//            }
//        }
//    }

////     Print every argument
//    for (int i = 0; i < message->getSize(); i++){
//        if(message->isIntArgument(i))
//        {
//            qDebug()<<"arg int"<<i<<message->getArgumentAsInt(i);
//        }
//        else if(message->isStringArgument(i))
//        {
//            qDebug()<<"arg str"<<i<<message->getArgumentAsString(i);
//        }
//        else if(message->isBoolArgument(i))
//        {
//            qDebug()<<"arg bool"<<i<<message->getArgumentAsBool(i);
//        }
//        else if(message->isFloatArgument(i))
//        {
//            qDebug()<<"arg float"<<i<<message->getArgumentAsFloat(i);
//        }
//        }
}
