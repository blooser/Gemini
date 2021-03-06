﻿import QtQuick 2.14
import QtQuick.Controls 2.12
import QtQuick.Window 2.14

import Qt.labs.settings 1.1

import com.gemini.enums 0.1
import com.gemini.tools 0.1
import com.gemini.helper 0.1

import "pages" as Pages
import "components" as Components
import "items" as Items

Window {
    id: root

    title: Qt.application.name
    visible: true

    width: GeminiStyles.mainWindowWidth
    height: GeminiStyles.mainWindowHeight

    Settings {
        property alias x: root.x
        property alias y: root.y
        property alias width: root.width
        property alias height: root.height
    }

    Components.Shortcuts {
        // Comfort
    }

    Picker {
        id: picker
        model: wallpaperModel
        roleName: "url"
        interval: sessionController.wallpaperInterval
        running: (wallpaperModel.size > GeminiStyles.empty)

        onPicked: sessionController.currentWallpaper = data
    }

    Connections {
        target: sessionController

        function onSwipeLeft() { swipeView.decrementCurrentIndex() }
        function onSwipeRight() { swipeView.incrementCurrentIndex() }
        function onSwipe() { swipeView.setCurrentIndex(index) }
    }

    Binding {
        target: songsInRelations
        property: "currentPlaylist"
        value: sessionController.currentPlaylist
    }

    SwipeView {
        id: swipeView

        anchors.fill: parent

        onCurrentIndexChanged: sessionController.currentPageIndex = currentIndex

        Pages.SummaryPage {
            wallpaper: sessionController.currentWallpaper
            blurred: true
        }

        Pages.MusicPage {
            wallpaper: sessionController.currentWallpaper
        }

        Pages.PlaylistPage {

        }

        Pages.WallpaperPage {

        }

        Component.onCompleted: {
            currentIndex = sessionController.currentPageIndex
        }
    }

    Connections {
        target: objectController

        function onOpen() { objectCreator.create(url, properties, callback) }
        function onClose() { objectCreator.remove(dialog) }
    }

    QtObject {
        id: objectCreator

        property var stack: []

        function create(url, properties, callback) {
            let component = Qt.createComponent(url)

            if (component.status === Component.Error) {
                console.warn("Error while creating object", component.errorString())
                return
            }

            if (typeof callback === "function") {
                properties["callback"] = callback
            }

            let object = component.createObject(root, properties)
            console.log("Open", object)
            stack.push(object)
            object.open()
        }

        function remove(dialog) {
            const dialogToRemove = stack.find(item => item.dialog === dialog)

            if (dialogToRemove !== undefined) {
                console.log("Close", dialogToRemove)
                stack = stack.filter(item => item.dialog !== dialogToRemove.dialog)
                dialogToRemove.close()
                dialogToRemove.destroy()
            }
        }
    }

    Component.onCompleted: {
        if (sessionController.unfinishedPeding) {
            objectController.openDialog(Enums.Dialog.UnfinishedPendingDialog, {}, null)
        }
    }
}


