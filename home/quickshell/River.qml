pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property var data: []

  Process {
    id: rivertailProc
    command: ["/home/hazel/projects/rivertail/result/bin/rivertail"]
    running: true

    stdout: SplitParser {
      onRead: function(data) {
        root.data = JSON.parse(data);
      }
    }
  }
}
