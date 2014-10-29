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
    SilicaFlickable {
	anchors.fill: parent
	Column {
            spacing: Theme.paddingLarge
            anchors {
                fill: parent
                leftMargin: Theme.PaddingLarge
                rightMargin: Theme.PaddingLarge
            } 
            PageHeader {
                title: "About Elements"
            }
            Label {
                width: parent.width
                font.pixelSize: Theme.fontSizeSmall
                text: '© 2014 Magnus Nord'
            } 
            Label {
                font.pixelSize: Theme.fontSizeSmall
                text: 'License: GPLv3 or later'
            } 
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeSmall
                text: 'Source: <html><style type="text/css"></style><a href="https://github.com/magnunor/elements_sailfish">https://github.com/magnunor/elements_sailfish</a></html>'
                onLinkActivated: Qt.openUrlExternally('https://github.com/magnunor/elements_sailfish')
            } 
            Label {
                font.pixelSize: Theme.fontSizeSmall
                text: 'Atom data: <html><style type="text/css"></style><a href="http://hyperspy.org/">http://hyperspy.org/</a></html> and'
                onLinkActivated: Qt.openUrlExternally('http://hyperspy.org/')
            } 
            Label {
                font.pixelSize: Theme.fontSizeSmall
                text: '<html><style type="text/css"></style><a href="https://www.wikipedia.org/">https://www.wikipedia.org/</a></html>'
                onLinkActivated: Qt.openUrlExternally('https://www.wikipedia.org/')
            } 
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeSmall
                text: 'Icon: CC BY-SA 3.0, <html><style type="text/css"></style><a href="http://commons.wikimedia.org/wiki/File:Stylised_Lithium_Atom.svg">http://commons.wikimedia.org/wiki/File:Stylised_Lithium_Atom.svg</a></html>'
                onLinkActivated: Qt.openUrlExternally('http://commons.wikimedia.org/wiki/File:Stylised_Lithium_Atom.svg')
            } 
        }
    }
}

