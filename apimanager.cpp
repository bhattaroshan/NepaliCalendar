#include "apimanager.h"
#include <QJsonDocument>

ApiManager::ApiManager()
{
    initializeDataHolder();
}

void ApiManager::initializeDataHolder()
{
    m_totalMonthDays.resize(12);
    m_totalMonthDays.fill(0);
    m_startingDayOfMonth.resize(12);
    m_startingDayOfMonth.fill(0);
    m_years.resize(12);
    m_years.fill(0);
    m_months.resize(12);
    m_months.fill(0);

    m_currentYear = 0;
    m_currentMonth = 0;
    m_currentDay = 0;

}

void ApiManager::sendSignal(const QString y,const QString m)
{
    initializeDataHolder();
    //QNetworkRequest request(QUrl("http://192.168.0.104:8001/1992"));
    QNetworkRequest request(QUrl("http://localhost:8001/"+y+"/"+m));
    //QNetworkRequest request(QUrl("http://192.168.10.80:8001/"+s));
    QNetworkAccessManager *m_networkManager = new QNetworkAccessManager(this);
    m_networkManager->get(request);
    connect(m_networkManager, &QNetworkAccessManager::finished, this, &ApiManager::handleReply);
}

void ApiManager::handleReply(QNetworkReply *reply)
{
    if (reply->error() == QNetworkReply::NoError)
    {
        QString response = reply->readAll();
        QJsonDocument jsonDocument = QJsonDocument::fromJson(response.toUtf8());
        int start = jsonDocument["start"].toInt();

        m_currentYear = jsonDocument["year"].toInt();

        m_currentMonth = jsonDocument["month"].toInt();

        m_currentDay = jsonDocument["day"].toInt();

        int currentSum = start;
        for(int i=0;i<12;++i){
            int v = jsonDocument["month_days"][QString::number(i)].toInt();
            m_startingDayOfMonth[i]=currentSum%7;
            currentSum += v;
            m_totalMonthDays[i]=v;
        }
        for(int i=0;i<12;++i){
            int v = jsonDocument["years"][QString::number(i)].toInt();
            m_years[i] = v;
        }
        for(int i=0;i<12;++i){
            int v = jsonDocument["months"][QString::number(i)].toInt();
            m_months[i] = v;
        }

        m_jresponse = response;

        emit dataChanged();
    }
    else
    {
        qDebug() << "Error: " << reply->errorString();
    }

    reply->deleteLater();
}

int ApiManager::currentYear()
{
    return m_currentYear;
}

int ApiManager::currentMonth()
{
    return m_currentMonth;
}

int ApiManager::currentDay()
{
    return m_currentDay;
}

QVector<int> ApiManager::years()
{
    return m_years;
}

QVector<int> ApiManager::months()
{
    return m_months;
}

QString ApiManager::jresponse()
{
    return m_jresponse;
}

QVector<int> ApiManager::totalMonthDays()
{
    return m_totalMonthDays;
}

QVector<int> ApiManager::startingDayOfMonth()
{
    return m_startingDayOfMonth;
}


