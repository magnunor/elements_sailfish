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
    property var elementdatadict
    PageHeader {
        id: elementDetailsHeader
        title: "Element details"
    }

    Column {
        anchors.top: elementDetailsHeader.bottom
        width: parent.width
        spacing: Theme.paddingLarge
        ElementItem {
            tag: "Name"
            value: elementdatadict.name
        }
        ElementItem {
            tag: "Symbol"
            value: elementsymbol
        }
        ElementItem {
            tag: "Atomic number"
            value: elementdatadict.number
        }
        ElementItem {
            tag: "Atomic mass"
            value: elementdatadict.atomic_mass
        }
        ElementItem {
            tag: "Phase"
            value: elementdatadict.phase
        }
        ElementItem {
            tag: "Structure"
            value: elementdatadict.crystal_structure
        }
        ElementItem {
            tag: "Boiling point"
            value: elementdatadict.boiling_point_K
        }
        ElementItem {
            tag: "Melting point"
            value: elementdatadict.melting_point_K
        }
        ElementItem {
            tag: "Oxidation states"
            value: elementdatadict.oxidation_states
        }
        ElementItem {
            tag: "Series"
            value: elementdatadict.series
        }
        ElementItem {
            tag: "Electron configuration"
            value: elementdatadict.electron_configuration
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

        function getElementData() {
            if (elementPage.elementsymbol) {
                py.call('elements_tools.element_list.get_element_data', [elementsymbol], function(result) {
                    elementdatadict = result
                    });
                } 
            }
    }
    onElementsymbolChanged: {
        py.getElementData();
    }
}
