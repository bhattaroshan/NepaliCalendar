import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Item {

    property var currentMonth : ""

    property int monthCounter : 0
    property var calendarNumbers : [
        "!","@","#","$","%","^","&","*","(","!)", //till 10
        "!!","!@","!#","!$","!%","!^","!&","!*","!(","@)", //till 20
        "@!","@@","@#","@$","@%","@^","@&","@*","@(","#)", //till 30
        "#!","#@","##","#$","#%","#^","#&","#*","#(","$)", //till 40
        "$!","$@","$#","$$","$%","$^","$&","$*","$(","%)", //till 50
    ]

    property var calendarDays : [
        "cfOt",";f]d","dªn​","a'w​","lalx​","z'qm​","zlg​"
    ]



    Column{
        Rectangle{
            id:monthBar
            width: root.width
            height: root.height/10
            color:"#545d66"
            RowLayout{
                anchors.fill: parent

                Rectangle{
                    Layout.leftMargin: 10
                    Layout.alignment: Qt.AlignVCenter
                    width:monthBar.height/1.5
                    height:monthBar.height/1.5
                    radius:monthBar.height/(1.5*2)
                    color:"gray"

                    Image{
                        width:monthBar.height/2
                        height: monthBar.height/2
                        anchors.centerIn: parent
                        source: "/assets/icons/left_icon.png"

                        MouseArea{
                            anchors.fill:parent
                        }
                    }
                }

                Text{
                    text: currentMonth
                    font.bold: true
                    font.pointSize: 40
                    color:"white"
                    font.family: aakritiFont.font.family
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }

                Rectangle{
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignVCenter
                    width:monthBar.height/1.5
                    height:monthBar.height/1.5
                    radius:monthBar.height/(1.5*2)
                    color:"gray"

                    Image{
                        width:monthBar.height/2
                        height: monthBar.height/2
                        rotation: 180
                        anchors.centerIn: parent
                        source: "/assets/icons/left_icon.png"

                        MouseArea{
                            anchors.fill:parent

                        }
                    }
                }


            }

        }
        Row{
            Repeater{
                model:7
                delegate:Rectangle{
                    width: root.width/7
                    height: 50
                    color:"#5F5F6F"
                    border.width: 1
                    border.color:"black"

                    Text{
                        text: calendarDays[index]
                        font.family: aakritiFont.font.family
                        font.pointSize: 20
                        anchors.centerIn: parent
                        color:"white"
                    }
                }
            }
        }

        GridView{
            interactive: false
            id:calendarGrid
            width:root.width
            height:root.height
            cellWidth: root.width/7
            cellHeight: root.width/7
            model: 35
            delegate: Rectangle{
                id: dateBox
                width: calendarGrid.cellWidth
                height: calendarGrid.cellHeight
                color: (index+1)%7===0?"#fd7758":"white"
                border.width: 1
                border.color: "black"

                Text{
                    text:calendarNumbers[index]
                    font.family: aakritiFont.font.family
                    font.pointSize: 40
                    color: (index+1)%7===0?"white":"black"
                    anchors.centerIn: dateBox
                }

            }
        }
    }

    FontLoader{
        id:aakritiFont
        source: "/assets/fonts/aakriti_regular.ttf"
    }
}
