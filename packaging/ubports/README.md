# Ubuntu Touch Packaging

## Preparations

Install [Clickable](http://clickable.bhdouglass.com/en/latest/install.html)
which is used to build and publish click packages.

You may want to create a symlink to the config file to omit the `-c` flag in
all clickable calls:

    ln -s packaging/ubports/clickable.json clickable.json

Otherwise you'll have to append `-c packaging/ubports/clickable.json` to all
clickable commands.

## Dependencies

**WARNING**: Dependencies may take hours to build.

Run the following command to download and compile the app dependencies:

    clickable prepare-deps
    clickable build-libs --arch armhf # for armhf devices
    clickable build-libs --arch arm64 # for arm64 devices
    clickable build-libs --arch amd64 # for desktop mode

## Building

Build the app by running

    clickable build --arch armhf # for armhf devices
    clickable build --arch arm64 # for arm64 devices
    clickable build --arch amd64 # for desktop mode

## Debugging

To debug on a Ubuntu Touch device simply run

    clickable # implies a clean build run, installing on device and launching
    clickable logs # to watch logs

To debug on the desktop run of these:

    clickable desktop # implies a clean build run
    clickable desktop --dirty # avoid clean before build
    clickable desktop --skip-build # start app without building

See [Clickable docs](http://clickable.bhdouglass.com/en/latest/) for details.
