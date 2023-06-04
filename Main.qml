import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import ApiManager 1.0

ApplicationWindow {
    id:root
    width: 400
    height: 900
    visible: true
    title: qsTr("Nepali Calendar")

    Component.onCompleted: {
        apiManager.sendSignal(0);
    }

    ApiManager{
        id:apiManager
    }

    ColumnLayout{
        width:parent.width
        height:parent.height
        SwipeView{
            id: view
            currentIndex: apiManager.currentMonth
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height

            Repeater{
                model: 12
                delegate:
                    CalendarTemplate{
                    currentMonthIndex: index
                    totalDays: apiManager.totalMonthDays[index]
                    startDay: apiManager.startingDayOfMonth[index]
                    currentRunningDay: apiManager.currentDay
                    currentRunningMonth: apiManager.currentMonth
                    currentRunningYear: apiManager.currentYear
                }

            }
        }
    }
}
