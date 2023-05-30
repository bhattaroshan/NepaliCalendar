import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {

    property var calendarMonths : [
        "a}zfv​","h]7​","c;/​",">fjg","ebf}","c;f]h","sflt{s​​","dlª\;/​","k';​","df3","kmn\\u'g​","r}q​"
    ]

    id:root
    width: 500
    height: 900
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
            }

            Repeater{
                model: 12
                delegate:
                    CalendarTemplate{
                    currentMonth: calendarMonths[index]
                }
            }

        }
    }
}
