import QtQuick 2.9
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import Style 1.0
import QtQuick.Layouts 1.3
import QtQml 2.3

Page {
    id: pageMap
    property var currentLoc: QtPositioning.coordinate(30.33, 31.75)
    property bool isRoutingStart: true
    property bool runMapAnimation: true
    property bool enableGradient: true
    property bool followMeMode: false
    property bool isArabic: false
    padding: 0

    // دالة للحصول على الموقع الحالي من المتصفح
    function getCurrentLocation() {
        if (Qt.positioning.positionSource.valid) {
            Qt.positioning.positionSource.update()
            currentLoc = Qt.positioning.positionSource.position.coordinate
            map.center = currentLoc
            currentLocationMarker.coordinate = currentLoc
        } else {
            showError(isArabic ? "تعذر الحصول على الموقع" : "Failed to get location")
        }
    }

    function searchLocation(query) {
        var cleanedQuery = cleanQuery(query)
        if (cleanedQuery === "") {
            showError(isArabic ? "الرجاء إدخال موقع صحيح" : "Please enter a valid location")
            return
        }
        geocodeModel.query = cleanedQuery
        geocodeModel.update()
        searchBusyIndicator.running = true
    }

    function showError(message) {
        errorMessage.text = message
        errorMessage.visible = true
        errorHideTimer.start()
    }

    function cleanQuery(query) {
        return query.trim().replace(/[^a-zA-Z0-9\s\u0600-\u06FF]/g, "").replace(/\s+/g, " ")
    }

    // مصدر الموقع
    PositionSource {
        id: positionSource
        active: true
        updateInterval: 10000
        onPositionChanged: {
            currentLoc = position.coordinate
            if (followMeMode) {
                map.center = currentLoc
            }
            currentLocationMarker.coordinate = currentLoc
        }
    }

    // الخريطة
    Map {
        id: map
        anchors.fill: parent
        plugin: Plugin {
            name: "osm"
            PluginParameter {
                name: "osm.mapping.providersrepository.disabled"
                value: "true"
            }
            PluginParameter {
                name: "osm.mapping.providersrepository.address"
                value: "http://maps-redirect.qt.io/osm/5.8/"
            }
        }
        center: currentLoc
        zoomLevel: 15

        // علامة الموقع الحالي
        MapQuickItem {
            id: currentLocationMarker
            anchorPoint.x: 16
            anchorPoint.y: 16
            coordinate: currentLoc
            sourceItem: Rectangle {
                width: 32
                height: 32
                color: "#4285F4"
                radius: 16
                border.color: "white"
                border.width: 2
                Rectangle {
                    anchors.centerIn: parent
                    width: 12
                    height: 12
                    color: "white"
                    radius: 6
                }
            }
        }

        // علامة الوجهة
        MapQuickItem {
            id: destinationMarker
            anchorPoint.x: 16
            anchorPoint.y: 16
            visible: false
            sourceItem: Rectangle {
                width: 32
                height: 32
                color: "#EA4335"
                radius: 16
                border.color: "white"
                border.width: 2
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: virtualKeyboard.visible = false
        }
    }

    // شريط البحث
    Rectangle {
        id: searchBar
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        width: Math.min(parent.width * 0.9, 500)
        height: 50
        radius: 25
        color: Style.searchFieldBackground
        border.color: Style.isDark ? Style.black40 : Style.black20
        z: 2

        TextField {
            id: searchField
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 50
            placeholderText: isArabic ? "ابحث عن موقع..." : "Search location..."
            font.pixelSize: 16
            color: Style.searchFieldText
            background: Rectangle { color: "transparent" }
            onAccepted: searchLocation(text)
        }

        Button {
            id: searchButton
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height: 40
            background: Rectangle { color: "transparent" }
            onClicked: searchLocation(searchField.text)
        }

        BusyIndicator {
            id: searchBusyIndicator
            anchors.right: searchButton.left
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30
            running: false
        }
    }

    // لوحة المفاتيح
    Rectangle {
        id: virtualKeyboard
        width: Math.min(parent.width * 0.9, 600)
        height: 300
        color: Style.isDark ? Style.black10 : Style.black80
        radius: 10
        visible: false
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: searchBar.bottom
            topMargin: 20
        }
        z: 2

        Column {
            anchors.centerIn: parent
            spacing: 10

            // صف الأرقام
            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater {
                    model: isArabic ? ["١","٢","٣","٤","٥","٦","٧","٨","٩","٠"] : ["1","2","3","4","5","6","7","8","9","0"]
                    Button {
                        width: 40; height: 40
                        text: modelData
                        onClicked: searchField.text += text
                    }
                }
            }

            // صف الحروف الأول
              Row {
                  spacing: 5
                  anchors.horizontalCenter: parent.horizontalCenter
                  Repeater {
                      model: isArabic ? ["ض","ص","ث","ق","ف","غ","ع","ه","خ","ح"] : ["q","w","e","r","t","y","u","i","o","p"]
                      Button {
                          width: 40; height: 40
                          text: virtualKeyboard.isShift && !isArabic ? modelData.toUpperCase() : modelData
                          onClicked: searchField.text += text
                      }
                  }
              }

              // صف الحروف الثاني
              Row {
                  spacing: 5
                  anchors.horizontalCenter: parent.horizontalCenter
                  Repeater {
                      model: isArabic ? ["ش","س","ي","ب","ل","ا","ت","ن","م","ك"] : ["a","s","d","f","g","h","j","k","l"]
                      Button {
                          width: 40; height: 40
                          text: virtualKeyboard.isShift && !isArabic ? modelData.toUpperCase() : modelData
                          onClicked: searchField.text += text
                      }
                  }
              }

              // صف الحروف الثالث
              Row {
                  spacing: 5
                  anchors.horizontalCenter: parent.horizontalCenter
                  Button {
                      width: 60; height: 40
                      text: "Shift"
                      onClicked: virtualKeyboard.isShift = !virtualKeyboard.isShift
                  }
                  Repeater {
                      model: isArabic ? ["ظ","ط","ذ","د","ز","ج","و","ر"] : ["z","x","c","v","b","n","m",","]
                      Button {
                          width: 40; height: 40
                          text: virtualKeyboard.isShift && !isArabic ? modelData.toUpperCase() : modelData
                          onClicked: searchField.text += text
                      }
                  }
              }

            // صف الأزرار الخاصة
            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter
                Button {
                    width: 100; height: 40
                    text: isArabic ? "مسافة" : "Space"
                    onClicked: searchField.text += " "
                }
                Button {
                    width: 60; height: 40
                    text: isArabic ? "حذف" : "Delete"
                    onClicked: searchField.text = searchField.text.slice(0, -1)
                }
                Button {
                    width: 60; height: 40
                    text: isArabic ? "بحث" : "Search"
                    onClicked: {
                        searchLocation(searchField.text)
                        virtualKeyboard.visible = false
                    }
                }
                Button {
                    width: 60; height: 40
                    text: isArabic ? "إغلاق" : "Close"
                    onClicked: virtualKeyboard.visible = false
                }
            }
        }
    }

    // أزرار التحكم
    Column {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20
        spacing: 15
        z: 2

        Button {
            width: 50; height: 50
            text: "+"
            font.pixelSize: 24
            onClicked: if (map.zoomLevel < 20) map.zoomLevel += 0.5
        }

        Button {
            width: 50; height: 50
            text: "-"
            font.pixelSize: 24
            onClicked: if (map.zoomLevel > 2) map.zoomLevel -= 0.5
        }

        Button {
            width: 50; height: 50
            text: "📍"
            font.pixelSize: 20
            onClicked: getCurrentLocation()
        }

        Button {
            width: 50; height: 50
            text: "⌨"
            font.pixelSize: 20
            onClicked: virtualKeyboard.visible = !virtualKeyboard.visible
        }
    }

    // نموذج البحث الجغرافي
    GeocodeModel {
        id: geocodeModel
        plugin: map.plugin
        onStatusChanged: {
            searchBusyIndicator.running = false
            if (status === GeocodeModel.Ready) {
                if (count > 0) {
                    var location = get(0)
                    destinationMarker.coordinate = location.coordinate
                    destinationMarker.visible = true
                    map.center = location.coordinate
                    errorMessage.visible = false
                } else {
                    showError(isArabic ? "الموقع غير موجود" : "Location not found")
                }
            }
        }
    }

    // رسالة الخطأ
    Rectangle {
        id: errorMessage
        anchors.top: searchBar.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        width: searchBar.width
        height: 40
        radius: 5
        color: "#FFCDD2"
        visible: false
        z: 2

        Text {
            anchors.centerIn: parent
            text: ""
            color: "#D32F2F"
            font.pixelSize: 14
        }

        Timer {
            id: errorHideTimer
            interval: 3000
            onTriggered: errorMessage.visible = false
        }
    }

    Component.onCompleted: {
        getCurrentLocation()
    }
}
