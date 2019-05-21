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
* For passing mutiple arguments: TODO

# Using the container

## Tightly coupled with host OS

* Run a command , e.g. `./psc.sh npm run build`. This will run `npm run build`
in the container with the CWD mounted and then exit. Alternatively
if you want to issue multiple commands in the container quickly, you can run
`./psc.sh bash`.

You can also put `psc.sh` somewhere in your `PATH` for convenience, and/or
copy it into your projects.

## Isolated from Host OS

Same as the above tightly coupled isntructions, but use the `psc_isolated.sh`
variant. The container is stopped but not deleted when finished, so you can copy
files out, e.g.

```
TODO
```

# Building the container

`psc.sh` will automatically pull the latest container from DockerHub, but you
can feel free to build a local alternative and use `./psc_local.sh` (which is
just a wrapper for `psc.sh`), or a modification thereof.

If you want to build the container, just set the `PS_VERSION` in `build-docker.sh`
and then run it.

## Pushing the container

Update the `RELEASE` and/or `PS_VERSION` as needed in `build-docker.sh`
(generally needed if it isn't a minor release), the build a new image
by running `build-docker.sh`.

Then see `push.sh`.

