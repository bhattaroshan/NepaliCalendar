import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import ApiManager 1.0

ApplicationWindow {
    property int lastMonthIndex : -1
    property int currentMonthIndex : 0
    property bool addAtLast : true
    property bool ex : true

    id:root
    width: 400
    height: 900
    visible: true
    title: qsTr("Nepali Calendar")

    Component.onCompleted: {
        apiManager.sendSignal(0,0);
    }

    ApiManager{
        id:apiManager
        onDataChanged: {
            if(addAtLast === true){
                var t = 0;
                if(ex===false) {
                    t = 6;
                }

                for(var i=t;i<12;++i){
                    var o = {
                        totalDays : apiManager.totalMonthDays[i],
                        startDay: apiManager.startingDayOfMonth[i],
                        currentYear: apiManager.years[i],
                        currentMonth: apiManager.months[i],
                        currentHoliday: apiManager.holiday[i],
                        currentTithi: apiManager.tithi[i],
                        currentRunningDay: apiManager.currentDay,
                        currentRunningMonth: apiManager.currentMonth,
                        currentRunningYear: apiManager.currentYear
                       }
                        listView.model.append(o);
                }
                while(listView.model.count>12){
                    listView.model.remove(0);
                }
                ex = false;
            }else{
                for(var j=6;j>=0;--j){
                    var p = {
                        totalDays : apiManager.totalMonthDays[j],
                        startDay: apiManager.startingDayOfMonth[j],
                        currentYear: apiManager.years[j],
                        currentMonth: apiManager.months[j],
                        currentHoliday: apiManager.holiday[j],
                        currentTithi: apiManager.tithi[j],
                        currentRunningDay: apiManager.currentDay,
                        currentRunningMonth: apiManager.currentMonth,
                        currentRunningYear: apiManager.currentYear
                       }
                        listView.model.insert(0,p);
                }
                while(listView.model.count>12){
                    listView.model.remove(listView.model.count-1);
                }
            }


        }
    }

    ListView{
        anchors.fill:parent
        id: listView
        width:parent.width
        height:parent.height
        model: ListModel{}
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        currentIndex: listView.model.count > 0 ? 6 : 0
        delegate: CalendarTemplate{
            runningIndex: index
            totalDays: model.totalDays
            startDay: model.startDay
            currentYear: model.currentYear
            currentMonth: model.currentMonth
            currentHoliday: model.currentHoliday
            currentTithi: model.currentTithi
            currentRunningDay: model.currentRunningDay
            currentRunningMonth: model.currentRunningMonth
            currentRunningYear: model.currentRunningYear
        }

        onMovementStarted: {
            if(listView.currentIndex<=3 && lastMonthIndex>=listView.currentIndex){
                addAtLast = false;
                var nyear = apiManager.years[0];
                var nmonth = apiManager.months[0];
                nmonth--;
                if(nmonth<0){
                    nmonth=11;
                    nyear--;
                }
                apiManager.sendSignal(nyear,nmonth);
            }else if(listView.currentIndex>=9 && lastMonthIndex<=listView.currentIndex){
                addAtLast = true;
                var myear = apiManager.years[11];
                var mmonth = apiManager.months[11];
                mmonth++;
                if(mmonth>11){
                    mmonth=0;
                    myear++;
                }
                apiManager.sendSignal(myear,mmonth);
            }

            lastMonthIndex = listView.currentIndex;
        }
    }

}
