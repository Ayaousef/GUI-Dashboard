import QtQuick 2.9
import QtLocation 5.6
import QtQml 2.3
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtPositioning 5.6
import Style 1.0

Rectangle {
    id: root  // Added ID for better reference
    property bool runMenuAnimation: false
    color: "black"
    visible: true
    clip: true

    // Main stack view of application
    StackView {
        id: mainApplicationStackView
        anchors.fill: parent
        initialItem: pageMap  // Set initial item directly

        // Sliding in animation
        pushEnter: Transition {
            NumberAnimation {
                properties: "x"
                from: mainApplicationStackView.width
                to: 0
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }

        // Sliding out animation
        pushExit: Transition {
            NumberAnimation {
                properties: "x"
                from: 0
                to: -mainApplicationStackView.width
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }

        // Added pop transitions for consistency
        popEnter: Transition {
            NumberAnimation {
                properties: "x"
                from: -mainApplicationStackView.width
                to: 0
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }

        popExit: Transition {
            NumberAnimation {
                properties: "x"
                from: 0
                to: mainApplicationStackView.width
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }
    }

    // Map Page
    NavigationMapScreen {
        id: pageMap
        enableGradient: true
        visible: false  // StackView will handle visibility
    }

    Component.onCompleted: {
        // No need to push since initialItem is set
        pageMap.startAnimation()
    }
}
