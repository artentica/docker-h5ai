# h5ai

[h5ai](http://larsjung.de/h5ai/) is a modern web server index.
This [docker](https://www.docker.io/) image makes it trivially easy to
spin up a webserver and start sharing your files through the web.

![screenshot](./sc.png)

See also the [demo directory](http://larsjung.de/h5ai/sample).

## Usage

This docker image is available as a [trusted build on the docker index](https://index.docker.io/u/clue/h5ai/),
so there's no setup required.
Using this image for the first time will start a download automatically.
Further runs will be immediate, as the image will be cached locally.

The recommended way to run this container looks like this:

```bash
$ sudo docker run -it --rm -p 80:80 -v `pwd`:/var/www artentica/h5ai
```

You can now point your webbrowser to this URL:

```
http://localhost/
```

This is a rather common setup following docker's conventions:

* `-it` will run an interactive session that can be terminated with CTRL+C
* `--rm` will run a temporary session that will make sure to remove the container on exit
* `-v {AnyDirectory}:/var/www` will mount the given directory as the base directory for the browsable directory index
* `-p {OutsidePort}:80` will bind the webserver to the given outside port
* `clue/h5ai` the name of this docker image

This docker have:
* php7.0
* Last version of h5ai
