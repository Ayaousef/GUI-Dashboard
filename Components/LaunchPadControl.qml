import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0
import QtGraphicalEffects 1.15

// Define the main Popup component for the LaunchPadControl
Popup {
    width: 1104  // Set the width of the popup
    height: 445  // Set the height of the popup
    background: Rectangle {
        anchors.fill: parent  // Fill the entire popup area
        radius: 12  // Add rounded corners to the background
        color: Style.alphaColor("#1C2526", 0.9)  // Use a realistic dark background with 90% opacity
    }

    // Define signals for each icon to handle click events
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
    signal caraokeClicked()
    signal theaterClicked()
    signal toyboxClicked()
    signal frontDefrostClicked()
    signal rearDefrostClicked()
    signal leftSeatClicked()
    signal heatedSteeringClicked()
    signal wipersClicked()

    // Debug the theme settings when the component is created
    Component.onCompleted: {
        console.log("Style.isDark:", Style.isDark)  // Print whether the theme is dark
        console.log("Theme:", Style.theme)  // Print the current theme
    }

    // Use a GridLayout to arrange the icons in a 5-column grid
    GridLayout {
        anchors.fill: parent  // Fill the entire popup
        anchors.margins: 25  // Add margins around the grid
        columns: 5  // Set the number of columns in the grid
        rowSpacing: 30  // Increase the spacing between rows for a more realistic look
        columnSpacing: 30  // Increase the spacing between columns for a more realistic look

        // Front Defrost Icon
        Item {
            Layout.fillWidth: true  // Allow the item to fill the available width
            Layout.fillHeight: true  // Allow the item to fill the available height
            Rectangle {
                anchors.centerIn: parent  // Center the rectangle in the item
                width: 140  // Adjust the width for a more realistic size
                height: 140  // Adjust the height for a more realistic size
                radius: 10  // Add rounded corners to the rectangle
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"  // Use a solid color for the background (no gradient)

                // Add a subtle drop shadow effect to the rectangle
                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1  // Horizontal offset of the shadow
                    verticalOffset: 1  // Vertical offset of the shadow
                    radius: 4  // Reduce the radius for a more subtle shadow
                    samples: 8  // Reduce the samples for a more realistic shadow
                    color: Style.isDark ? "#30000000" : "#15000000"  // Use a lighter shadow color
                    transparentBorder: true  // Allow the shadow to have a transparent border
                }

                // Use a ColumnLayout to stack the icon and text vertically
                ColumnLayout {
                    anchors.centerIn: parent  // Center the layout in the rectangle
                    spacing: 12  // Set the spacing between the icon and text

                    // Display the Front Defrost icon
                    Image {
                        Layout.alignment: Qt.AlignHCenter  // Center the image horizontally
                        source: "qrc:/icons/app_icons/front-defrost.svg"  // Load the SVG icon
                        width: 64  // Increase the width for better visibility
                        height: 64  // Increase the height for better visibility
                        fillMode: Image.PreserveAspectFit  // Preserve the aspect ratio of the icon

                        // Debug the loading status of the image
                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Front Defrost image:", source)  // Log if the image fails to load
                            } else if (status === Image.Ready) {
                                console.log("Front Defrost image loaded successfully:", source)  // Log if the image loads successfully
                            } else if (status === Image.Loading) {
                                console.log("Front Defrost image is loading:", source)  // Log if the image is loading
                            }
                        }
                    }

                    // Display the label for the Front Defrost icon
                    Text {
                        Layout.alignment: Qt.AlignHCenter  // Center the text horizontally
                        text: "Front Defrost"  // Set the text label
                        font.family: "Inter"  // Use the Inter font
                        font.pixelSize: 16  // Increase the font size for better readability
                        font.weight: Font.Normal  // Set the font weight to normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"  // Use white in dark theme for a more realistic look
                    }
                }

                // Add a MouseArea to handle click and press effects
                MouseArea {
                    anchors.fill: parent  // Fill the entire rectangle
                    onClicked: frontDefrostClicked()  // Emit the signal when clicked
                    onPressed: {
                        parent.opacity = 0.8  // Reduce opacity when pressed
                        parent.scale = 0.95  // Slightly scale down when pressed
                    }
                    onReleased: {
                        parent.opacity = 1.0  // Restore opacity when released
                        parent.scale = 1.0  // Restore scale when released
                    }
                }

                // Add a smooth animation for the opacity change
                Behavior on opacity {
                    NumberAnimation {
                        duration: 100  // Duration of the animation
                        easing.type: Easing.InOutQuad  // Easing type for smooth transition
                    }
                }

                // Add a smooth animation for the scale change
                Behavior on scale {
                    NumberAnimation {
                        duration: 100  // Duration of the animation
                        easing.type: Easing.InOutQuad  // Easing type for smooth transition
                    }
                }
            }
        }

        // Rear Defrost Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/rear-defrost.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Rear Defrost image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Rear Defrost image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Rear Defrost image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Rear Defrost"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: rearDefrostClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Left Seat Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/seat-warmer.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Left Seat image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Left Seat image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Left Seat image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Left Seat"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: leftSeatClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Heated Steering Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/steering-wheel-warmer.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Heated Steering image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Heated Steering image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Heated Steering image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Heated Steering"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: heatedSteeringClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Wipers Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/wiper.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Wipers image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Wipers image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Wipers image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Wipers"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: wipersClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Dashcam Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                // Debug when the Dashcam item is created
                Component.onCompleted: {
                    console.log("Dashcam Item created")
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/dashcam.svg"  // Path is already fixed
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Dashcam image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Dashcam image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Dashcam image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Dashcam"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: dashcamClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Calendar Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/calendar.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Calendar image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Calendar image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Calendar image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Calendar"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: calendarClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Messages Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                // Debug when the Messages item is created
                Component.onCompleted: {
                    console.log("Messages Item created")
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/messages.svg"  // Use messages.svg instead of messages-3.svg
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Messages image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Messages image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Messages image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Messages"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: messagesClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Zoom Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/zoom.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Zoom image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Zoom image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Zoom image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Zoom"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: zoomClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Theater Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/video.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Theater image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Theater image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Theater image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Theater"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: theaterClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Toybox Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/toybox.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Toybox image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Toybox image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Toybox image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Toybox"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: toyboxClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Spotify Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/spotify.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Spotify image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Spotify image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Spotify image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Spotify"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: spotifyClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Caraoke Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/caraoke.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Caraoke image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Caraoke image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Caraoke image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Caraoke"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: caraokeClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // TuneIn Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/tunein.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading TuneIn image:", source)
                            } else if (status === Image.Ready) {
                                console.log("TuneIn image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("TuneIn image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "TuneIn"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: tuneinClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Music Icon
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.centerIn: parent
                width: 140
                height: 140
                radius: 10
                color: Style.isDark ? "#2A2A2A" : "#E5E5E5"

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 4
                    samples: 8
                    color: Style.isDark ? "#30000000" : "#15000000"
                    transparentBorder: true
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/icons/app_icons/music.svg"
                        width: 64
                        height: 64
                        fillMode: Image.PreserveAspectFit

                        onStatusChanged: {
                            if (status === Image.Error) {
                                console.log("Error loading Music image:", source)
                            } else if (status === Image.Ready) {
                                console.log("Music image loaded successfully:", source)
                            } else if (status === Image.Loading) {
                                console.log("Music image is loading:", source)
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Music"
                        font.family: "Inter"
                        font.pixelSize: 16
                        font.weight: Font.Normal
                        color: Style.isDark ? "#FFFFFF" : "#333333"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: musicClicked()
                    onPressed: {
                        parent.opacity = 0.8
                        parent.scale = 0.95
                    }
                    onReleased: {
                        parent.opacity = 1.0
                        parent.scale = 1.0
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }
}
