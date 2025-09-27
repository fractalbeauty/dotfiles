// Bar.qml
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 24

      // Text {
      //   anchors.centerIn: parent
      //   // text: Time.time
      //   text: {
      //     River.data.toString()
      //   }
      // }

      RowLayout {
        Repeater {
          model: ScriptModel {
            values: River.data
          }

          delegate: Rectangle {
            id: delegate

            required property var modelData

            implicitWidth: 20
            implicitHeight: 24
           
            Text {
              anchors.centerIn: parent

              font.pixelSize: 11

              text: modelData.occupied ? '' : ''
            }
          }
        }
      }
    }
  }
}
