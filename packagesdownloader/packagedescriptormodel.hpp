#ifndef PACKAGEDESCRIPTORMODEL_HPP
#define PACKAGEDESCRIPTORMODEL_HPP

#include <QAbstractListModel>
#include <QObject>
#include "packagedescriptor.hpp"


class PackageDescriptorModel : public QAbstractListModel
{
public:
    explicit PackageDescriptorModel(QList<PackageDescriptor*> newDescriptors, QObject *parent = nullptr);

    int rowCount(const QModelIndex& parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

private:
    QList<PackageDescriptor*> descriptors;
};

#endif // PACKAGEDESCRIPTORMODEL_HPP
