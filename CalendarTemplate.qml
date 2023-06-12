import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    property string holidayTextColor : "#f95d94"
    property string saturdayBoxColor : "#f9825d"
    property string saturdayTextColor : "white"
    property string normalTextColor : "black"
    property string normalBoxColor : "white"
    property string tithiTextColor : "grey"
    property string currentDayBoxColor : "#969de0";

    Component.onCompleted: {
        var events = JSON.parse(apiManager.jresponse)["events"];
        currentEvents = events[apiManager.months[runningIndex]];
    }
    property var currentEvents : null
    property int runningIndex : 0
    property int totalDays : 0
    property int startDay : 0
    property int currentRunningYear : -1
    property int currentRunningMonth : -1
    property int currentRunningDay : -1
    property int monthCounter : 0
    property int currentYear : 0
    property int currentMonth : 0
    property var currentHoliday : null
    property var currentTithi : null



    property var calendarNumbers : [
        "!","@","#","$","%","^","&","*","(","!)", //till 10
        "!!","!@","!#","!$","!%","!^","!&","!*","!(","@)", //till 20
        "@!","@@","@#","@$","@%","@^","@&","@*","@(","#)", //till 30
        "#!","#@","##","#$","#%","#^","#&","#*","#(","$)", //till 40
        "$!","$@","$#","$$","$%","$^","$&","$*","$(","%)", //till 50
    ]

    property var tithiMaps : {
        "Ekadashi":"PsbzL",
        "Dwadashi":"åfbzL",
        "Trayodashi":"qof]bzL",
        "Chaturdashi":"rt'y{L",
        "Aaunshi":"cf}+;L",
        "Pratipada":"k|ltkbf",
        "Ditiya":"lblto",
        "Tritiya":"t[ltof",
        "Chaturthi":"rt'y{L",
        "Panchami":"k~rdL",
        "Sasthi":";i7L",
        "Saptami":";KtdL",
        "Aastami":"ci6dL",
        "Nawami":"gjdL",
        "Dashami":"bzdL",
        "Purnima":"k\"l0f{df"
    }

    property var calendarMonths : [
        "a}zfv​","h]7​","c;/​",">fjg","ebf}","c;f]h","sflt{s​​","dlª\;/​","k';​","df3","kmn\\u'g​","r}q​"
    ]

    property var calendarDays : [
        "cfOt",";f]d","dªn​","a'w​","lalx​","z'qm​","zlg​"
    ]

    function convert(num){
        var n = [")","!","@","#","$","%","^","&","*","("]
        var s = num.toString()
        var res = ""
        for(var i=0;i<s.length;++i){
            res += n[parseInt(s[i])]
        }
        return res;
    }
    width: root.width
    height: root.height
    Column{
        Rectangle{
            id:monthBar
            width: root.width
            height: root.height/12
            color:"#545d66"

            RowLayout{
                width:parent.width
                anchors.verticalCenter: parent.verticalCenter
                spacing: 20
                Text{
                    text: calendarMonths[currentMonth]
                    font.bold: true
                    font.pointSize: 40
                    color:"white"
                    font.family: aakritiFont.font.family
                    Layout.fillWidth: true
                    Layout.leftMargin: 30
                }
                Text{
                    text:convert(currentYear)
                    font.bold: true
                    font.pointSize: 40
                    color: "white"
                    font.family: aakritiFont.font.family
                    Layout.rightMargin: 30
                }
            }
        }

        Row{
            Repeater{
                model:7
                delegate:Rectangle{
                    width: {
                        if((index+1)%7!==0){
                            return Math.floor(root.width/7);
                        }else{
                            var err = root.width-Math.floor(root.width/7)*7;
                            return Math.floor(root.width/7)+err;
                        }
                    }
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
            height:calendarGrid.cellHeight*Math.ceil((startDay+totalDays)/7)
            cellWidth: Math.floor(root.width/7)
            cellHeight: Math.floor(root.width/7)
            model:(startDay+totalDays)+(7-(startDay+totalDays)%7)
            delegate: Rectangle{

                id: dateBox
                width:{
                    if((index+1)%7!==0){
                        return calendarGrid.cellWidth;
                    }else{
                        var err = calendarGrid.width-calendarGrid.cellWidth*7;
                        return calendarGrid.cellWidth+err;
                    }
                }

                height: calendarGrid.cellHeight
                color: {

                    var fColor = normalBoxColor;
                    if(currentRunningDay === index-startDay+1 && currentRunningMonth === currentMonth &&
                            currentRunningYear === currentYear){
                        fColor = currentDayBoxColor;
                    }else if((index+1)%7===0){
                        fColor = saturdayBoxColor;
                    }
                    return fColor;
                }
                border.width: 1
                border.color: "black"
                Text{
                    text:{
                        var cT = currentTithi[index-startDay];
                        return tithiMaps[cT]?tithiMaps[cT]:"";
                    }
                    Layout.alignment: Qt.AlignRight|Qt.AlignTop
                    font.family: aakritiFont.font.family
                    font.pointSize: 12
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 3
                    anchors.topMargin: 3
                    color: {
                        var c = tithiTextColor
                        if((index+1)%7===0){
                            c = normalBoxColor
                        }else if(currentHoliday && currentHoliday[index-startDay]===1){
                            c = holidayTextColor
                        }

                        return c;
                    }
                }

                Text{
                    anchors.centerIn:parent
                    text:{
                        if(index+1>(totalDays+startDay) || index<startDay){
                            return "";
                        }else{
                            return calendarNumbers[index-startDay]
                        }
                    }
                    font.family: aakritiFont.font.family
                    font.pointSize: 25
                    color: {

                        var c = normalTextColor
                        if((index+1)%7===0){
                            c = saturdayTextColor;
                        }
                        else if(currentHoliday && currentHoliday[index-startDay]===1){
                            c = holidayTextColor;
                        }

                        return c;
                    }
                }
            }
        }

        Rectangle{
            width:root.width
            height:root.height/10
            color:"#5F5F6F"
            Text{
                x: 10
                text:"36gfx?"
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 100
                font.family: aakritiFont.font.family
                font.pointSize: 40
                color:"white"
            }
        }

        EventsTemplate{

        }

    }

    FontLoader{
        id:aakritiFont
        source: "/assets/fonts/aakriti_regular.ttf"
    }
}
