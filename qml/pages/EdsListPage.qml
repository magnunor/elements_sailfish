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
    property real sliderIndex: 0

    SilicaListView {
        id: eds_line_list
        header: PageHeader {
            width: eds_line_list.width
            title: "EDS line list"
            Slider {
                x: 70
                y: 50
                width: parent.width-50
                anchors.rightMargin: Theme.paddingLarge
                minimumValue: 0
                maximumValue: 900
                value: 0
                onValueChanged: {
                    sliderIndex = value
                }
            }
        }

        VerticalScrollDecorator {}
        anchors.fill: parent

        model: ListModel {
            id: lineModel
        }

        delegate: BackgroundItem {
                visible: (index >= sliderIndex) ? true : false
                height: (index >= sliderIndex) ? 40 : 0
                width: eds_line_list.width
                Label {
                    text: energy + " keV"
                    font.pixelSize: Theme.fontSizeMedium
                    verticalAlignment: Text.AlignVCenter
                    color: Theme.primaryColor
                    anchors {
                        fill: parent
                        leftMargin: Theme.paddingLarge
                    }
                }
                Label {
                    text: name
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeMedium
                    color: Theme.primaryColor
                    anchors {
                        fill: parent
                        leftMargin: Theme.paddingLarge*8
                    }
                }
                Label {
                    text: element_symbol
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeMedium
                    color: Theme.primaryColor
                    anchors {
                        fill: parent
                        leftMargin: Theme.paddingLarge*11
                    }
                }
                Label {
                    text: element_name
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeMedium
                    color: Theme.primaryColor
                    anchors {
                        fill: parent
                        leftMargin: Theme.paddingLarge*14
                    }
                }
            onClicked: {
                elementPage.elementsymbol = element_symbol; 
                pageStack.push(elementPage);
            }
        }
    }
    Python {
        id: py
        Component.onCompleted: {
            // Add the directory of this .qml file to the search path
            addImportPath(Qt.resolvedUrl('.'));
            importModule('elements_tools', function () {}); 
            getLineList()
        }
        function getLineList() {
            py.call('elements_tools.element_list.get_sorted_eds_line_list', [], function(result) {
                for (var i=0; i<result.length; i++) {
                    lineModel.append(result[i]);
                } 
            });
        }
    }
}

