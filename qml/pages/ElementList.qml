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
    id: firstPage
    property string searchText: ''
    SilicaListView {
        id: element_symbol_list
        header: SearchField {
            id: searchField
            width: parent.width
            placeholderText: "Search"
            onTextChanged: {
                searchText = searchField.text;
                searchTextHasChanged(searchText)
            }
        }
        currentIndex: -1
        PullDownMenu {
            MenuItem {
                text: "About"
                onClicked: pageStack.push(aboutPage)
            }
            MenuItem {
                text: "EELS edge list"
                onClicked: pageStack.push(eelsListPage)
            }
            MenuItem {
                text: "EDS line list"
                onClicked: pageStack.push(edsListPage)
            }
        }
        VerticalScrollDecorator {}
        anchors.fill: parent

        model: ListModel {
            id: symbolModel
        }
        delegate: BackgroundItem {
                height: Theme.itemSizeSmall
                width: element_symbol_list.width
                Label {
                    text: name
                    font.pixelSize: Theme.fontSizeLarge
                    verticalAlignment: Text.AlignVCenter
                    anchors {
                        fill: parent
                        leftMargin: Theme.paddingLarge
                    }
                }
                Label {
                    text: symbol
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeLarge
                    anchors {
                        fill: parent
                        leftMargin: Theme.paddingLarge*12
                    }
                }
                Label {
                    text: "Z: " + atomic_number 
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeLarge
                    anchors {
                        fill: parent
                        rightMargin: Theme.paddingLarge
                    }
                }
            onClicked: {
                elementPage.elementsymbol = symbol; 
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
            getElementList("")
        }
        function getElementList(searchtext) {
            py.call('elements_tools.element_list.get_atomic_number_symbol_list', [searchtext], function(result) {
                for (var i=0; i<result.length; i++) {
                    symbolModel.append(result[i]);
                } 
            });
        }
    }
    function searchTextHasChanged (searchtext) {
        symbolModel.clear()
        py.getElementList(searchtext);
    }
}

