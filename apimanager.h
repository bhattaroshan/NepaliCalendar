#ifndef APIMANAGER_H
#define APIMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class ApiManager:public QObject
{
    Q_OBJECT

    Q_PROPERTY(int currentYear READ currentYear NOTIFY dataChanged);
    Q_PROPERTY(int currentMonth READ currentMonth NOTIFY dataChanged);
    Q_PROPERTY(int currentDay READ currentDay NOTIFY dataChanged);
    Q_PROPERTY (QVector<int> totalMonthDays READ totalMonthDays NOTIFY dataChanged);
    Q_PROPERTY (QVector<int> startingDayOfMonth READ startingDayOfMonth NOTIFY dataChanged);

public:
    ApiManager();
    void initializeDataHolder();
    Q_INVOKABLE void sendSignal(const QString s);
    int currentYear();
    int currentMonth();
    int currentDay();
    QVector<int> totalMonthDays();
    QVector<int> startingDayOfMonth();

private:
    int m_currentYear;
    int m_currentMonth;
    int m_currentDay;
    QVector<int> m_totalMonthDays;
    QVector<int> m_startingDayOfMonth;

signals:
    void dataChanged();
public slots:
    void handleReply(QNetworkReply *reply);
};

#endif // APIMANAGER_H
