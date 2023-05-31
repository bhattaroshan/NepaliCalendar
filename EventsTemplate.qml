import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ListView{
    width: root.width
    height:	root.height-calendarGrid.height-150
    model: 20
    clip: true
    delegate: Rectangle{
        id:eventBox
        width: root.width
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
            color:"#158b99"
            border.width: 1
            border.color:"black"
            Text{
                text:index+1
                anchors.centerIn: parent
            }
        }

        MouseArea{
            anchors.fill: parent
            onPressed: {
                eventBox.color="grey";
            }
            onReleased:{
                eventBox.color="white";
            }
            onCanceled: {
                eventBox.color="white";
            }
        }

    }
}
