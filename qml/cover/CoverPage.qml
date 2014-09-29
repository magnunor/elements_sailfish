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

CoverBackground {
    Image {
	source: "elements_cover.png"
	anchors.horizontalCenter: parent.horizontalCenter
	width: parent.width
        opacity: 0.5
    }	
    Label {
        id: label
        anchors.centerIn: parent
        text: "Elements"
    }
    CoverActionList {
        id: coverAction
        CoverAction {
            iconSource: "../images/eds.png"
            onTriggered: {
                pageStack.push(edsListPage)
                appWindow.activate()
            }
        }
        CoverAction {
            iconSource: "../images/eels.png"
            onTriggered: {
                pageStack.push(eelsListPage)
                appWindow.activate()
            }
        }
    }
}