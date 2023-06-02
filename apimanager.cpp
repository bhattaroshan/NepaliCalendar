#include "apimanager.h"
#include <QJsonDocument>

ApiManager::ApiManager()
{
}

void ApiManager::sendSignal()
{
    QNetworkRequest request(QUrl("http://localhost:8001/1992"));
    QNetworkAccessManager *m_networkManager = new QNetworkAccessManager(this);
    m_networkManager->get(request);
    connect(m_networkManager, &QNetworkAccessManager::finished, this, &ApiManager::handleReply);
}

void ApiManager::handleReply(QNetworkReply *reply)
{
    m_data.clear();
    m_startingDay.clear();
    if (reply->error() == QNetworkReply::NoError)
    {
        QString response = reply->readAll();
        QJsonDocument jsonDocument = QJsonDocument::fromJson(response.toUtf8());
        int start = jsonDocument["start"].toInt();
        int currentSum = start;
        for(int i=0;i<12;++i){
            int v = jsonDocument["months"][QString::number(i)].toInt();
            m_startingDay.push_back(currentSum%7);
            currentSum += v;

            m_data.push_back(v);
        }

        emit requestCompleted(response,m_data,m_startingDay);
    }
    else
    {
        qDebug() << "Error: " << reply->errorString();
        emit requestCompleted("error",m_data,m_startingDay);
    }

    reply->deleteLater();
}
