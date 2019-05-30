#-------------------------------------------------
#
# Project created by QtCreator 2015-04-02T15:53:12
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = example-send
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h
include(../../QOSC.pri)

