
# OSM Scout Server

OSM Scout Server can be used as a drop-in replacement for online map
services providing map tiles, search, and routing. As a result, an
offline operation is possible if the device has a server and map
client programs installed and running. OSM Scout Server is mainly
developed for Sailfish OS, but could be used on a regular Linux
system as a console or QtQuick application.

Here, the user guide is provided with the description of setting up
the server and popular clients for offline operation on Sailfish OS
device. For developer's info, see
[GitHub page](https://github.com/rinigus/osmscout-server) of the
project and it's
[README](https://github.com/rinigus/osmscout-server/blob/master/README.md).


## Mode of operation

In contrast to offline navigation solutions provided by other
applications, the server is one of the two parts that are required by
users. Users would need to have the server and a client accessing the
server running _simultaneously_ and communicating with each
other.

After initial setup, users would mainly have the server running in the
background while accessing maps and getting navigation instructions
through client. The server's GUI is only needed for managing maps on
device.

One mode of operation would require server and client running as two
applications. Alternatively, the server can be activated automatically
on request by the client. Such mode of operation allows client to
access the server without exposing GUI of the server.


## Setting up the server

There are several steps required to setup the server. The following
guide is aimed at Sailfish OS users.

### Modules

In Sailfish OS, the server uses modular approach. While the current
version of the server does not require any modules in default
configuration, some of the modules maybe required for operation in
user selected configuration. The modules, if needed, are checked for
on each start of the server. If needed, the server will request the
module installation. In this case, please proceed to Jolla Store or
OpenRepos and install the corresponding module. After installation of
the modules, please restart the server, if instructed by the
server. The modules are used automatically and don't have to be
started by users.

In other Linux systems, you may need to install separate packages to
install corresponding modules.

At the moment of writing, default configuration does not require any
modules. For raster tiles, fonts would have to be provided for Mapnik
rendering.

### Storage

OSM Scout Server needs to store maps. The storage requirements could
be significant. To store maps and manage them, a separate folder is
required. Please note that, as a part of the managing, OSM Scout
Server can delete, on your command, files from that folder. Thus, its
important to allocate such folder and assign it to OSM Scout
Manager. See [Storage allocation tutorial](storage.html) for example
on how to do it with the help of
[FileCase](https://openrepos.net/content/cepiperez/filecase-0).

### Map Manager

To download, update, and remove maps, use Map Manager. The initial
subscription of the maps and their download is described in
[Map Manager Download tutorial](manager.html).

After the maps are downloaded, you are ready to proceed with the
configuration of your map access client. Select the corresponding
section below to see how to configure it.

### Language selection

The server uses natural language processing (NLP) library that covers
processing of addresses in large number of languages -
[libpostal](https://github.com/openvenues/libpostal). To limit usage
of resources, please specify languages as shown in
[Language selection tutorial](languages.html).

### Profile

To simplify configuration, OSM Scout Server uses profiles. You are
asked to select profile on the first start. Later, you can select
profile as shown in the [Profile selection tutorial](profiles.html).

Clients using MapboxGL tiles (sometimes referred as vector tiles) are
supported by the default OSM Scout Server configuration. At the moment
of writing, its [Pure Maps](https://rinigus.github.io/pure-maps),
[uNav](https://unav.me/), sports application
[Kuri](https://openrepos.net/content/elboberido/kuri), and
(Amazfish)[https://github.com/piggz/harbour-amazfish].

Clients that request rendered tiles from the server, such as
[modRana](https://openrepos.net/content/martink/modrana-0), would
require selection of OSM Scout Server profile that includes _raster
tiles_. Please adjust the profile if you want to use these clients.


### Settings

There are multiple settings that can be useful to tune the operation
of the server. Among other settings, this includes language
preference, units, and whether the server is activated
automatically. See some examples in
[Settings examples](settings_misc.html).


## Setting up the client

After the server has been setup and the maps downloaded, the access to
the server has to be configured in the client(s).

For [Pure Maps](https://github.com/rinigus/pure-maps),
select "Offline" profile in main menu of Pure Maps. This will
configure all services to access OSM Scout Server.
 
For [Poor Maps](https://openrepos.net/content/otsaloma/poor-maps),
instructions are [here](poor_maps.html).

For [modRana](https://openrepos.net/content/martink/modrana-0),
instructions are [here](modrana.html).

After the client is setup, you can use them together with OSM Scout
Server for offline maps access.


## Running

As described above, when using OSM Scout Server, you need to run the
server and client at the same time. There are two ways to do it:
automatic or manual.

### Automatic

Automatic activation would take care of running the server when
accessed via DBus or localhost network access. After some idle period,
the full server process with exit and, depending on the system, a
process will stay to ensure automatic activation on request. For DBus
activation, separate DBus service is installed as a part of the server
installation.

Note that not all supported systems provide means for automatic
activation. Notable exception is Ubuntu Touch where the server has to
be started separately.

#### Automatic via _systemd_

Automatic activation can be enabled through _systemd_ service. If your
Linux distribution is using _systemd_ (Sailfish OS, Debian, and
others) then enable automatic activation in the settings GUI of the
server. This will generate and enable required _systemd_ service and
socket files. For disabling, use Settings GUI of the server.

If you enabled automatic activation then all you have to do is to
start the client.

#### Automatic via included listen mode

For Linux distributions without _systemd_ (postmarketOS, for example),
the server can be started in dedicated socket listening mode by
```
osmscout-server --listen
```

In this case, the server will open a socket and will fork full server
process on request. After the session and expired idle timeout, the
full server process will exit and only the parent socket listening
server will stay. That way the memory caches required for full server
operation will be freed when they are not needed.

As the server is expected to be run by a user and not _root_, it is
suggested to start it in the listening mode as a part of startup
programs on GUI start. How to enable it would depend on distribution,
see distribution documentation for instructions.


### Manual

Manual use would require starting the server and the client by a
user. Below, instructions for Sailfish which are similar in other
distributions:

* Start OSM Scout Server and minimize it as a tile on Sailfish desktop
* Start the client (Poor Maps, modRana, or any other client)
* When finished, close the server and the client.

Note that for Ubuntu Touch, you would have to disable suspending of
the server while it is in background. See instructions at
[OpenStore](https://open-store.io/app/osmscout-server.jonnius)

### Debugging issues

If you have issues with running OSM Scout Server, such as problems
with accessing it from the client, consider enabling logging of _info_
messages. This can be done in the Settings.

## Geocoder 

### Parsers

Parsers are responsible for splitting the entered search string into
the address. Geocoder works using libpostal for parsing entered search
string and is expected to parse the address in its natural form for
the used language/country combination. In addition to automatic
parsing by libpostal, one can use "primitive" parser that takes a
search string, splits it by comma, and constructs the hierarchy
assuming that the search string was entered by listing the address or
POI from the finest details to the region. For example,

```
house_number, street, city
```

As libpostal, primitive parser supports postal codes. For that, enter postal code using `post:` prefix for the code in any part of the hierarchy or just alone to search by the postal code. For example,

```
house_number, street, city, post: 12345
```

or `post:12345`. Note that spaces between keyword `post:` and the postal code are ignored.

### Tags and aliases

To distinguish types of objects, the geocoder uses tags that are imported from OpenStreetMap. Tags are also associated with aliases in a language-dependent manner. The tags and their aliases are listed in [tags](../tags).

Aliases and the tags are imported from the list of special phrases
maintained for Nominatim at
[https://wiki.openstreetmap.org/wiki/Nominatim/Special_Phrases](https://wiki.openstreetmap.org/wiki/Nominatim/Special_Phrases). If
you find something missing or want to correct it, please correct it at
the source.


## Implementation of automatic activation

To enable automatic activation, OSM Scout Server interfaces with
_systemd_ by creating _service_ and _socket_ files in the home
directory of the user running the server. In addition, the socket
activation is enabled by running `systemctl`. In Sailfish, that
results in creating or modification of

```
/home/nemo/.config/systemd/user/osmscout-server.service
/home/nemo/.config/systemd/user/osmscout-server.socket
/home/nemo/.config/systemd/user/user-session.target.wants
```

If you wish to remove the automatic activation manually, run

```
systemctl --user disable osmscout-server.socket
```

and then remove _service_ and _socket_ files. In Sailfish, remove
```
/home/nemo/.config/systemd/user/osmscout-server.service
/home/nemo/.config/systemd/user/osmscout-server.socket
```
