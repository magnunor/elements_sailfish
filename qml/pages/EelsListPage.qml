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
        id: eels_edge_list
        header: PageHeader {
            id: eelsHeader
            width: eels_edge_list.width
            title: "EELS Edge list"
            Slider {
                x: 70
                y: 50
                width: parent.width - 50
                anchors.rightMargin: Theme.paddingLarge
                minimumValue: 0
                maximumValue: 300
                value: 0
                onValueChanged: {
                    sliderIndex = value
                }
            }
        }
        VerticalScrollDecorator {}
        anchors.fill: parent

        model: ListModel {
            id: edgeModel
        }
        delegate: BackgroundItem {
                height: (index >= sliderIndex) ? 40 : 0
                width: eels_edge_list.width
                visible: (index >= sliderIndex) ? true : false
                Label {
                    text: energy + " eV"
                    font.pixelSize: Theme.fontSizeMedium
                    verticalAlignment: Text.AlignVCenter
                    color: (relevance == 'Minor') ? Theme.secondaryColor : Theme.primaryColor
                    anchors {
                        fill: parent
                        leftMargin: Theme.paddingLarge
                    }
                }
                Label {
                    text: name
                    font.pixelSize: Theme.fontSizeMedium
                    verticalAlignment: Text.AlignVCenter
                    color: (relevance == 'Minor') ? Theme.secondaryColor : Theme.primaryColor
                    anchors {
                        fill: parent
                        leftMargin: Theme.paddingLarge*6
                    }
                }
                Label {
                    text: element_symbol
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeMedium
                    color: (relevance == 'Minor') ? Theme.secondaryColor : Theme.primaryColor
                    anchors {
                        fill: parent
                        leftMargin: Theme.paddingLarge*8
                    }
                }
                Label {
                    text: element_name
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeMedium
                    color: (relevance == 'Minor') ? Theme.secondaryColor : Theme.primaryColor
                    anchors {
                        fill: parent
                        leftMargin: Theme.paddingLarge*10
                    }
                }
                Label {
                    text: relevance
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: Theme.fontSizeMedium
                    color: (relevance == 'Minor') ? Theme.secondaryColor : Theme.primaryColor
                    anchors {
                        fill: parent
                        rightMargin: Theme.paddingLarge
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
            getEdgeList()
        }
        function getEdgeList() {
            py.call('elements_tools.element_list.get_sorted_eels_edge_list', [], function(result) {
                for (var i=0; i<result.length; i++) {
                    edgeModel.append(result[i]);
                } 
            });
        }
    }
}

