/*
Copyright (C) THEDATE Ignatev Daniil
This file is part of RudironInstaller <https://github.com/>.

RudironInstaller is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

RudironInstaller is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with RudironInstaller. If not, see <http://www.gnu.org/licenses/>.
*/

#include "packagedescriptormodel.hpp"

PackageDescriptorModel::PackageDescriptorModel(QList<PackageDescriptor*> newDescriptors, QObject *parent)
    : QAbstractListModel{parent}
{
    this->descriptors = newDescriptors;
}

int PackageDescriptorModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return this->descriptors.count();
}

QVariant PackageDescriptorModel::data(const QModelIndex &index, int role) const
{
    Q_UNUSED(role)
    QVariant value = QVariant::fromValue<PackageDescriptor*>(this->descriptors[index.row()]);
    return value;
}

QHash<int, QByteArray> PackageDescriptorModel::roleNames() const
{
    static QHash<int, QByteArray> *pHash;
    if (!pHash) {
        pHash = new QHash<int, QByteArray>;
        (*pHash)[Qt::UserRole + 1] = "dataObject";
    }
    return *pHash;
}

int PackageDescriptorModel::count()
{
    return this->descriptors.count();
}
