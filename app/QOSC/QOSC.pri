INCLUDEPATH += $$PWD/libs/oscpack
INCLUDEPATH += $$PWD/src

HEADERS += \
    $$PWD/src/qoscsender.h \
    $$PWD/src/qoscreceiver.h \
    $$PWD/src/qoscargument.h \
    $$PWD/src/qoscbundle.h \
    $$PWD/src/qoscmessage.h
HEADERS +=
HEADERS +=
HEADERS +=

SOURCES += \
    $$PWD/src/qoscbundle.cpp \
    $$PWD/src/qoscsender.cpp \
    $$PWD/src/qoscmessage.cpp \
    $$PWD/src/qoscreceiver.cpp
SOURCES +=
SOURCES +=
SOURCES +=

HEADERS += $$PWD/libs/oscpack/ip/IpEndpointName.h
HEADERS += $$PWD/libs/oscpack/ip/NetworkingUtils.h
HEADERS += $$PWD/libs/oscpack/ip/PacketListener.h
HEADERS += $$PWD/libs/oscpack/ip/TimerListener.h
HEADERS += $$PWD/libs/oscpack/ip/UdpSocket.h
HEADERS += $$PWD/libs/oscpack/osc/MessageMappingOscPacketListener.h
HEADERS += $$PWD/libs/oscpack/osc/OscException.h
HEADERS += $$PWD/libs/oscpack/osc/OscHostEndianness.h
HEADERS += $$PWD/libs/oscpack/osc/OscOutboundPacketStream.h
HEADERS += $$PWD/libs/oscpack/osc/OscPacketListener.h
HEADERS += $$PWD/libs/oscpack/osc/OscPrintReceivedElements.h
HEADERS += $$PWD/libs/oscpack/osc/OscReceivedElements.h
HEADERS += $$PWD/libs/oscpack/osc/OscTypes.h

unix {
    SOURCES += $$PWD/libs/oscpack/ip/posix/NetworkingUtils.cpp
    SOURCES += $$PWD/libs/oscpack/ip/posix/UdpSocket.cpp
} else {
    SOURCES += $$PWD/libs/oscpack/ip/win32/NetworkingUtils.cpp
    SOURCES += $$PWD/libs/oscpack/ip/win32/UdpSocket.cpp
}
                         
SOURCES += $$PWD/libs/oscpack/ip/IpEndpointName.cpp
SOURCES += $$PWD/libs/oscpack/osc/OscOutboundPacketStream.cpp
SOURCES += $$PWD/libs/oscpack/osc/OscPrintReceivedElements.cpp
SOURCES += $$PWD/libs/oscpack/osc/OscReceivedElements.cpp
SOURCES += $$PWD/libs/oscpack/osc/OscTypes.cpp

DISTFILES += $$PWD/README.md \
    $$PWD/.travis.yml
