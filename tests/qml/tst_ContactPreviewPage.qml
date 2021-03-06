/*
 * Copyright (C) 2014 Canonical, Ltd.
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

import QtQuick 2.4
import QtTest 1.0
import Ubuntu.Test 0.1
import QtContacts 5.0

import Ubuntu.Components 1.3
import Ubuntu.Contacts 0.1
import Ubuntu.AddressBook.ContactView 0.1

import "ContactUtil.js" as ContactUtilJS

Item {
    id: root

    function createContactWithName() {
        var details = [
           {detail: 'Name', field: 'firstName', value: 'Fulano'},
        ];
        return ContactUtilJS.createContact(details, root)
    }

    function createContactWithNameAndAvatar() {
        var details = [
           {detail: 'Name', field: 'firstName', value: 'Fulano'},
           {detail: 'Avatar', field: 'imageUrl', value: 'image://theme/address-book-app'}
        ];
        return ContactUtilJS.createContact(details, root)
    }

    function createSignalSpy(target, signalName) {
        var spy = Qt.createQmlObject('import QtTest 1.0;  SignalSpy {}', root, "")
        spy.target = target
        spy.signalName = signalName
        return spy
    }

    VCardParser {
        id: vcardParser

        vCardUrl: Qt.resolvedUrl("../data/vcard_single.vcf")
    }


    width: units.gu(40)
    height: units.gu(80)

    MainView {
        id: mainView
        anchors.fill: parent

        ContactViewPage {
            id: contactPreviewPage
            anchors.fill: parent
        }
    }


    UbuntuTestCase {
        id: contactPreviewPageTestCase
        name: 'contactPreviewPageTestCase'

        when: windowShown

        function findChildOfType(obj, typeName) {
            var childs = new Array(0)
            var result = new Array(0)
            childs.push(obj)
            while (childs.length > 0) {
                var objTypeName = String(childs[0]).split("_")[0]
                if (objTypeName === typeName) {
                    result.push(childs[0])
                }
                for (var i in childs[0].children) {
                    childs.push(childs[0].children[i])
                }
                childs.splice(0, 1)
            }
            return result
        }


        function init()
        {
            waitForRendering(mainView);
            contactPreviewPage.contact = null
        }

        function test_preview_contact_with_name()
        {
            contactPreviewPage.contact = createContactWithName()
            tryCompare(contactPreviewPage.header, "title", "Fulano")
        }

        function test_preview_contact_with_name_and_avatar()
        {
            contactPreviewPage.contact = createContactWithNameAndAvatar()
            tryCompare(contactPreviewPage.header, "title", "Fulano")
            var avatarField = findChild(root, "contactAvatarDetail")
            tryCompare(avatarField, "avatarUrl", "image://theme/address-book-app")
        }

        function test_preview_with_full_contact()
        {
            compare(vcardParser.contacts.length, 1)
            var contact =  vcardParser.contacts[0]
            contactPreviewPage.contact = contact
            tryCompare(contactPreviewPage.header, "title", "Forrest Gump")
            // PhoneNumbers
            // TEL;TYPE=WORK,VOICE:(111) 555-12121
            // TEL;TYPE=HOME,VOICE:(404) 555-1212

            // number of phones
            var phoneNumberGroup = findChild(root, "phones")
            var phoneNumbers = findChildOfType(phoneNumberGroup, "BasicFieldView")
            compare(phoneNumbers.length, 2)

            // first phone
            var phoneNumber = findChild(phoneNumberGroup, "label_phoneNumber_0.0")
            var phoneNumberType =  findChild(phoneNumberGroup, "type_phoneNumber_0")
            compare(phoneNumber.text, "(111) 555-12121")
            compare(phoneNumberType.text, "Work")

            // second phone
            phoneNumber = findChild(phoneNumberGroup, "label_phoneNumber_1.0")
            phoneNumberType =  findChild(phoneNumberGroup, "type_phoneNumber_1")
            compare(phoneNumber.text, "(404) 555-1212")
            compare(phoneNumberType.text, "Home")

            // E-mails
            // EMAIL;TYPE=PREF,INTERNET:forrestgump@example.com

            // number of e-mails
            var emailGroup = findChild(root, "emails")
            var emails = findChildOfType(emailGroup, "BasicFieldView")
            compare(emails.length, 2)

            // e-mail address
            var email = findChild(emailGroup, "label_emailAddress_0.0")
            var emailType =  findChild(emailGroup, "type_email_0")
            compare(email.text, "forrestgump@example.com")
            compare(emailType.text, "Home")

            // e-mail address
            var email1 = findChild(emailGroup, "label_emailAddress_1.0")
            var emailType1 =  findChild(emailGroup, "type_email_1")
            compare(email1.text, "bubbagump@example.com")
            compare(emailType1.text, "Home")


            // Address
            // ADR;TYPE=WORK:;;100 Waters Edge;Baytown;LA;30314;United States of America
            // ADR;TYPE=HOME:;;42 Plantation St.;Baytown;LA;30314;United States of America

            // number of addresses
            var addressGroup = findChild(root, "addresses")
            var addresses = findChildOfType(addressGroup, "BasicFieldView")
            compare(addresses.length, 2)

            // first address
            var address_street = findChild(addressGroup, "label_streetAddress_0.0")
            var address_locality = findChild(addressGroup, "label_localityAddress_0.1")
            var address_region = findChild(addressGroup, "label_regionAddress_0.2")
            var address_postCode = findChild(addressGroup, "label_postcodeAddress_0.3")
            var address_country = findChild(addressGroup, "label_countryAddress_0.4")
            var address_type =  findChild(addressGroup, "type_address_0")
            compare(address_street.text, "100 Waters Edge")
            compare(address_locality.text, "Baytown")
            compare(address_region.text, "LA")
            compare(address_postCode.text, "30314")
            compare(address_country.text, "United States of America")
            compare(address_type.text, "Work")

            // second address
            address_street = findChild(addressGroup, "label_streetAddress_1.0")
            address_locality = findChild(addressGroup, "label_localityAddress_1.1")
            address_region = findChild(addressGroup, "label_regionAddress_1.2")
            address_postCode = findChild(addressGroup, "label_postcodeAddress_1.3")
            address_country = findChild(addressGroup, "label_countryAddress_1.4")
            address_type =  findChild(addressGroup, "type_address_1")
            compare(address_street.text, "42 Plantation St.")
            compare(address_locality.text, "Baytown")
            compare(address_region.text, "LA")
            compare(address_postCode.text, "30314")
            compare(address_country.text, "United States of America")
            compare(address_type.text, "Home")

            // Organization
            // ORG:Bubba Gump Shrimp Co.
            // TITLE:Shrimp Man

            // number of organizations
            var orgGroup = findChild(root, "organizations")
            var orgs = findChildOfType(orgGroup, "BasicFieldView")
            compare(orgs.length, 1)

            var org_name = findChild(orgGroup, "label_orgName_0.0")
            var org_role = findChild(orgGroup, "label_orgRole_0.1")
            var org_title = findChild(orgGroup, "label_orgTitle_0.2")

            compare(org_name.text, "Bubba Gump Shrimp Co.")
            compare(org_role.text, "")
            compare(org_title.text, "Shrimp Man")
        }

        function test_click_on_email()
        {
            // load contact from vcard
            compare(vcardParser.contacts.length, 1)
            var contact =  vcardParser.contacts[0]
            contactPreviewPage.contact = contact
            // wait contact be loaded
            waitForRendering(contactPreviewPage);

            // find object 0
            var emailGroup = findChild(root, "emails")
            var email = findChild(emailGroup, "label_emailAddress_0.0")
            tryCompare(email, "text", "forrestgump@example.com")
            tryCompare(email, "visible", true)

            // click on e-mail field
            var spy = root.createSignalSpy(contactPreviewPage, "actionTrigerred");
            mouseClick(email, email.width / 2, email.height / 2)

            tryCompare(spy, "count", 1)
            compare(spy.signalArguments[0][0], "mailto")
            compare(spy.signalArguments[0][2].value(0), "forrestgump@example.com")

            spy.clear()

            // find object 1
            var email1 = findChild(emailGroup, "label_emailAddress_1.0")
            tryCompare(email1, "text", "bubbagump@example.com")
            tryCompare(email1, "visible", true)

            // click on e-mail field
            mouseClick(email1, email1.width / 2, email1.height / 2)

            // check new values
            tryCompare(spy, "count", 1)
            compare(spy.signalArguments[0][0], "mailto")
            compare(spy.signalArguments[0][2].value(0), "bubbagump@example.com")
        }

        function test_editable_property()
        {
            // load any contact
            compare(vcardParser.contacts.length, 1)
            var contact =  vcardParser.contacts[0]
            contactPreviewPage.contact = contact
            tryCompare(contactPreviewPage.header, "title", "Forrest Gump")

            // page is enabled by default
            var avatar = findChild(contactPreviewPage, "avatar")
            var favorite = findChild(contactPreviewPage, "contactFavoriteDetail")

            tryCompare(contactPreviewPage, "editable", true)
            tryCompare(avatar, "editable", true)
            tryCompare(favorite, "enabled", true)

            contactPreviewPage.editable = false

            tryCompare(contactPreviewPage, "editable", false)
            tryCompare(avatar, "editable", false)
            tryCompare(favorite, "enabled", false)

            // click on favorite field
            var spy = root.createSignalSpy(favorite, "clicked");
            mouseClick(favorite, favorite.width / 2, favorite.height / 2)

            // wait the click be processed
            wait(1000)

            // item is disabled, click not accepted
            tryCompare(spy, "count", 0)
        }
    }
}

