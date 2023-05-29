import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id:root
    width: 800
    height: 700
    visible: true
    title: qsTr("Nepali Calendar")

    ColumnLayout{
        anchors.fill:parent
        SwipeView{
            id: view
            currentIndex: 1
            anchors.fill:parent
            CalendarTemplate{
                signal clickButton()
            }
            CalendarTemplate{
            }
            CalendarTemplate{
            }
            CalendarTemplate{
            }
        }

        PageIndicator {
            count: view.count
            currentIndex: view.currentIndex
            anchors.top: root.bottom
            anchors.horizontalCenter: root.horizontalCenter
            visible:false
        }
    }
}
