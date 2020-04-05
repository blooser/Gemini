#ifndef DATABASETABLES_H
#define DATABASETABLES_H

#include "databasecore.h"

#include <functional>

#include <QString>
#include <QVector>

namespace database {

extern const QVector<std::function<bool (const QSqlDatabase&)>> Tables {
        std::bind(qOverload<const QSqlDatabase &, const QLatin1String &>(&database::core::run), std::placeholders::_1, QLatin1String("CREATE TABLE wallpapers ("
                                                                                                                                     "`id` INTEGER PRIMARY KEY,"
                                                                                                                                     "`name` TEXT NOT NULL,"
                                                                                                                                     "`url` TEXT NOT NULL UNIQUE"
                                                                                                                                     ")")),

        std::bind(qOverload<const QSqlDatabase &, const QLatin1String &>(&database::core::run), std::placeholders::_1, QLatin1String("CREATE TABLE playlists ("
                                                                                                                                     "`id` INTEGER PRIMARY KEY AUTOINCREMENT,"
                                                                                                                                     "`name` TEXT NOT NULL UNIQUE"
                                                                                                                                     ")")),

        std::bind(qOverload<const QSqlDatabase &, const QLatin1String &>(&database::core::run), std::placeholders::_1, QLatin1String("CREATE TABLE songs ("
                                                                                                                                     "`id` INTEGER PRIMARY KEY AUTOINCREMENT,"
                                                                                                                                     "`name` TEXT NOT NULL,"
                                                                                                                                     "`url` TEXT NOT NULL UNIQUE"
                                                                                                                                     ")")),

        std::bind(qOverload<const QSqlDatabase &, const QLatin1String &>(&database::core::run), std::placeholders::_1, QLatin1String("CREATE TABLE relations ("
                                                                                                                                     "`playlist` INTEGER NOT NULL,"
                                                                                                                                     "`song` INTEGER NOT NULL"
                                                                                                                                     ")")),

        std::bind(qOverload<const QSqlDatabase &, const QLatin1String &>(&database::core::run), std::placeholders::_1, QLatin1String("CREATE TABLE pending ("
                                                                                                                                     "`id` INTEGER PRIMARY KEY AUTOINCREMENT,"
                                                                                                                                     "`url` TEXT NOT NULL UNIQUE,"
                                                                                                                                     "`done` INTEGER DEFAULT 0"
                                                                                                                                     ")"))
    };
}


#endif // DATABASETABLES_H
