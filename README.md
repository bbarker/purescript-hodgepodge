# purescript-hodgepodge

This is a docker container targeted at purescript development, and secondarily,
could be used for deployment. Just as importantly, it is a runner for that docker
container that containes many host mount points to make development proceed smoothly.

Currently it includes:

* `bower`
* `npm`
* `parcel-bundler`
* `psc-package`
* `pulp`
* `purescript`
* `spago`
* `yarn`

## Caveats
* Only tested on Linux (Ubuntu), but would like to hear of experience on other
  systems.

# Using the container

* Run a command , e.g. `./psc.sh npm run build`. This will run `npm run build`
in the container with the CWD mounted and then exit. Alternatively
if you want to issue multiple commands in the container quickly, you can run
`./psc.sh bash`.

You can also put `psc.sh` somewhere in your `PATH` for convenience, and/or
copy it into your projects.


# Building the container

`psc.sh` will automatically pull the latest container from DockerHub, but you
can feel free to build a local alternative and use `./psc_local.sh` (which is
just a wrapper for `psc.sh`), or a modification thereof.

If you want to build the container, just set the `PS_VERSION` in `build.socker.sh`
and then run it.

## Pushing the container

See `push.sh`.
