import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.15
import Style 1.0
import QtGraphicalEffects 1.15
import "Components"
import "qrc:/LayoutManager.js" as Responsive

ApplicationWindow {
    id: root
    property var logger: Logger
    property var theme: Style // استخدام Theme بدلاً من Style مباشرة
    property var adaptive: Responsive.AdaptiveLayoutManager.createObject(root, {
        width: root.width,
        height: root.height
    })

    width: 1920
    height: 1200
    visible: true
    title: qsTr("Tesla Screen")

    onWidthChanged: adaptive.updateWindowWidth(width)
    onHeightChanged: adaptive.updateWindowHeight(height)

    FontLoader {
        id: uniTextFont
        source: "qrc:/Fonts/Unitext Regular.ttf"
    }

    // استخدام Loader للخلفية لتجنب إعادة التحميل
    background: Loader {
        anchors.fill: parent
        sourceComponent: theme.mapAreaVisible ? backgroundRect : backgroundImage
    }

    Header {
        id: headerLayout
        z: 99
    }

    footer: Footer {
        id: footerLayout
        onOpenLauncher: launcher.open()
        onPhoneClicked: phonePopup.open()
        onBluetoothClicked: bluetoothPopup.open()
        onRadioClicked: radioPopup.open()
        onSpotifyClicked: spotifyPopup.open()
        onDashcamClicked: dashcamPopup.open()
        onTuneinClicked: tuneinPopup.open()
        onMusicClicked: musicPopup.open()
        onCalendarClicked: calendarPopup.open()
        onZoomClicked: zoomPopup.open()
        onMessagesClicked: messagesPopup.open()
    }

    TopLeftButtonIconColumn {
        z: 99
        anchors {
            left: parent.left
            top: headerLayout.bottom
            leftMargin: 18
        }
    }

    // Test Logger Button
    Button {
        text: "Test Logger"
        anchors {
            bottom: parent.bottom
            right: parent.right
            margins: 20
        }
        z: 1000
        onClicked: {
            logger.logMessage("Test button clicked in QML")
            console.log("Logged message to file")
        }
    }

    // Map Layout
    RowLayout {
        id: mapLayout
        visible: theme.mapAreaVisible
        spacing: 0
        anchors.fill: parent

        Item {
            Layout.preferredWidth: 620
            Layout.fillHeight: true
            Image {
                anchors.centerIn: parent
                source: theme.isDark ? "qrc:/icons/light/sidebar.png" : "qrc:/icons/dark/sidebar-light.png"
            }
        }

        NavigationMapHelperScreen {
            Layout.fillWidth: true
            Layout.fillHeight: true
            runMenuAnimation: true
        }
    }

    // LaunchPad Control
    LaunchPadControl {
        id: launcher
        y: (root.height - height) / 2 + footerLayout.height
        x: (root.width - width) / 2
        onPhoneClicked: phonePopup.open()
        onBluetoothClicked: bluetoothPopup.open()
        onRadioClicked: radioPopup.open()
        onSpotifyClicked: spotifyPopup.open()
        onDashcamClicked: dashcamPopup.open()
        onTuneinClicked: tuneinPopup.open()
        onMusicClicked: musicPopup.open()
        onCalendarClicked: calendarPopup.open()
        onZoomClicked: zoomPopup.open()
        onMessagesClicked: messagesPopup.open()
        onCaraokeClicked: caraokePopup.open()
        onTheaterClicked: theaterPopup.open()
        onToyboxClicked: toyboxPopup.open()
        onFrontDefrostClicked: frontDefrostPopup.open()
        onRearDefrostClicked: rearDefrostPopup.open()
        onLeftSeatClicked: leftSeatPopup.open()
        onHeatedSteeringClicked: heatedSteeringPopup.open()
        onWipersClicked: wipersPopup.open()
    }

    // Background Components
    Component {
        id: backgroundRect
        Rectangle {
            color: "#171717"
            anchors.fill: parent
        }
    }

    Component {
        id: backgroundImage
        Image {
            source: theme.getImageBasedOnTheme()
            Icon {
                icon.source: theme.isDark ? "qrc:/icons/car_action_icons/dark/lock.svg" : "qrc:/icons/car_action_icons/lock.svg"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                    verticalCenterOffset: -350
                    horizontalCenterOffset: 37
                }
            }

            Icon {
                icon.source: theme.isDark ? "qrc:/icons/car_action_icons/dark/Power.svg" : "qrc:/icons/car_action_icons/Power.svg"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                    verticalCenterOffset: -77
                    horizontalCenterOffset: 550
                }
            }

            ColumnLayout {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                    verticalCenterOffset: -230
                    horizontalCenterOffset: 440
                }

                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Trunk"
                    font {
                        family: "Inter"
                        pixelSize: 14
                        bold: Font.DemiBold
                    }
                    color: theme.black20
                }
                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Open"
                    font {
                        family: "Inter"
                        pixelSize: 16
                        bold: Font.Bold
                    }
                    color: theme.isDark ? theme.white : "#171717"
                }
            }

            ColumnLayout {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                    verticalCenterOffset: -180
                    horizontalCenterOffset: -350
                }

                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Frunk"
                    font {
                        family: "Inter"
                        pixelSize: 14
                        bold: Font.DemiBold
                    }
                    color: theme.black20
                }
                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Open"
                    font {
                        family: "Inter"
                        pixelSize: 16
                        bold: Font.Bold
                    }
                    color: theme.isDark ? theme.white : "#171717"
                }
            }
        }
    }

    // Base Popup Component لتجنب التكرار
    Component {
        id: basePopup
        Popup {
            id: popup
            anchors.centerIn: parent
            width: 400
            height: 500
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            padding: 0

            enter: Transition {
                NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200 }
                NumberAnimation { property: "scale"; from: 0.8; to: 1.0; duration: 200 }
            }

            exit: Transition {
                NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 200 }
                NumberAnimation { property: "scale"; from: 1.0; to: 0.8; duration: 200 }
            }

            background: Rectangle {
                color: theme.isDark ? "#212121" : "#fafafa"
                radius: 20
                border.color: theme.isDark ? "#424242" : "#e0e0e0"
                border.width: 1
            }
        }
    }

    // Popup for Phone (Dialer)
      Popup {
          id: phonePopup
          anchors.centerIn: parent
          width: 400
          height: 600
          modal: true
          focus: true
          closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

          Rectangle {
              anchors.fill: parent
              color: Style.isDark ? "#212121" : "#fafafa"
              radius: 20
              border.color: Style.isDark ? "#424242" : "#e0e0e0"
              border.width: 1

              ColumnLayout {
                  anchors.fill: parent
                  spacing: 15

                  Text {
                      id: dialedNumber
                      Layout.alignment: Qt.AlignHCenter
                      Layout.topMargin: 30
                      text: ""
                      font.family: "Inter"
                      font.pixelSize: 36
                      font.bold: Font.Medium
                      color: Style.isDark ? "#ffffff" : "#212121"
                  }

                  GridLayout {
                      columns: 3
                      rowSpacing: 15
                      columnSpacing: 15
                      Layout.alignment: Qt.AlignHCenter

                      Repeater {
                          model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"]
                          Button {
                              width: 80
                              height: 80
                              text: modelData
                              font.pixelSize: 28
                              font.family: "Inter"
                              onClicked: dialedNumber.text += modelData
                              background: Rectangle {
                                  color: Style.isDark ? "#424242" : "#ffffff"
                                  radius: 40
                                  border.color: Style.isDark ? "#616161" : "#e0e0e0"
                                  border.width: 1
                              }
                              contentItem: Text {
                                  text: parent.text
                                  font: parent.font
                                  color: Style.isDark ? "#ffffff" : "#424242"
                                  horizontalAlignment: Text.AlignHCenter
                                  verticalAlignment: Text.AlignVCenter
                              }
                          }
                      }
                  }

                  RowLayout {
                      Layout.alignment: Qt.AlignHCenter
                      Layout.bottomMargin: 20
                      spacing: 10

                      Button {
                          text: "Call"
                          width: 100
                          height: 50
                          background: Rectangle {
                              color: "#4caf50"
                              radius: 25
                          }
                          contentItem: Text {
                              text: parent.text
                              font.family: "Inter"
                              font.pixelSize: 18
                              color: "#ffffff"
                              horizontalAlignment: Text.AlignHCenter
                              verticalAlignment: Text.AlignVCenter
                          }
                          onClicked: {
                              logger.logMessage("Calling number: " + dialedNumber.text)
                               console.log("Call initiated")
                                   }
                      }

                      Button {
                          text: "Backspace"
                          width: 100
                          height: 50
                          onClicked: dialedNumber.text = dialedNumber.text.slice(0, -1)
                          background: Rectangle {
                              color: "#ff9800"
                              radius: 25
                          }
                          contentItem: Text {
                              text: parent.text
                              font.family: "Inter"
                              font.pixelSize: 18
                              color: "#ffffff"
                              horizontalAlignment: Text.AlignHCenter
                              verticalAlignment: Text.AlignVCenter
                          }
                      }

                      Button {
                          text: "Clear"
                          width: 100
                          height: 50
                          onClicked: dialedNumber.text = ""
                          background: Rectangle {
                              color: "#f44336"
                              radius: 25
                          }
                          contentItem: Text {
                              text: parent.text
                              font.family: "Inter"
                              font.pixelSize: 18
                              color: "#ffffff"
                              horizontalAlignment: Text.AlignHCenter
                              verticalAlignment: Text.AlignVCenter
                          }
                      }
                  }

                  Button {
                      text: "Close"
                      width: 120
                      height: 40
                      Layout.alignment: Qt.AlignHCenter
                      onClicked: phonePopup.close()
                      background: Rectangle {
                          color: "transparent"
                          border.color: Style.isDark ? "#757575" : "#bdbdbd"
                          border.width: 1
                          radius: 20
                      }
                      contentItem: Text {
                          text: parent.text
                          font.family: "Inter"
                          font.pixelSize: 16
                          color: Style.isDark ? "#ffffff" : "#616161"
                          horizontalAlignment: Text.AlignHCenter
                          verticalAlignment: Text.AlignVCenter
                      }
                  }
              }
          }
      }

    // Popup for Bluetooth (Device List)
    Popup {
        id: bluetoothPopup
        anchors.centerIn: parent
        width: 400
        height: 500
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Bluetooth Devices"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 20
                    clip: true
                    model: ["Phone", "Headphones", "Car Audio"] // Example devices
                    delegate: Button {
                        width: parent.width
                        height: 60
                        text: modelData
                        font.family: "Inter"
                        font.pixelSize: 18
                        onClicked: console.log("Connecting to:", modelData)
                        background: Rectangle {
                            color: Style.isDark ? "#424242" : "#ffffff"
                            radius: 10
                            border.color: Style.isDark ? "#616161" : "#e0e0e0"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.isDark ? "#ffffff" : "#424242"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: bluetoothPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Radio (Station Selector)
    Popup {
        id: radioPopup
        anchors.centerIn: parent
        width: 400
        height: 500
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Radio Stations"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 20
                    clip: true
                    model: ["FM 90.5", "FM 94.3", "FM 102.7"] // Example stations
                    delegate: Button {
                        width: parent.width
                        height: 60
                        text: modelData
                        font.family: "Inter"
                        font.pixelSize: 18
                        onClicked: console.log("Tuning to:", modelData)
                        background: Rectangle {
                            color: Style.isDark ? "#424242" : "#ffffff"
                            radius: 10
                            border.color: Style.isDark ? "#616161" : "#e0e0e0"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.isDark ? "#ffffff" : "#424242"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: radioPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Spotify (Playlist Selector)
    Popup {
        id: spotifyPopup
        anchors.centerIn: parent
        width: 400
        height: 500
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Spotify Playlists"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 20
                    clip: true
                    model: ["Chill Hits", "Rock Classics", "Pop Vibes"] // Example playlists
                    delegate: Button {
                        width: parent.width
                        height: 60
                        text: modelData
                        font.family: "Inter"
                        font.pixelSize: 18
                        onClicked: console.log("Playing:", modelData)
                        background: Rectangle {
                            color: Style.isDark ? "#424242" : "#ffffff"
                            radius: 10
                            border.color: Style.isDark ? "#616161" : "#e0e0e0"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.isDark ? "#ffffff" : "#424242"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: spotifyPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Dashcam (Control Buttons)
    Popup {
        id: dashcamPopup
        anchors.centerIn: parent
        width: 400
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Dashcam Control"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20

                    Button {
                        text: "Start Recording"
                        width: 150
                        height: 50
                        onClicked: console.log("Dashcam recording started")
                        background: Rectangle {
                            color: "#4caf50"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "Stop Recording"
                        width: 150
                        height: 50
                        onClicked: console.log("Dashcam recording stopped")
                        background: Rectangle {
                            color: "#f44336"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: dashcamPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for TuneIn (Station Selector)
    Popup {
        id: tuneinPopup
        anchors.centerIn: parent
        width: 400
        height: 500
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "TuneIn Stations"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 20
                    clip: true
                    model: ["BBC Radio", "NPR", "Jazz FM"] // Example stations
                    delegate: Button {
                        width: parent.width
                        height: 60
                        text: modelData
                        font.family: "Inter"
                        font.pixelSize: 18
                        onClicked: console.log("Tuning to:", modelData)
                        background: Rectangle {
                            color: Style.isDark ? "#424242" : "#ffffff"
                            radius: 10
                            border.color: Style.isDark ? "#616161" : "#e0e0e0"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.isDark ? "#ffffff" : "#424242"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: tuneinPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Music (Player Controls)
    Popup {
        id: musicPopup
        anchors.centerIn: parent
        width: 400
        height: 400
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Music Player"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Now Playing: Song Title"
                    font.family: "Inter"
                    font.pixelSize: 18
                    color: Style.isDark ? "#ffffff" : "#424242"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20

                    Button {
                        text: "◄◄"
                        width: 60
                        height: 60
                        onClicked: console.log("Previous track")
                        background: Rectangle {
                            color: Style.isDark ? "#424242" : "#ffffff"
                            radius: 30
                            border.color: Style.isDark ? "#616161" : "#e0e0e0"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 20
                            color: Style.isDark ? "#ffffff" : "#424242"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "▶"
                        width: 80
                        height: 80
                        onClicked: console.log("Play/Pause")
                        background: Rectangle {
                            color: "#4caf50"
                            radius: 40
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 30
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "►►"
                        width: 60
                        height: 60
                        onClicked: console.log("Next track")
                        background: Rectangle {
                            color: Style.isDark ? "#424242" : "#ffffff"
                            radius: 30
                            border.color: Style.isDark ? "#616161" : "#e0e0e0"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 20
                            color: Style.isDark ? "#ffffff" : "#424242"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: musicPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Calendar (Detailed with Months and Years)
    Popup {
        id: calendarPopup
        anchors.centerIn: parent
        width: 500
        height: 600
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        property int selectedDay: new Date().getDate() // Default to current day

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Calendar"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20

                    ComboBox {
                        id: monthSelector
                        width: 150
                        model: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
                        currentIndex: new Date().getMonth() // Set to current month (e.g., 2 for March 2025)
                        font.family: "Inter"
                        font.pixelSize: 18
                        onCurrentIndexChanged: {
                            calendarPopup.selectedDay = -1; // Reset selected day when month changes
                            updateDays();
                        }
                    }

                    ComboBox {
                        id: yearSelector
                        width: 100
                        model: ListModel {
                            id: yearModel
                        }
                        currentIndex: 0 // Default to current year
                        font.family: "Inter"
                        font.pixelSize: 18
                        Component.onCompleted: {
                            for (var i = 2020; i <= 2030; i++) {
                                yearModel.append({ "text": i })
                            }
                            currentIndex = yearModel.findIndex(function(item) { return item.text === new Date().getFullYear(); }); // Set to 2025
                        }
                        onCurrentIndexChanged: {
                            calendarPopup.selectedDay = -1; // Reset selected day when year changes
                            updateDays();
                        }
                    }
                }

                GridLayout {
                    id: daysGrid
                    columns: 7
                    rowSpacing: 10
                    columnSpacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 20

                    // Display weekday headers (short names)
                    Repeater {
                        model: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                        Text {
                            Layout.fillWidth: true
                            text: modelData
                            font.family: "Inter"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            color: Style.isDark ? "#ffffff" : "#212121"
                        }
                    }

                    // Display days
                    Repeater {
                        id: daysRepeater
                        model: 0 // Will be updated by updateDays()
                        Item {
                            width: 50
                            height: 50

                            Button {
                                anchors.fill: parent
                                text: index + 1
                                font.family: "Inter"
                                font.pixelSize: 18
                                onClicked: {
                                    calendarPopup.selectedDay = index + 1; // Update selected day
                                    console.log("Selected date:", monthSelector.currentText, calendarPopup.selectedDay, yearSelector.currentText);
                                }

                                background: Item {
                                    anchors.fill: parent

                                    // Background for the day
                                    Rectangle {
                                        anchors.fill: parent
                                        color: {
                                            var currentDate = new Date();
                                            var selectedDate = new Date(yearSelector.currentText, monthSelector.currentIndex, index + 1);
                                            if (calendarPopup.selectedDay === index + 1) {
                                                return "#2196f3"; // Blue for selected day
                                            } else if (selectedDate.getDate() === currentDate.getDate() &&
                                                       selectedDate.getMonth() === currentDate.getMonth() &&
                                                       selectedDate.getFullYear() === currentDate.getFullYear()) {
                                                return "#388e3c"; // Darker green for current day
                                            } else {
                                                return Style.isDark ? "#424242" : "#ffffff";
                                            }
                                        }
                                        radius: 25
                                        border.color: Style.isDark ? "#616161" : "#e0e0e0"
                                        border.width: 1
                                    }

                                    // Highlight circle for current or selected day
                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: 40
                                        height: 40
                                        radius: 20
                                        color: "transparent"
                                        border.color: {
                                            var currentDate = new Date();
                                            var selectedDate = new Date(yearSelector.currentText, monthSelector.currentIndex, index + 1);
                                            if (calendarPopup.selectedDay === index + 1) {
                                                return "#ffffff"; // White border for selected day
                                            } else if (selectedDate.getDate() === currentDate.getDate() &&
                                                       selectedDate.getMonth() === currentDate.getMonth() &&
                                                       selectedDate.getFullYear() === currentDate.getFullYear()) {
                                                return "#ffffff"; // White border for current day
                                            } else {
                                                return "transparent";
                                            }
                                        }
                                        border.width: 2
                                        visible: border.color !== "transparent"
                                    }
                                }

                                contentItem: Text {
                                    text: parent.text
                                    font: parent.font
                                    color: {
                                        var currentDate = new Date();
                                        var selectedDate = new Date(yearSelector.currentText, monthSelector.currentIndex, index + 1);
                                        if (calendarPopup.selectedDay === index + 1 ||
                                            (selectedDate.getDate() === currentDate.getDate() &&
                                             selectedDate.getMonth() === currentDate.getMonth() &&
                                             selectedDate.getFullYear() === currentDate.getFullYear())) {
                                            return "#ffffff"; // White text for highlighted day
                                        } else {
                                            return Style.isDark ? "#ffffff" : "#424242";
                                        }
                                    }
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: calendarPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }

            // Function to update the days based on selected month and year
            function updateDays() {
                var daysInMonth = [31, isLeapYear(yearSelector.currentText) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
                var selectedMonth = monthSelector.currentIndex;
                var selectedYear = yearSelector.currentText;
                var firstDay = new Date(selectedYear, selectedMonth, 1).getDay(); // 0 (Sun) to 6 (Sat)
                var adjustedFirstDay = (firstDay === 0) ? 6 : firstDay - 1; // Shift to start from Monday

                // Set the number of days
                daysRepeater.model = daysInMonth[selectedMonth];

                // Adjust visibility of days based on first day of the month
                for (var i = 0; i < daysRepeater.count; i++) {
                    if (daysRepeater.itemAt(i)) {
                        daysRepeater.itemAt(i).visible = (i >= adjustedFirstDay - 1); // Adjust for 0-based index
                    }
                }
                for (var j = 0; j < adjustedFirstDay; j++) {
                    if (daysRepeater.itemAt(j)) daysRepeater.itemAt(j).visible = false;
                }
            }

            // Function to check if the year is a leap year
            function isLeapYear(year) {
                return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
            }

            Component.onCompleted: updateDays() // Initialize days on load
        }
    }

    // Popup for Zoom (Meeting Interface)
    Popup {
        id: zoomPopup
        anchors.centerIn: parent
        width: 400
        height: 400
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Zoom Meeting"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                TextField {
                    id: meetingLink
                    Layout.fillWidth: true
                    Layout.margins: 20
                    placeholderText: "Enter meeting link"
                    font.family: "Inter"
                    font.pixelSize: 18
                    color: Style.isDark ? "#ffffff" : "#424242"
                    background: Rectangle {
                        color: Style.isDark ? "#424242" : "#ffffff"
                        radius: 10
                        border.color: Style.isDark ? "#616161" : "#e0e0e0"
                        border.width: 1
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20

                    Button {
                        text: "Join Meeting"
                        width: 150
                        height: 50
                        onClicked: console.log("Joining Zoom meeting:", meetingLink.text)
                        background: Rectangle {
                            color: "#2196f3"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "Clear"
                        width: 100
                        height: 50
                        onClicked: meetingLink.text = ""
                        background: Rectangle {
                            color: "#f44336"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: zoomPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Messages (Messaging Interface with Keyboard)
    Popup {
        id: messagesPopup
        anchors.centerIn: parent
        width: 500
        height: 700
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Messages"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                TextField {
                    id: recipientField
                    Layout.fillWidth: true
                    Layout.margins: 20
                    placeholderText: "Recipient"
                    font.family: "Inter"
                    font.pixelSize: 18
                    color: Style.isDark ? "#ffffff" : "#424242"
                    background: Rectangle {
                        color: Style.isDark ? "#424242" : "#ffffff"
                        radius: 10
                        border.color: Style.isDark ? "#616161" : "#e0e0e0"
                        border.width: 1
                    }
                }

                TextField {
                    id: messageField
                    Layout.fillWidth: true
                    Layout.margins: 20
                    placeholderText: "Type your message..."
                    font.family: "Inter"
                    font.pixelSize: 18
                    color: Style.isDark ? "#ffffff" : "#424242"
                    background: Rectangle {
                        color: Style.isDark ? "#424242" : "#ffffff"
                        radius: 10
                        border.color: Style.isDark ? "#616161" : "#e0e0e0"
                        border.width: 1
                    }
                }

                GridLayout {
                    columns: 10
                    rowSpacing: 10
                    columnSpacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    Layout.margins: 20

                    Repeater {
                        model: ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
                                "a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
                                "z", "x", "c", "v", "b", "n", "m", ",", ".", " ",
                                "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
                        Button {
                            width: 40
                            height: 40
                            text: modelData
                            font.family: "Inter"
                            font.pixelSize: 18
                            onClicked: messageField.text += modelData
                            background: Rectangle {
                                color: Style.isDark ? "#424242" : "#ffffff"
                                radius: 20
                                border.color: Style.isDark ? "#616161" : "#e0e0e0"
                                border.width: 1
                            }
                            contentItem: Text {
                                text: parent.text
                                font: parent.font
                                color: Style.isDark ? "#ffffff" : "#424242"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 10

                    Button {
                        text: "Send"
                        width: 100
                        height: 50
                        onClicked: console.log("Sending message to", recipientField.text, ":", messageField.text)
                        background: Rectangle {
                            color: "#4caf50"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "Backspace"
                        width: 100
                        height: 50
                        onClicked: messageField.text = messageField.text.slice(0, -1)
                        background: Rectangle {
                            color: "#ff9800"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "Clear"
                        width: 100
                        height: 50
                        onClicked: {
                            recipientField.text = ""
                            messageField.text = ""
                        }
                        background: Rectangle {
                            color: "#f44336"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: messagesPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Caraoke (Song Selector)
    Popup {
        id: caraokePopup
        anchors.centerIn: parent
        width: 400
        height: 500
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Caraoke Songs"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 20
                    clip: true
                    model: ["Bohemian Rhapsody", "Sweet Caroline", "Livin' on a Prayer"] // Example songs
                    delegate: Button {
                        width: parent.width
                        height: 60
                        text: modelData
                        font.family: "Inter"
                        font.pixelSize: 18
                        onClicked: console.log("Playing Caraoke song:", modelData)
                        background: Rectangle {
                            color: Style.isDark ? "#424242" : "#ffffff"
                            radius: 10
                            border.color: Style.isDark ? "#616161" : "#e0e0e0"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.isDark ? "#ffffff" : "#424242"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: caraokePopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Theater (Video Streaming Options)
    Popup {
        id: theaterPopup
        anchors.centerIn: parent
        width: 400
        height: 500
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Theater Mode"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 20
                    clip: true
                    model: ["Netflix", "YouTube", "Hulu"] // Example streaming services
                    delegate: Button {
                        width: parent.width
                        height: 60
                        text: modelData
                        font.family: "Inter"
                        font.pixelSize: 18
                        onClicked: console.log("Opening:", modelData)
                        background: Rectangle {
                            color: Style.isDark ? "#424242" : "#ffffff"
                            radius: 10
                            border.color: Style.isDark ? "#616161" : "#e0e0e0"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.isDark ? "#ffffff" : "#424242"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: theaterPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Toybox (Games and Fun Features)
    Popup {
        id: toyboxPopup
        anchors.centerIn: parent
        width: 400
        height: 500
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Toybox"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 20
                    clip: true
                    model: ["Chess", "Fart Sounds", "Santa Mode"] // Example toybox features
                    delegate: Button {
                        width: parent.width
                        height: 60
                        text: modelData
                        font.family: "Inter"
                        font.pixelSize: 18
                        onClicked: console.log("Activating:", modelData)
                        background: Rectangle {
                            color: Style.isDark ? "#424242" : "#ffffff"
                            radius: 10
                            border.color: Style.isDark ? "#616161" : "#e0e0e0"
                            border.width: 1
                        }
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Style.isDark ? "#ffffff" : "#424242"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: toyboxPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Front Defrost (On/Off Control)
    Popup {
        id: frontDefrostPopup
        anchors.centerIn: parent
        width: 400
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        property bool isFrontDefrostOn: false

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Front Defrost Control"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: frontDefrostPopup.isFrontDefrostOn ? "Front Defrost: ON" : "Front Defrost: OFF"
                    font.family: "Inter"
                    font.pixelSize: 18
                    color: Style.isDark ? "#ffffff" : "#424242"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20

                    Button {
                        text: "Turn On"
                        width: 150
                        height: 50
                        enabled: !frontDefrostPopup.isFrontDefrostOn
                        onClicked: {
                            frontDefrostPopup.isFrontDefrostOn = true
                            console.log("Front Defrost turned ON")
                        }
                        background: Rectangle {
                            color: enabled ? "#4caf50" : "#bdbdbd"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "Turn Off"
                        width: 150
                        height: 50
                        enabled: frontDefrostPopup.isFrontDefrostOn
                        onClicked: {
                            frontDefrostPopup.isFrontDefrostOn = false
                            console.log("Front Defrost turned OFF")
                        }
                        background: Rectangle {
                            color: enabled ? "#f44336" : "#bdbdbd"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: frontDefrostPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Rear Defrost (On/Off Control)
    Popup {
        id: rearDefrostPopup
        anchors.centerIn: parent
        width: 400
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        property bool isRearDefrostOn: false

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Rear Defrost Control"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: rearDefrostPopup.isRearDefrostOn ? "Rear Defrost: ON" : "Rear Defrost: OFF"
                    font.family: "Inter"
                    font.pixelSize: 18
                    color: Style.isDark ? "#ffffff" : "#424242"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20

                    Button {
                        text: "Turn On"
                        width: 150
                        height: 50
                        enabled: !rearDefrostPopup.isRearDefrostOn
                        onClicked: {
                            rearDefrostPopup.isRearDefrostOn = true
                            console.log("Rear Defrost turned ON")
                        }
                        background: Rectangle {
                            color: enabled ? "#4caf50" : "#bdbdbd"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "Turn Off"
                        width: 150
                        height: 50
                        enabled: rearDefrostPopup.isRearDefrostOn
                        onClicked: {
                            rearDefrostPopup.isRearDefrostOn = false
                            console.log("Rear Defrost turned OFF")
                        }
                        background: Rectangle {
                            color: enabled ? "#f44336" : "#bdbdbd"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: rearDefrostPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Left Seat (Heater On/Off Control)
    Popup {
        id: leftSeatPopup
        anchors.centerIn: parent
        width: 400
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        property bool isLeftSeatHeaterOn: false

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Left Seat Heater"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: leftSeatPopup.isLeftSeatHeaterOn ? "Left Seat Heater: ON" : "Left Seat Heater: OFF"
                    font.family: "Inter"
                    font.pixelSize: 18
                    color: Style.isDark ? "#ffffff" : "#424242"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20

                    Button {
                        text: "Turn On"
                        width: 150
                        height: 50
                        enabled: !leftSeatPopup.isLeftSeatHeaterOn
                        onClicked: {
                            leftSeatPopup.isLeftSeatHeaterOn = true
                            console.log("Left Seat Heater turned ON")
                        }
                        background: Rectangle {
                            color: enabled ? "#4caf50" : "#bdbdbd"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "Turn Off"
                        width: 150
                        height: 50
                        enabled: leftSeatPopup.isLeftSeatHeaterOn
                        onClicked: {
                            leftSeatPopup.isLeftSeatHeaterOn = false
                            console.log("Left Seat Heater turned OFF")
                        }
                        background: Rectangle {
                            color: enabled ? "#f44336" : "#bdbdbd"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: leftSeatPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Heated Steering (On/Off Control)
    Popup {
        id: heatedSteeringPopup
        anchors.centerIn: parent
        width: 400
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        property bool isHeatedSteeringOn: false

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Heated Steering Control"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: heatedSteeringPopup.isHeatedSteeringOn ? "Heated Steering: ON" : "Heated Steering: OFF"
                    font.family: "Inter"
                    font.pixelSize: 18
                    color: Style.isDark ? "#ffffff" : "#424242"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20

                    Button {
                        text: "Turn On"
                        width: 150
                        height: 50
                        enabled: !heatedSteeringPopup.isHeatedSteeringOn
                        onClicked: {
                            heatedSteeringPopup.isHeatedSteeringOn = true
                            console.log("Heated Steering turned ON")
                        }
                        background: Rectangle {
                            color: enabled ? "#4caf50" : "#bdbdbd"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "Turn Off"
                        width: 150
                        height: 50
                        enabled: heatedSteeringPopup.isHeatedSteeringOn
                        onClicked: {
                            heatedSteeringPopup.isHeatedSteeringOn = false
                            console.log("Heated Steering turned OFF")
                        }
                        background: Rectangle {
                            color: enabled ? "#f44336" : "#bdbdbd"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: heatedSteeringPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Popup for Wipers (On/Off Control)
    Popup {
        id: wipersPopup
        anchors.centerIn: parent
        width: 400
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        property bool areWipersOn: false

        Rectangle {
            anchors.fill: parent
            color: Style.isDark ? "#212121" : "#fafafa"
            radius: 20
            border.color: Style.isDark ? "#424242" : "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    text: "Wipers Control"
                    font.family: "Inter"
                    font.pixelSize: 24
                    font.bold: Font.Medium
                    color: Style.isDark ? "#ffffff" : "#212121"
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: wipersPopup.areWipersOn ? "Wipers: ON" : "Wipers: OFF"
                    font.family: "Inter"
                    font.pixelSize: 18
                    color: Style.isDark ? "#ffffff" : "#424242"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20

                    Button {
                        text: "Turn On"
                        width: 150
                        height: 50
                        enabled: !wipersPopup.areWipersOn
                        onClicked: {
                            wipersPopup.areWipersOn = true
                            console.log("Wipers turned ON")
                        }
                        background: Rectangle {
                            color: enabled ? "#4caf50" : "#bdbdbd"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "Turn Off"
                        width: 150
                        height: 50
                        enabled: wipersPopup.areWipersOn
                        onClicked: {
                            wipersPopup.areWipersOn = false
                            console.log("Wipers turned OFF")
                        }
                        background: Rectangle {
                            color: enabled ? "#f44336" : "#bdbdbd"
                            radius: 25
                        }
                        contentItem: Text {
                            text: parent.text
                            font.family: "Inter"
                            font.pixelSize: 18
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                Button {
                    text: "Close"
                    width: 120
                    height: 40
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    onClicked: wipersPopup.close()
                    background: Rectangle {
                        color: "transparent"
                        border.color: Style.isDark ? "#757575" : "#bdbdbd"
                        border.width: 1
                        radius: 20
                    }
                    contentItem: Text {
                        text: parent.text
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: Style.isDark ? "#ffffff" : "#616161"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }
}
