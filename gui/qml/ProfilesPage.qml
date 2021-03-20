/*
 * Copyright (C) 2016-2019 Rinigus https://github.com/rinigus
 *                    2019 Purism SPC
 *
 * This file is part of OSM Scout Server.
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
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import "."
import "platform"

DialogPL {
    id: dialog
    canAccept: manager.ready
    title: qsTr("Profile")

    Column {
        id: column

        width: dialog.width
        spacing: styler.themePaddingLarge

        ListItemLabel {
            font.pixelSize: styler.themeFontSizeMedium
            text: qsTr("OSM Scout Server uses profiles to simplify the selection " +
                       "of backends and the sets of downloaded databases.<br><br>" +
                       "Please select active profile."
                       )
        }

        ComboBoxPL {
            id: profileSelection
            enabled: manager.ready
            label: qsTr("Profile")
            model: settings.availableProfiles()
            Component.onCompleted: {
                currentIndex = settings.currentProfile();
            }
        }

        ListItemLabel {
            font.pixelSize: styler.themeFontSizeMedium
            text: qsTr("<i>Default</i> profile supports map applications using <i>Mapbox GL</i> plugin, uses " +
                       "<i>Geocoder-NLP</i> to search for locations, " +
                       "and <i>Valhalla</i> to calculate the routes. " +
                       "This profile is a recommended one for new vector tile map clients.<br><br>" +

                       "For users with map applications using traditional raster tiles, " +
                       "the recommended profile for raster tiles maps includes <i>Mapnik</i> datasets and uses " +
                       "the same search and routing plugins as the <i>Default</i> profile.<br><br>" +

                       "For users wishing to use raster and vector tile map clients, " +
                       "the recommended profile combining vector and raster tiles includes <i>Mapbox GL</i> datasets, supports " +
                       "map rendering into raster tiles by <i>Mapnik</i>, and uses " +
                       "the same search and routing plugins as the <i>Default</i> profile. Since this profile includes " +
                       " data for multiple rendering backends, it has the largest storage requirements.<br><br>" +

                       "The profile where <i>libosmscout</i> is combined with <i>Geocoder-NLP</i> " +
                       "has smaller storage requirements when compared to the default one. " +
                       "However, rendering of the maps and routing would be limited only to one territory. " +
                       "In addition, rendering quality is inferior and routing speed is slower when compared to " +
                       "the default profile.<br><br>" +

                       "<i>libosmscout</i> profile has the smallest storage requirements among all profiles. " +
                       "However, rendering of the maps, search, and routing would be limited only to one territory. " +
                       "In addition, rendering quality and search is inferior as well as " +
                       "routing speed is slower  when compared to " +
                       "the default profile.<br><br>" +

                       "When using <i>Custom</i> profile, Settings and Map Manager Storage are not set by profiles " +
                       "and should be specified by user. " +
                       "This profile allows to select rendering, search, and routing components individually. Note that " +
                       "the user is responsible for adjusting the settings to make them consistent between requirements of " +
                       "the used backends and storage." )
        }

        ListItemLabel {
            font.pixelSize: styler.themeFontSizeMedium
            text: qsTr("Please note that some profiles maybe missing due to the packaging of OSM Scout Server.")
        }
    }

    onAccepted: {
        if (manager.ready)
            settings.setCurrentProfile(profileSelection.currentIndex)
    }
}
