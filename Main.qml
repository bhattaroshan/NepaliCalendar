import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {

    property var calendarMonths : [
        "a}zfv​","h]7​","c;/​",">fjg","ebf}","c;f]h","sflt{s​​","dlª\;/​","k';​","df3","kmn\\u'g​","r}q​"
    ]

    id:root
    width: 800
    height: 700
    visible: true
    title: qsTr("Nepali Calendar")

    ColumnLayout{
        anchors.fill:parent
        SwipeView{
            id: view
            currentIndex: 0
            Layout.fillHeight: true
            Layout.fillWidth: true
            onVisibleChanged: {
                console.log(currentIndex," from visible");
            }
            onWindowChanged: {
                console.log("test from x");
            }


//            onCurrentIndexChanged: {

//                console.log(currentIndex);
//                if (currentIndex === count - 1) {
//                               swipeView.currentIndex = 0; // Wrap to the first item
//                           } else if (currentIndex === 0) {
//                               swipeView.currentIndex = count - 1; // Wrap to the last item
//                           }
//            }

            Repeater{
                model: 12
                delegate: CalendarTemplate{
                    currentMonth: calendarMonths[index]
                }
            }

        }

//        PageIndicator {
//            count: view.count
//            currentIndex: {
//                var currentIndex =  view.currentIndex
//                if(currentIndex===count-1)	{
//                    view.currentIndex = 0;
//                }else if(currentIndex===0){
//                    view.currentIndex = count-1;
//                }

//                return currentIndex
//            }
//            anchors.top: root.bottom
//            anchors.horizontalCenter: root.horizontalCenter
//            visible:false
//        }
    }
}
