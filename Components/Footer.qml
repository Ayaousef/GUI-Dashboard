import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0
import QtGraphicalEffects 1.15

Item {
    height: 120
    width: parent.width
    signal openLauncher()
    signal phoneClicked()
    signal bluetoothClicked()
    signal radioClicked()
    signal spotifyClicked()
    signal dashcamClicked()
    signal tuneinClicked()
    signal musicClicked()
    signal calendarClicked()
    signal zoomClicked()
    signal messagesClicked()

    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(0, 1000)
        gradient: Gradient {
            GradientStop { position: 0.0; color: Style.black }
            GradientStop { position: 1.0; color: Style.black60 }
        }
    }

    Icon {
        id: leftControl
        icon.source: "qrc:/icons/app_icons/model-3.svg"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 36
        onClicked: openLauncher()
    }

    // Left StepperControl (AC in Celsius)
    Item {
        height: parent.height
        anchors.left: leftControl.right
        anchors.right: middleLayout.left
        anchors.verticalCenter: parent.verticalCenter

        StepperControl {
            anchors.centerIn: parent
            value: 22          // Default temperature in Celsius
            minimumValue: 15   // Minimum AC temperature (15°C)
            maximumValue: 30   // Maximum AC temperature (30°C)
            isVolume: false    // Plain number for AC with °C
        }
    }

    RowLayout {
        id: middleLayout
        anchors.centerIn: parent
        spacing: 20

        Icon {
            id: phoneIcon
            icon.source: "qrc:/icons/app_icons/phone.svg"
            width: 48
            height: 48
            MouseArea {
                anchors.fill: parent
                onClicked: phoneClicked()
            }
        }

        Icon {
            id: radioIcon
            icon.source: "qrc:/icons/app_icons/radio.svg"
            width: 48
            height: 48
            MouseArea {
                anchors.fill: parent
                onClicked: radioClicked()
            }
        }

        Icon {
            id: bluetoothIcon
            icon.source: "qrc:/icons/app_icons/bluetooth.svg"
            width: 48
            height: 48
            MouseArea {
                anchors.fill: parent
                onClicked: bluetoothClicked()
            }
        }

        Icon {
            id: spotifyIcon
            icon.source: "qrc:/icons/app_icons/spotify.svg"
            width: 48
            height: 48
            MouseArea {
                anchors.fill: parent
                onClicked: spotifyClicked()
            }
        }

        Icon {
            id: dashcamIcon
            icon.source: "qrc:/icons/app_icons/dashcam.svg"
            width: 48
            height: 48
            MouseArea {
                anchors.fill: parent
                onClicked: dashcamClicked()
            }
        }

        Icon {
            id: musicIcon
            icon.source: "qrc:/icons/app_icons/volume.svg"
            width: 48
            height: 48
            MouseArea {
                anchors.fill: parent
                onClicked: musicClicked()
            }
        }

        Icon {
            id: tuneinIcon
            icon.source: "qrc:/icons/app_icons/tunein.svg"
            width: 48
            height: 48
            MouseArea {
                anchors.fill: parent
                onClicked: tuneinClicked()
            }
        }

        Item {
            id: calendarIcon
            width: 48
            height: 48

            Rectangle {
                anchors.fill: parent
                color: Style.isDark ? "#ffffff" : "#ffffff"
                border.color: Style.isDark ? "#616161" : "#e0e0e0"
                border.width: 1
                radius: 5

                Column {
                    anchors.fill: parent

                    Rectangle {
                        width: parent.width
                        height: 10
                        color: "#d32f2f"
                        Row {
                            anchors.fill: parent
                            spacing: 0
                            Repeater {
                                model: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                                Text {
                                    width: parent.width / 7
                                    height: parent.height
                                    text: modelData
                                    font.family: "Inter"
                                    font.pixelSize: 6
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    color: "#ffffff"
                                }
                            }
                        }
                    }

                    Text {
                        width: parent.width
                        height: parent.height - 10
                        text: new Date().getDate()
                        font.family: "Inter"
                        font.pixelSize: 22
                        font.bold: Font.Bold
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: Style.isDark ? "#424242" : "#424242"
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: calendarClicked()
            }
        }

        Icon {
            id: zoomIcon
            icon.source: "qrc:/icons/app_icons/zoom.svg"
            width: 48
            height: 48
            MouseArea {
                anchors.fill: parent
                onClicked: zoomClicked()
            }
        }

        Icon {
            id: messagesIcon
            icon.source: "qrc:/icons/app_icons/messages.svg"
            width: 48
            height: 48
            MouseArea {
                anchors.fill: parent
                onClicked: messagesClicked()
            }
        }
    }

    // Middle-right StepperControl (AC in Celsius)
    Item {
        height: parent.height
        anchors.right: rightControl.left
        anchors.left: middleLayout.right
        anchors.verticalCenter: parent.verticalCenter

        StepperControl {
            anchors.centerIn: parent
            value: 22          // Default temperature in Celsius
            minimumValue: 15   // Minimum AC temperature (15°C)
            maximumValue: 30   // Maximum AC temperature (30°C)
            isVolume: false    // Plain number for AC with °C
        }
    }

    // Right StepperControl (Volume)
    StepperControl {
        id: rightControl
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 36
        value: 50
        minimumValue: 0    // Volume range remains 0-100
        maximumValue: 100
        isVolume: true     // Percentage for volume
    }
}
