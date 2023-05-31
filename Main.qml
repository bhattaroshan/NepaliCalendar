import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import ApiManager 1.0

ApplicationWindow {

    property var calendarMonths : [
        "a}zfv​","h]7​","c;/​",">fjg","ebf}","c;f]h","sflt{s​​","dlª\;/​","k';​","df3","kmn\\u'g​","r}q​"
    ]

    property var yearInfo : null

    id:root
    width: 400
    height: 900
    visible: true
    title: qsTr("Nepali Calendar")

    Component.onCompleted: {
        apiManager.sendSignal();
    }


    ApiManager{
        id:apiManager
        onRequestCompleted: (response)=> {
            //console.log("My response is = ",response);
            yearInfo = JSON.parse(response);
            //console.log(jsonString.year);
            //console.log(response);
//            for(let [key,value] of Object.entries(jsonString)){
//                console.log(typeof key,value);
//            }

        }
    }

    ColumnLayout{
        width:parent.width
        height:parent.height
        SwipeView{
            id: view
            currentIndex: 0
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height

            Repeater{
                model: 12
                delegate:
                    CalendarTemplate{
                    currentMonth: calendarMonths[index]
                    totalDays: {
                        //console.log(yearInfo[String(index)]);
                        if(yearInfo!==null){
                            return yearInfo[String(index)];
                        }else{
                            return 0;
                        }

                    }

                }
            }

        }
    }
}
