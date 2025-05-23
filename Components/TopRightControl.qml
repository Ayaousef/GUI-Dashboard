import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0

RowLayout {
    spacing: 48
    property int temp: 23
    property bool airbagOn: false

    // Text for displaying time and date
    Text {
        id: timeDateText
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        text: "" // Will be updated by the Timer
        font.family: "Inter"
        font.pixelSize: 18
        font.bold: Font.DemiBold
        color: "darkblue" // تغيير اللون إلى الأزرق الداكن

        // Timer to update time and date every second
        Timer {
            interval: 1000 // 1000 ms = 1 second
            running: true
            repeat: true
            onTriggered: {
                var currentDate = new Date();
                // Format time as "14:35:22" and date as "18/3/2025"
                var timeString = Qt.formatTime(currentDate, "HH:mm:ss"); // e.g., "14:35:22"
                var dateString = Qt.formatDate(currentDate, "dd/M/yyyy"); // e.g., "18/3/2025"
                timeDateText.text = timeString + "   " + dateString;
            }
        }

        // Initialize the time and date when the component is created
        Component.onCompleted: {
            var currentDate = new Date();
            var timeString = Qt.formatTime(currentDate, "HH:mm:ss");
            var dateString = Qt.formatDate(currentDate, "dd/M/yyyy");
            timeDateText.text = timeString + "   " + dateString;
        }
    }

    Text {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        text: "%0ºC".arg(temp)
        font.family: "Inter"
        font.pixelSize: 18
        font.bold: Font.DemiBold
        color: "darkblue" // تغيير اللون إلى الأزرق الداكن
    }

    Control {
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        implicitHeight: 38
        background: Rectangle {
            color: Style.isDark ? Style.alphaColor(Style.black,0.55) : Style.black20
            radius: 7
        }
        contentItem: RowLayout {
            spacing: 10
            anchors.centerIn: parent
            Image {
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.leftMargin: 10
                source: "qrc:/icons/top_header_icons/airbag_.svg"
            }
            Text {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.rightMargin: 10
                text: airbagOn ? "PASSENGER\nAIRBAG ON" : "PASSENGER\nAIRBAG OFF"
                font.family: Style.fontFamily
                font.bold: Font.Bold
                font.pixelSize: 12
                color: Style.white
            }
        }
    }
}
