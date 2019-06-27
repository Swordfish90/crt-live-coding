QT += qml quick widgets sql
TARGET = crt-live-coding
CONFIG += c++11

include(QOSC/QOSC.pri)

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

DESTDIR = $$OUT_PWD/../

HEADERS += \
    fileio.h \
    scoscdataprovider.h \
    monospacefontmanager.h

SOURCES += main.cpp \
    fileio.cpp \
    scoscdataprovider.cpp \
    monospacefontmanager.cpp

macx:ICON = icons/crt.icns

RESOURCES += qml/resources.qrc

#########################################
##              INTALLS
#########################################

target.path += /usr/bin/

INSTALLS += target

# Install icons
unix {
    icon32.files = icons/32x32/cool-retro-term.png
    icon32.path = /usr/share/icons/hicolor/32x32/apps
    icon64.files = icons/64x64/cool-retro-term.png
    icon64.path = /usr/share/icons/hicolor/64x64/apps
    icon128.files = icons/128x128/cool-retro-term.png
    icon128.path = /usr/share/icons/hicolor/128x128/apps
    icon256.files = icons/256x256/cool-retro-term.png
    icon256.path = /usr/share/icons/hicolor/256x256/apps

    INSTALLS += icon32 icon64 icon128 icon256
}
