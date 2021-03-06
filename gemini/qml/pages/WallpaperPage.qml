import QtQuick 2.14

import Qt.labs.platform 1.1

import com.gemini.helper 0.1
import com.gemini.enums 0.1
import com.gemini.styles 0.1

import "../components/pageheaders" as PageHeaders
import "../components/wallpapers" as Wallpapers

GPage {
    id: root

    header: PageHeaders.WallpaperPageHeader {
        selectedWallpapers: wallpaperView.selectedWallpapers

        onAddWallpapers: objectController.openDialog(Enums.Dialog.FileOpenDialog, {"title": qsTr("Add new wallpapers"),
                                                                                   "nameFilters": ["Images (*.png *.jpg *.jpeg)"],
                                                                                   "folder": StandardPaths.writableLocation(StandardPaths.PicturesLocation)}, function(files){
            dataController.insertData(Helper.toList(files), Enums.Data.Wallpapers)
        })

        onChangeInterval: objectController.openDialog(Enums.Dialog.WallpaperIntervalDialog, {}, function(interval) {
            sessionController.wallpaperInterval = interval
        })

        onRemoveSelectedWallpapers: objectController.openDialog(Enums.Dialog.ConfirmDialog, {"text": qsTr("Are you sure you want to delete %1 wallpapers?").arg(selectedWallpapers.length)}, function(){
            dataController.removeData(selectedWallpapers, Enums.Data.Wallpapers)
            sessionController.clearSelection() // NOTE: This will take effects in WallpaperItems
        })
    }

    Wallpapers.WallpaperView {
        id: wallpaperView

        anchors {
            fill: parent
            margins: GeminiStyles.nMargin
        }
    }
}
