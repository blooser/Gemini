import QtQuick 2.14
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import com.gemini.enums 0.1
import com.gemini.styles 0.1
import com.gemini.common 0.1
import com.gemini.helper 0.1

import "../items" as Items

GDialog {
    id: root

    headerText: qsTr("Wallpaper Interval")
    dialog: Enums.Dialog.WallpaperIntervalDialog
    standardButtons: Dialog.Cancel | Dialog.Ok

    implicitWidth: 350

    contentItem: Items.GSpinBox {
        id: intervalSpinBox

        display: function(value) {
            return Utility.formatTime(value * 1000, Helper.extraHumanTime(value * 1000))
        }

        from: 5
        stepSize: 1
        to: 300

        font.pixelSize: GeminiStyles.hFontPixelSize

        Component.onCompleted: {
            value = sessionController.wallpaperInterval/1000
        }
    }

    onAccepted: callback(intervalSpinBox.value * 1000)
}