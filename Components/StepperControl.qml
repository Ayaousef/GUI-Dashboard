import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0

Control {
    id: control
    background: null
    property int value: 0
    property int maximumValue: 100
    property int minimumValue: 0
    property bool isVolume: false  // Determines if it's for volume (percentage) or AC (plain number with °C)

    contentItem: RowLayout {
        spacing: 10
        anchors.centerIn: parent

        IconButton {
            id: decreaseButton
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            icon.source: "qrc:/icons/stepper_icons/right-arrow.svg"
            enabled: value > minimumValue
            onClicked: {
                if (value > minimumValue) {
                    value -= 1  // Decrease by 1 instead of 5
                    if (value < minimumValue) value = minimumValue
                    decreaseIndicator.visible = true
                }
            }

            Text {
                id: decreaseIndicator
                text: "<"
                font.family: Style.fontFamily
                font.pixelSize: 18
                color: "#F44336" // Red
                anchors.centerIn: parent
                visible: value > minimumValue
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: isVolume ? value + "%" : value + "°C"  // Show percentage for volume, °C for AC
            font.pixelSize: 42
            font.family: Style.fontFamily
            color: Style.black50
        }

        IconButton {
            id: increaseButton
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            enabled: value < maximumValue
            onClicked: {
                if (value < maximumValue) {
                    value += 1  // Increase by 1 instead of 5
                    if (value > maximumValue) value = maximumValue
                    increaseIndicator.visible = true
                }
            }

            Text {
                id: increaseIndicator
                text: ">"
                font.family: Style.fontFamily
                font.pixelSize: 18
                color: "#4CAF50" // Green
                anchors.centerIn: parent
                visible: value < maximumValue
            }
        }
    }
}
