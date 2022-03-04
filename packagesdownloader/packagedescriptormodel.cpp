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
