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
    property var elementsymbol
    PageHeader {
        id: elementDetailsHeader
        title: "Element details"
    }

    Column {
        anchors.top: elementDetailsHeader.bottom
        width: parent.width
        spacing: Theme.paddingLarge
        Item {
            width: parent.width
            height: Theme.paddingLarge
            Label {
                text: "Name"
                horizontalAlignment: Text.AlignLeft
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                anchors {
                    fill: parent
                    leftMargin: Theme.paddingLarge
                }
            }
            Label {
                id: element_name
                horizontalAlignment: Text.AlignRight
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                anchors {
                    fill: parent
                    rightMargin: Theme.paddingLarge
                }
            }
        }    
        Item {
            width: parent.width
            height: Theme.paddingLarge
            Label {
                text: "Symbol"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                anchors {
                    fill: parent
                    leftMargin: Theme.paddingLarge
                }
            }
            Label {
                text: elementsymbol
                horizontalAlignment: Text.AlignRight
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                anchors {
                    fill: parent
                    rightMargin: Theme.paddingLarge
                }
            }
        }
        Item {
            width: parent.width
            height: Theme.paddingLarge
            Label {
                text: "Density"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                anchors {
                    fill: parent
                    leftMargin: Theme.paddingLarge
                }
            }
            Label {
                id: element_density
                horizontalAlignment: Text.AlignRight
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                anchors {
                    fill: parent
                    rightMargin: Theme.paddingLarge
                }
            }
        }
        Item {
            width: parent.width
            height: Theme.paddingLarge
            Label {
                text: "Atomic weight"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                anchors {
                    fill: parent
                    leftMargin: Theme.paddingLarge
                }
            }
            Label {
                id: element_atomic_weight
                horizontalAlignment: Text.AlignRight
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                anchors {
                    fill: parent
                    rightMargin: Theme.paddingLarge
                }
            }
        }
        Row {
            Button {
                text: "EDS lines"
                onClicked: { 
                    edsPage.edssymbol = elementsymbol; 
                    pageStack.push(edsPage);
                }
            }
            Button {
                text: "EELS edges"
                onClicked: { 
                    eelsPage.eelssymbol = elementsymbol; 
                    pageStack.push(eelsPage);
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

        function getElementName() {
            if (elementPage.elementsymbol) {
                py.call('elements_tools.element_list.get_element_name', [elementsymbol], function(result) {
                    element_name.text = result
                    });
                } 
            }

        function getElementDensity() {
            if (elementPage.elementsymbol) {
                py.call('elements_tools.element_list.get_element_density', [elementsymbol], function(result) {
                    element_density.text = result
                    });
                } 
            }

        function getElementAtomicWeight() {
            if (elementPage.elementsymbol) {
                py.call('elements_tools.element_list.get_element_atomic_weight', [elementsymbol], function(result) {
                    element_atomic_weight.text = result
                    });
                } 
            }
    }
    onElementsymbolChanged: {
        py.getElementName();
        py.getElementDensity();
        py.getElementAtomicWeight();
    }
}
