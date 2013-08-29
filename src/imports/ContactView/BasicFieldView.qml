/*
 * Copyright (C) 2012-2013 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
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
import Ubuntu.Components 0.1

import "../Common"

 Item {
    id: root

    property alias typeLabel: typeLabel.text
    property alias values: valueList.model
    property alias iconSource: actionIcon.source
    property double lineHeight: units.gu(3)

    implicitHeight: typeLabel.height  + fieldValues.childrenRect.height + units.gu(2)

    Image {
        id: actionIcon

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
        }
        height: units.gu(2.5)
        width: visible ? units.gu(2.5) : 0
        visible: iconSource && iconSource != ""
    }

    Label {
        id: typeLabel

        anchors {
            left: actionIcon.right
            leftMargin: actionIcon.visible ? units.gu(1) : 0
            top: parent.top
            topMargin: units.gu(1)
        }
        height: units.gu(2)
        verticalAlignment: Text.AlignVCenter

        // style
        fontSize: "medium"
        color: "#f3f3e7"
        opacity: 0.2
    }

    Column {
        id: fieldValues

        anchors {
            left: typeLabel.left
            top: typeLabel.bottom
            right: parent.right
            bottom: parent.bottom
        }

        Repeater {
            id: valueList

            Label {
                id: label
                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: root.lineHeight
                verticalAlignment: Text.AlignVCenter
                text: modelData

                // style
                fontSize: "medium"
                color: "#f3f3e7"
            }
        }
    }
}