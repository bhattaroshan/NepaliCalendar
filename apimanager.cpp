#include "apimanager.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

ApiManager::ApiManager()
{
    initializeDataHolder();
}

void ApiManager::initializeDataHolder()
{
    m_holiday.clear();
    m_tithi.clear();
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
    //QNetworkRequest request(QUrl("http://localhost:8001/"+y+"/"+m));
    QNetworkRequest request(QUrl("http://192.168.0.103:8001/"+y+"/"+m));
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

        //QJsonObject obj = jsonDocument.object();
        for(int i=0;i<12;++i){
            QJsonArray eventsArr =jsonDocument["events"][QString::number(i)].toArray();
            QVector<int> t_holiday;
            QVector<QString> t_tithi;
            for(int j=0;j<eventsArr.size();++j){
                //int day = eventsArr[j].toObject().value("day").toInt();
                int holiday = eventsArr[j].toObject().value("holiday").toInt();
                QString str = eventsArr[j].toObject().value("tithi").toString();
                //QString tithi = eventsArr[j].toObject().value("tithi").toString();
                t_holiday.push_back(holiday);
                t_tithi.push_back(str);
            }
            m_holiday.push_back(t_holiday);
            m_tithi.push_back(t_tithi);
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

QVector<QVector<int> > ApiManager::holiday()
{
    return m_holiday;
}

QVector<QVector<QString> > ApiManager::tithi()
{
    return m_tithi;
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


