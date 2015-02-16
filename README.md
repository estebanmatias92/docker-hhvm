# Supported tags and respective `Dockerfile` links

-      [`3.3.3-cli`, `3.3-cli`, `3.3.3`, `3.3` (*3.3/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.3/Dockerfile)
-      [`3.3.3-fastcgi`, `3.3-fastcgi` (*3.3/fastcgi/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.3/fastcgi/Dockerfile)
-      [`3.4.2-cli`, `3.4-cli`, `3.4.2`, `3.4` (*3.4/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.4/Dockerfile)
-      [`3.4.2-fastcgi`, `3.4-fastcgi` (*3.4/fastcgi/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.4/fastcgi/Dockerfile)
-      [`3.5.0-cli`, `3.5-cli`, `3-cli`, `cli`, `3.5.0`, `3.5`, `3`, `latest` (*3.5/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.5/Dockerfile)
-      [`3.5.0-fastcgi`, `3.5-fastcgi`, `3-fastcgi`, `fastcgi` (*3.5/fastcgi/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.5/fastcgi/Dockerfile)

# What is HHVM?

HipHop Virtual Machine (HHVM) is a process virtual machine based on just-in-time (JIT) compilation, serving as an execution engine for PHP and Hack programming languages. By using the principle of JIT compilation, executed PHP or Hack code is first transformed into intermediate HipHop bytecode (HHBC), which is then dynamically translated into the x86-64 machine code, optimized and natively executed.

> [wikipedia.org/wiki/HipHop_Virtual_Machine](https://en.wikipedia.org/wiki/HipHop_Virtual_Machine)

![logo](https://raw.githubusercontent.com/estebanmatias92/docker-hhvm/master/logo.png)

# How to use this image

## With command line

For PHP projects run through the command line interface (CLI), you can do the following.

### Create a `Dockerfile` in your PHP project

       FROM estebanmatias92/hhvm:3.5-cli
       COPY . /usr/src/myapp
       WORKDIR /usr/src/myapp
       CMD [ "hhvm", "./your-script.php" ]

Then, run the commands to build and run the Docker image:

       docker build -t my-php-app .
       docker run -it --rm --name my-running-app my-php-app

### Run a single PHP script

For many simple, single file projects, you may find it inconvenient to write a complete `Dockerfile`. In such cases, you can run a PHP script by using the HHVM image directly:

       docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp estebanmatias92/hhvm:3.5-cli hhvm your-script.php

## How to install more HHVM extensions

This image comes with a script named `hhvm-ext-install`, you can use it to easily install HHVM extension.

As HHVM comes with a [large number of extensions](https://github.com/facebook/hhvm/wiki/Extensions) installed/enabled, this script only will help you to install the (non-official-yet) HHVM extensions available on Github.

So you have to pass the repositories (could be one or many) as argument for `hhvm-ext-install`.

For example, if you want to have a FastCGI image with [`geoip`](https://github.com/vipsoft/hhvm-ext-geoip) extension, you can inheriting the base image that you like, and write your own `Dockerfile` like this:

       FROM estebanmatias92/hhvm:3.4-fastcgi
       RUN apt-get update && apt-get install -y \
           libgeoip-dev libgeoip1 \
           && rm -rf /var/lib/apt/lists/* \
           && hhvm-ext-install vipsoft/hhvm-ext-geoip
       ENTRYPOINT [“/usr/local/bin/hhvm”]
       CMD [“--mode”, “server”]

Remember, you must install dependencies for your extensions manually.

# License

View [license information](https://github.com/facebook/hhvm#license) for the software contained in this image.

# User Feedback

## Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/estebanmatias92/docker-hhvm/issues).

## Contributing

You are invited to contribute new features, fixes, or updates, large or small. Every contribution are welcome.

# Disclaimer

If emerge an official HHVM Docker image, this image will be deprecated, and eventually when the current version becomes in the old stable version, it will be removed.
