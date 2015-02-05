/*
 * Copyright (C) 2015 Canonical, Ltd.
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

#ifndef SIMCARDCONTACTS_H
#define SIMCARDCONTACTS_H

#include <QObject>
#include <QMutex>

#include <qofonomanager.h>
#include <qofonophonebook.h>

class SimCardContacts : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString contacts READ contacts NOTIFY contactsChanged)
    Q_PROPERTY(QUrl vcardFile READ vcardFile NOTIFY contactsChanged)

public:
    SimCardContacts(QObject *parent=0);
    ~SimCardContacts();

    QString contacts() const;
    QUrl vcardFile() const;

Q_SIGNALS:
    void contactsChanged();

private Q_SLOTS:
    void onModemChanged();
    void onPhoneBookImported(const QString &vcardData);
    void onPhoneBookImportFail();
    void onPhoneBookIsValidChanged(bool isValid);
    void onImportTimeOut();

private:
    QScopedPointer<QOfonoManager> m_ofonoManager;
    QList<QOfonoPhonebook*> m_pendingModems;
    QTemporaryFile *m_dataFile;
    QStringList m_vcards;
    QMutex m_importing;
    QTimer m_importTimeOut;

    void writeData();
    void reloadContacts();
    void cancel();
    void importDone();

};

#endif
