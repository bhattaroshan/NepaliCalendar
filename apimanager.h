#ifndef APIMANAGER_H
#define APIMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class ApiManager:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<int> months READ getMonths CONSTANT);


public:
    ApiManager();
    Q_INVOKABLE void sendSignal();
    QVector<int> getMonths(){return m_data;}
    QVector<int> getStartingDays(){return m_startingDay;}

private:
    QVector<int> m_data;
    QVector<int> m_startingDay;


signals:
    void requestCompleted(const QString &response, const QVector<int> &data, const QVector<int> &startingDay);

public slots:
    void handleReply(QNetworkReply *reply);
};

#endif // APIMANAGER_H
