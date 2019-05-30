#-------------------------------------------------
#
# Project created by QtCreator 2016-01-18T15:13:11
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = example-receive
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

include(../../QOSC.pri)
