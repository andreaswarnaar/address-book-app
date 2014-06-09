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

import QtQuick 2.2
import QtContacts 5.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

/*!
    \qmltype ContactListView
    \inqmlmodule Ubuntu.Contacts 0.1
    \ingroup ubuntu
    \brief The ContactListView provides the contact list view integrated with the Favorite List View

    The ContactListView is based on ContactSimpleListView and provide a easy way to show the contact
    list view with all default visuals defined by Ubuntu system.

    Example:
    \qml
        import Ubuntu.Contacts 0.1

        ContactListView {
            anchors.fill: parent
            onContactClicked: console.debug("Contact ID:" + contact.contactId)
        }
    \endqml
*/
Item {
    id: root

    property alias view: view
    property alias count: view.count

    /*!
      \qmlproperty string contactNameFilter

      This property holds a string that will be used to filter contacts on the list
      By default this is set to empty
    */
    property string contactNameFilter: ""
    /*!
      \qmlproperty bool showFavourites

      This property holds if the option to switch between favourite and all contacts should be visible
      By default this is set to true.
    */
    property alias showFavourites: view.showFavourites
    /*!
      \qmlproperty bool showAvatar

      This property holds if the contact avatar will appear on the list or not.
      By default this is set to true.
    */
    property alias showAvatar: view.showAvatar
    /*!
      \qmlproperty int titleDetail

      This property holds the contact detail which will be used to display the contact title in the delegate
      By default this is set to ContactDetail.Name.
    */
    property alias titleDetail: view.titleDetail
    /*!
      \qmlproperty list<int> titleFields

      This property holds the list of all fields which will be used to display the contact title in the delegate
      By default this is set to [ Name.FirstName, Name.LastName ]
    */
    property alias titleFields: view.titleFields
    /*!
      \qmlproperty list<SortOrder> sortOrders

      This property holds a list of sort orders used by the contacts model.
      \sa SortOrder
    */
    property alias sortOrders: view.sortOrders
    /*!
      \qmlproperty FetchHint fetchHint

      This property holds the fetch hint instance used by the contact model.

      \sa FetchHint
    */
    property alias fetchHint: view.fetchHint
    /*!
      \qmlproperty Filter filter

      This property holds the filter instance used by the contact model.

      \sa Filter
    */
    property alias filter: view.filter
    /*!
      \qmlproperty bool multiSelectionEnabled

      This property holds if the multi selection mode is enabled or not
      By default this is set to false
    */
    property alias multiSelectionEnabled: view.multiSelectionEnabled
    /*!
      \qmlproperty string defaultAvatarImage

      This property holds the default image url to be used when the current contact does
      not contains a photo
    */
    property alias defaultAvatarImageUrl: view.defaultAvatarImageUrl
    /*!
      \qmlproperty bool loading

      This property holds when the model still loading new contacts
    */
    readonly property alias loading: view.loading
    /*!
      \qmlproperty int detailToPick

      This property holds the detail type to be picked
    */
    property alias detailToPick: view.detailToPick
    /*!
      \qmlproperty int currentIndex

      This property holds the current active item index
    */
    property alias currentIndex: view.currentIndex
    /*!
      \qmlproperty bool showSections

      This property holds if the listview will show or not the section headers
      By default this is set to true
    */
    property alias showSections: view.showSections
    /*!
      \qmlproperty string manager

      This property holds the manager uri of the contact backend engine.
      By default this is set to "galera"
    */
    property alias manager: view.manager
    /*!
      \qmlproperty bool fastScrolling

      This property holds if the listview is in fast scroll mode or not
    */
    property alias fastScrolling: fastScroll.fastScrolling
    /*!
      \qmlproperty Action leftSideAction

      This property holds the available actions when swipe the contact item from left to right
    */
    property alias leftSideAction: view.leftSideAction
    /*!
      \qmlproperty list<Action> rightSideActions

      This property holds the available actions when swipe the contact item from right to left
    */
    property alias rightSideActions: view.rightSideActions
    /*!
      \qmlproperty model selectedItems

      This property holds the list of selected items
    */
    readonly property alias selectedItems: view.selectedItems
    /*!
      \qmlproperty bool multipleSelection

      This property holds if the selection will accept multiple items or single items
    */
    property alias multipleSelection: view.multipleSelection
    /*!
      \qmlproperty model listModel

      This property holds the model providing data for the list.
    */
    property alias listModel: view.listModel
    /*!
      \qmlproperty Component listDelegate

      The delegate provides a template defining each item instantiated by the view.
    */
    property alias listDelegate: view.listDelegate
    /*!
      \qmlproperty bool isInSelectionMode

      This property holds a list with the index of selected items
    */
    readonly property alias isInSelectionMode: view.isInSelectionMode
    /*!
      This handler is called when the selection mode is finished without be canceled
    */
    signal selectionDone(var items)
    /*!
      This handler is called when the selection mode is canceled
    */
    signal selectionCanceled()
    /*!
      This handler is called when any error occurs in the contact model
    */
    signal error(string message)
    /*!
      This handler is called when details button on contact delegate is clicked
    */
    signal infoRequested(QtObject contact)
    /*!
      This handler is called when any contact detail in the list receives a click
    */
    signal detailClicked(QtObject contact, QtObject detail, string action)
    /*!
      This handler is called when the contact delegate disapear (height === 0) caused by the function call makeDisappear
    */
    signal contactDisappeared(QtObject contact)

    function startSelection()
    {
        view.startSelection()
    }

    function isSelected(item)
    {
        return view.isSelected(item)
    }
    function selectItem(item)
    {
        return view.selectItem(item)
    }
    function deselectItem(item)
    {
        return view.deselectItem(item)
    }
    function endSelection()
    {
        view.endSelection()
    }
    function cancelSelection()
    {
        view.cancelSelection()
    }
    function clearSelection()
    {
        view.clearSelection()
    }
    function selectAll()
    {
        view.selectAll()
    }
    function returnToBounds()
    {
        view.returnToBounds()
    }
    function positionViewAtContact(contact)
    {
        view.positionViewAtContact(contact)
    }
    function positionViewAtBeginning()
    {
        view.positionViewAtBeginning()
    }
    function changeFilter(newFilter)
    {
        if (root.count > 0) {
            contactsModel._clearModel = true
        }
        root.filter = newFilter
    }

    Rectangle {
        id: itemHeader

        height: units.gu(2)
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        color: Theme.palette.normal.overlay

        Row {
            anchors.fill: parent
            Label {
                id: lblAll

                anchors {
                    top: parent.top
                    bottom: parent.bottom
                }
                width: parent.width / 2
                text: i18n.dtr("address-book-app", "All")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: root.showFavourites ? UbuntuColors.warmGrey : UbuntuColors.orange
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        //WORKAROUND: clear the model before start populate it with the new contacts
                        //otherwise the model will wait for all contacts before show any new contact
                        root.changeFilter(root.filter)
                        root.showFavourites = false
                    }
                }
            }

            Rectangle {
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    margins: units.gu(1)
                }
                width: 1
            }

            Label {
                id: lblFavourites

                anchors {
                    top: parent.top
                    bottom: parent.bottom
                }
                width: parent.width / 2
                text: i18n.dtr("address-book-app", "Favourites")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: root.showFavourites ? UbuntuColors.orange : UbuntuColors.warmGrey
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.showFavourites = true
                }
            }
        }
    }

    onContactNameFilterChanged: contactSearchTimeout.restart()

    ContactSimpleListView {
        id: view

        property bool showFavourites: false

        function getSectionText(index) {
            var tag = listModel.contacts[index].tag.tag
            if (tag == "")
                return "#"
            else
                return tag
        }

        anchors {
            top: itemHeader.bottom
            left: parent.left
            right: parent.right
            rightMargin: fastScroll.showing ? fastScroll.width - units.gu(1) : 0
            bottom: parent.bottom

            Behavior on rightMargin {
                UbuntuNumberAnimation {}
            }
        }

        onError: root.error(message)
        onInfoRequested: root.infoRequested(contact)
        onDetailClicked: root.detailClicked(contact, detail, action)
        onSelectionDone: root.selectionDone(items)
        onSelectionCanceled: root.selectionCanceled()
        onContactDisappeared: root.contactDisappeared(contact)
        clip: true

        InvalidFilter {
            id: invalidFilter
        }

        DetailFilter {
            id: favouritesFilter

            detail: ContactDetail.Favorite
            field: Favorite.Favorite
            value: true
            matchFlags: DetailFilter.MatchExactly
        }

        IntersectionFilter {
            id: contactsFilter

            property bool active: false

            filters: {
                var filters = []
                if (root.showFavourites) {
                    filters.push(favouritesFilter)
                }
                if (root.filter) {
                    filters.push(root.filter)
                }
                if (nameFilter.value && (nameFilter.value.length > 0)) {
                    filters.push(nameFilter)
                }
                active = (filters.length > 0)
                return filters
            }
        }

        DetailFilter {
            id: nameFilter

            detail: ContactDetail.DisplayLabel
            field: DisplayLabel.Label
            value: root.nameFilter
            matchFlags: DetailFilter.MatchContains
        }

        Timer {
            id: contactSearchTimeout

            running: false
            repeat: false
            interval: 300
            onTriggered: {
                if (root.contactNameFilter === "") { // if the search criteria is empty clear the list before show all contacts
                    contactList.changeFilter(root.filter)
                    nameFilter.value = ""
                } else {
                    if (nameFilter.value === "") { // if the search starts clear the list before show results
                        contactList.changeFilter(root.filter)
                    }
                    nameFilter.value = root.contactNameFilter
                }
            }
        }

        listModel: ContactModel {
            id: contactsModel

            property bool _clearModel: false

            manager: root.manager
            sortOrders: root.sortOrders
            fetchHint: root.fetchHint
            filter: {
                if (contactsModel._clearModel) {
                    return invalidFilter
                } else if (contactsFilter.active) {
                    return contactsFilter
                } else {
                    return null
                }
            }

            onErrorChanged: {
                if (error) {
                    console.error("Contact List error:" + error)
                }
            }

            onContactsChanged: {
                //WORKAROUND: clear the model before start populate it with the new contacts
                //otherwise the model will wait for all contacts before show any new contact

                //after all contacts get removed we can populate the model again, this will show
                //new contacts as soon as it arrives in the model
                if (contactsModel._clearModel && contacts.length === 0) {
                    contactsModel._clearModel = false
                }
            }
        }
    }

    FastScroll {
        id: fastScroll

        listView: view
        // only enable FastScroll if the we have more than 2 pages of content
        enabled: view.contentHeight > (view.height * 2)

        anchors {
            top: itemHeader.bottom
            topMargin: units.gu(0.5)
            bottom: parent.bottom
            right: parent.right
        }
    }
}
