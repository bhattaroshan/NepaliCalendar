#ifndef APIMANAGER_H
#define APIMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class ApiManager:public QObject
{
    Q_OBJECT
public:
    ApiManager();
    Q_INVOKABLE void sendSignal();

signals:
    void requestCompleted(const QString &response);

public slots:
    void handleReply(QNetworkReply *reply);
};

#endif // APIMANAGER_H
