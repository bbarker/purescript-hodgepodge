# purescript-hodgepodge

This is a docker container targeted at purescript development, and secondarily,
could be used for deployment. Just as importantly, it is a runner for that docker
container that containes many host mount points to make development proceed smoothly.

Currently it includes:

* `bower`
* `npm`
* `parcel-bundler`
* `pulp`
* `purescript`
* `spago`

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
can feel free to build a local alternative and modify `psc.sh` to use that (just
comment out the `docker pull` command and set ``DHUB_PREFIX=""`). This could probably be streamlined a bit
(submit a PR!).

If you want to build the container, just set the `PS_VERSION` in `build.socker.sh`
and then run it.

## Pushing the container

Mainly for me:

```
docker tag purescript-hodgepodge:<version> bbarker/purescript-hodgepodge:latest
docker push bbarker/purescript-hodgepodge:<version>
docker push bbarker/purescript-hodgepodge:latest
```
