import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import ApiManager 1.0

ApplicationWindow {
    property int lastMonthIndex : 0
    property int currentMonthIndex : 0

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

    ListView{
        id: listView
        width:parent.width
        height:parent.height
        model: 12
        //currentIndex: apiManager.currentMonth
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        delegate: CalendarTemplate{
            currentMonthIndex: index
            totalDays: apiManager.totalMonthDays[index]
            startDay: apiManager.startingDayOfMonth[index]
            currentRunningDay: apiManager.currentDay
            currentRunningMonth: apiManager.currentMonth
            currentRunningYear: apiManager.currentYear
        }
        onMovementEnded: {
            var currentProgress = listView.contentX;
            lastMonthIndex = currentMonthIndex;
            currentMonthIndex = Math.floor(currentProgress/listView.width);

            if(currentMonthIndex === 0 && lastMonthIndex === 0){ //then baisakh is reached switch to previous year
                console.log("I was called from zero");
                apiManager.sendSignal(apiManager.currentYear-1);
                listView.contentX = listView.contentWidth-listView.width;
            }

            if(currentMonthIndex === 11 && lastMonthIndex === 11){ //then baisakh is reached switch to previous year
                console.log("I was called from zero");
                apiManager.sendSignal(apiManager.currentYear+1);
                listView.contentX = 0;
            }
        }

        Component.onCompleted: {
            console.log("i was called here");
        }
    }


    //    ColumnLayout{
    //        width:parent.width
    //        height:parent.height
    //        SwipeView{
    //            id: view
    //            currentIndex: apiManager.currentMonth
    //            Layout.preferredWidth: parent.width
    //            Layout.preferredHeight: parent.height

    //            Repeater{
    //                model: 12
    //                delegate:
    //                    CalendarTemplate{
    //                    currentMonthIndex: index
    //                    totalDays: apiManager.totalMonthDays[index]
    //                    startDay: apiManager.startingDayOfMonth[index]
    //                    currentRunningDay: apiManager.currentDay
    //                    currentRunningMonth: apiManager.currentMonth
    //                    currentRunningYear: apiManager.currentYear
    //                }

    //            }
    //        }
    //    }
}
