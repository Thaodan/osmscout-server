/* -*- coding: utf-8-unix -*-
 *
 * Copyright (C) 2018-2019 Rinigus, 2019 Purism SPC
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
import QtQuick.Controls 2.2

Drawer {
    id: menu
    height: app.height
    width: {
        var w = app.width / 3;
        for (var i=0; i < content.length; i++)
            w = Math.max(w, content[i].implicitWidth)
        return w;
    }

    property string         banner // added for compatibility
    default property alias  content: column.data
    property bool           enabled: true // https://github.com/rinigus/osmscout-server/issues/374
    property string         title // added for compatibility
    property string         titleIcon // added for compatibility

    Column {
        id: column
        width: parent.width
    }
}
