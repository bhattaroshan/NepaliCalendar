import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Item {
    ListView{
        boundsBehavior: Flickable.StopAtBounds
        width: root.width
        height:	root.height-calendarGrid.height-150
        model: 30
        clip: true
        delegate: Rectangle{
            x: 0
            width: root.width-x*2
            height: 50
            color:"white"
            border.color:"black"
            border.width: 1
            Rectangle{
                x: 5
                anchors.verticalCenter: parent.verticalCenter
                width: height
                height: parent.height-10
                radius: 4
                color:"red"
                Text{
                    text:index+1
                    anchors.centerIn: parent
                }
            }
        }
    }
}
