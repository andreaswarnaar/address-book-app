/*
 * Copyright (C) 2012-2015 Canonical, Ltd.
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

import QtQuick 2.2
import QtContacts 5.0 as QtContacts
import Ubuntu.Components.ListItems 1.0 as ListItem

ListItem.Empty {
    id: root
    objectName: detail ? "base_" + detailToString(detail.type, -1) + "_" + index : ""

    property QtObject contact: null
    property QtObject detail: null
    property variant fields: null
    signal actionTrigerred(string action)

    // help to test used to retrieve the correct element
    property int index: -1

    function detailToString(detail, field)
    {
        // name
        var nameMap = {}
        nameMap[QtContacts.Name.FirstName] = "firstName"
        nameMap[QtContacts.Name.LastName] = "lastName"

        // phone
        var phoneMap = {}
        phoneMap[QtContacts.PhoneNumber.Number] = "phoneNumber"

        // email
        var emailMap = {}
        emailMap[QtContacts.EmailAddress.EmailAddress] = "emailAddress"

        // address
        var addressMap = {}
        addressMap[QtContacts.Address.Street] = "streetAddress"
        addressMap[QtContacts.Address.Locality] = "localityAddress"
        addressMap[QtContacts.Address.Region] = "regionAddress"
        addressMap[QtContacts.Address.Postcode] = "postcodeAddress"
        addressMap[QtContacts.Address.Country] = "countryAddress"
        addressMap[QtContacts.Address.PostOfficeBox] = "postOfficeBoxAddress"

        // im
        var imMap = {}
        imMap[QtContacts.OnlineAccount.AccountUri] = "imUri"
        imMap[QtContacts.OnlineAccount.ServiceProvider] = "imProvider"
        imMap[QtContacts.OnlineAccount.Protocol] = "imProtocol"
        imMap[QtContacts.OnlineAccount.Capabilities] = "imCaps"

        // organization
        var organizationMap = {}
        organizationMap[QtContacts.Organization.Name] = 'orgName'
        organizationMap[QtContacts.Organization.Role] = 'orgRole'
        organizationMap[QtContacts.Organization.Title] = 'orgTitle'

        // SyncTarget
        var syncTargetMap = {}
        syncTargetMap[QtContacts.SyncTarget.SyncTarget] = "syncTarget"

        // all
        var detailMap = {}
        detailMap[QtContacts.ContactDetail.Name] = nameMap
        detailMap[QtContacts.ContactDetail.PhoneNumber] = phoneMap
        detailMap[QtContacts.ContactDetail.Email] = emailMap
        detailMap[QtContacts.ContactDetail.Address] = addressMap
        detailMap[QtContacts.ContactDetail.OnlineAccount] = imMap
        detailMap[QtContacts.ContactDetail.Organization] = organizationMap
        detailMap[QtContacts.ContactDetail.SyncTarget] = syncTargetMap

        // detail name
        var detailNameMap = {}
        detailNameMap[QtContacts.ContactDetail.Name] = "name"
        detailNameMap[QtContacts.ContactDetail.PhoneNumber] = "phoneNumber"
        detailNameMap[QtContacts.ContactDetail.Email] = "email"
        detailNameMap[QtContacts.ContactDetail.Address] = "address"
        detailNameMap[QtContacts.ContactDetail.OnlineAccount] = "onlineAccount"
        detailNameMap[QtContacts.ContactDetail.SyncTarget] = "syncTarget"

        if ((detail in detailMap) && (field in detailMap[detail])) {
            return detailMap[detail][field]
        } else if ((detail in detailNameMap) && (field == -1)){
            return detailNameMap[detail]
        } else {
            console.debug("Unknown : [" + detail + "] [" + field + "]")
            return "unknown"
        }
    }

    highlightWhenPressed: false
    showDivider: false

    Rectangle {
        anchors.fill: parent
        opacity: 0.1
        visible: root.selected
        z: 100
    }
}