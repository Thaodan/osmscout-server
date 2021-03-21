/*
 * Copyright (C) 2016-2018 Rinigus https://github.com/rinigus
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

#ifndef CONFIG_H
#define CONFIG_H

#ifndef APP_NAME
#define APP_NAME "osmscout-server"
#endif

// global configuration settings

#define GENERAL_SETTINGS "server-general/"

#define MAPMANAGER_SETTINGS "maps/"

#define OSM_SETTINGS "libosmscout/"
#define ROUTING_SPEED_SETTINGS "libosmscout-speed/"

#define GEOMASTER_SETTINGS "geocoder-nlp/"

#define MAPNIKMASTER_SETTINGS "mapnik/"

#define VALHALLA_MASTER_SETTINGS "valhalla/"

#define HTTP_SERVER_SETTINGS "http-listener/"

#define REQUEST_MAPPER_SETTINGS "request-mapper/"

#define GENERAL_APP_VERSION 4

// d-bus access
#define DBUS_SERVICE "io.github.rinigus.OSMScoutServer"
#define DBUS_PATH_ROOT "/io/github/rinigus/OSMScoutServer"
#define DBUS_INTERFACE_ROOT "io.github.rinigus.OSMScoutServer"

#define DBUS_PATH_MAPMATCHING DBUS_PATH_ROOT "/mapmatching"
#define DBUS_INTERFACE_MAPMATCHING DBUS_INTERFACE_ROOT ".mapmatching"

//////////////////////////////////////////////
/// global variables

#include "dbmaster.h"
#include "geomaster.h"
#include "mapboxglmaster.h"
#include "mapnikmaster.h"
#include "valhallamaster.h"

#include <atomic>

#ifdef USE_OSMSCOUT
extern DBMaster *osmScoutMaster;
#endif

extern GeoMaster *geoMaster;

extern MapboxGLMaster *mapboxglMaster;

#ifdef USE_MAPNIK
extern MapnikMaster *mapnikMaster;
#endif

#ifdef USE_VALHALLA
extern ValhallaMaster *valhallaMaster;
#endif

extern std::atomic<bool> useGeocoderNLP;
extern std::atomic<bool> useMapnik;
extern std::atomic<bool> useValhalla;

#endif // CONFIG_H
