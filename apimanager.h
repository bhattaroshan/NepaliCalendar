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
    Q_PROPERTY(QVector<int> years READ years NOTIFY dataChanged);
    Q_PROPERTY(QVector<int> months READ months NOTIFY dataChanged);
    Q_PROPERTY(QString jresponse READ jresponse NOTIFY dataChanged);
    Q_PROPERTY(QVector<QVector<int>> holiday READ holiday NOTIFY dataChanged);
    Q_PROPERTY(QVector<QVector<QString>> tithi READ tithi NOTIFY dataChanged);

public:
    ApiManager();
    void initializeDataHolder();
    Q_INVOKABLE void sendSignal(const QString y, const QString m);
    int currentYear();
    int currentMonth();
    int currentDay();
    QVector<QVector<int>> holiday();
    QVector<QVector<QString>> tithi();
    QVector<int> years();
    QVector<int> months();
    QString jresponse();
    QVector<int> totalMonthDays();
    QVector<int> startingDayOfMonth();

private:
    int m_currentYear;
    int m_currentMonth;
    int m_currentDay;
    QVector<int> m_totalMonthDays;
    QVector<int> m_startingDayOfMonth;
    QVector<int> m_years;
    QVector<int> m_months;
    QString m_jresponse;
    QVector<QVector<int>> m_holiday;
    QVector<QVector<QString>> m_tithi;

signals:
    void dataChanged();
public slots:
    void handleReply(QNetworkReply *reply);
};

#endif // APIMANAGER_H
