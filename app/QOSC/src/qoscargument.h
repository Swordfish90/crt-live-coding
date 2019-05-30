#ifndef QOSCARGUMENT_H
#define QOSCARGUMENT_H
#include <QString>
typedef enum
{
    QOSCARGUMENT_INT,
    QOSCARGUMENT_FLOAT,
    QOSCARGUMENT_STRING,
    QOSCARGUMENT_BLOB,
    QOSCARGUMENT_BOOL,
    QOSCARGUMENT_NULL,
    QOSCARGUMENT_IMPULSE,
    QOSCARGUMENT_TIME
} QOSCArgumentType;

class QOSCArgument
{
public:
    QOSCArgument(QOSCArgumentType type = QOSCARGUMENT_NULL):
        _type(type)
    {
    }
    QOSCArgumentType getType()
    {
        return _type;
    }

//protected:
    QOSCArgumentType _type;
};

class QOSCArgument_int : public QOSCArgument
{
public:
    QOSCArgument_int(int value = 0) :
        QOSCArgument(QOSCARGUMENT_INT),
        _value(value)
    {
    }
//private:
    int _value;
};
class QOSCArgument_float : public QOSCArgument
{
public:
    QOSCArgument_float(float value = 0) :
        QOSCArgument(QOSCARGUMENT_FLOAT),
        _value(value)
    {
    }
//private:
    float _value;
};
class QOSCArgument_string : public QOSCArgument
{
public:
    QOSCArgument_string(QString value = "") :
        QOSCArgument(QOSCARGUMENT_STRING),
        _value(value)
    {
    }
//private:
    QString _value;
};
class QOSCArgument_blob : public QOSCArgument
{
public:
    QOSCArgument_blob(QByteArray value) :
        QOSCArgument(QOSCARGUMENT_BLOB),
        _value(value)
    {
    }
//private:
    QByteArray _value;
};
class QOSCArgument_bool : public QOSCArgument
{
public:
    QOSCArgument_bool(bool value = false) :
        QOSCArgument(QOSCARGUMENT_BOOL),
        _value(value)
    {
    }
//private:
    bool _value;
};
class QOSCArgument_impulse : public QOSCArgument
{
public:
    QOSCArgument_impulse() :
        QOSCArgument(QOSCARGUMENT_IMPULSE)
    {
    }
};
class QOSCArgument_null : public QOSCArgument
{
public:
    QOSCArgument_null() :
        QOSCArgument(QOSCARGUMENT_NULL)
    {
    }
};
class QOSCArgument_time : public QOSCArgument
{
public:
    QOSCArgument_time(int value) :
        QOSCArgument(QOSCARGUMENT_TIME),
        _value(value)
    {
    }
//private:
    int _value;
};


#endif // QOSCARGUMENT_H
