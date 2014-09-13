/* Copyright (C) 2014 Magnus Nord
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0
import io.thp.pyotherside 1.2

Page {
    property var edssymbol


    SilicaListView {
        id: eds_line_list
        header: PageHeader {
            width: eds_line_list.width
            title: "EDS lines"
        }
        VerticalScrollDecorator {}
        anchors.fill: parent

        model: ListModel {
            id: edsModel
        }

        delegate: BackgroundItem {
            width: eds_line_list.width
            height: Theme.itemSizeSmall
            Label {
                text: name
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors {
                    fill: parent
                    leftMargin: Theme.paddingLarge
                }
            }
            Label {
                text: energy + " keV"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors {
                    fill: parent
                    leftMargin: Theme.paddingLarge
                }
            }
            Label {
                text: weight
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors {
                    fill: parent
                    rightMargin: Theme.paddingLarge
                }
            }
        }
    }

    Python {
        id: py
        Component.onCompleted: {
            // Add the directory of this .qml file to the search path
            addImportPath(Qt.resolvedUrl('.'));
            importModule('elements_tools', function () {});
        }
        function getEdsData() {
            if (edsPage.edssymbol) {
                py.call('elements_tools.element_list.get_xray_line_list', [edssymbol], function(result) {
                    for (var i=0; i<result.length; i++) {
                        edsModel.append(result[i]);
                    }
                });
            } 
        }
    }
    onEdssymbolChanged: {
        edsModel.clear()
        py.getEdsData();
    }
}
