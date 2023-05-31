#include "apimanager.h"

ApiManager::ApiManager()
{
}

void ApiManager::sendSignal()
{
    QNetworkRequest request(QUrl("http://192.168.0.104:8001/2070"));
    QNetworkAccessManager *m_networkManager = new QNetworkAccessManager(this);
    m_networkManager->get(request);
    connect(m_networkManager, &QNetworkAccessManager::finished, this, &ApiManager::handleReply);
}

void ApiManager::handleReply(QNetworkReply *reply)
{
    if (reply->error() == QNetworkReply::NoError)
    {
        QString response = reply->readAll();
        emit requestCompleted(response);
    }
    else
    {
        qDebug() << "Error: " << reply->errorString();
        emit requestCompleted("error");
    }

    reply->deleteLater();
}
