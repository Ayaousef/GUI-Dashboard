#ifndef LOGGER_H
#define LOGGER_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QStandardPaths>

class Logger : public QObject
{
    Q_OBJECT
public:
    explicit Logger(QObject *parent = nullptr);

    Q_INVOKABLE void logMessage(const QString &message);

private:
    QFile outputFile;
    QTextStream outStream;
};

#endif // LOGGER_H
