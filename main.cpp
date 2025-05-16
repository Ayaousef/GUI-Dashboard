#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSslSocket>
#include <QDebug>
#include "logger.h"

int main(int argc, char *argv[])
{
    qDebug() << "SSL Supported:" << QSslSocket::supportsSsl();
    qDebug() << "SSL Build Version:" << QSslSocket::sslLibraryBuildVersionString();
    qDebug() << "SSL Runtime Version:" << QSslSocket::sslLibraryVersionString();
    QCoreApplication::addLibraryPath("C:/Qt/5.15.18/mingw81_64/OpenSSL-Win64");
    qputenv("QT_SSL_USE_TEMPORARY_KEYCHAIN", "1");

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    Logger logger;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Logger", &logger);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/Style.qml")), "Style", 1, 0, "Style");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);
    logger.logMessage("تم التشغيل من main.cpp");
    return app.exec();
}
