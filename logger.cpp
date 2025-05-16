#include "logger.h"
#include "qdebug.h"
#include <QDateTime>

Logger::Logger(QObject *parent)
    : QObject(parent)
{
    QString filePath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/output.txt";

    outputFile.setFileName(filePath);
    if (outputFile.open(QIODevice::WriteOnly | QIODevice::Text)) {
        outStream.setDevice(&outputFile);
        outStream << "=== Logging Started at: " << QDateTime::currentDateTime().toString() << " ===" << Qt::endl;
    } else {
        qWarning() << "❌ Failed to open file for writing:" << filePath;
    }
}

void Logger::logMessage(const QString &message)
{
    outStream << QDateTime::currentDateTime().toString("hh:mm:ss") << ": " << message << Qt::endl;
    outStream.flush(); // مهم
}
