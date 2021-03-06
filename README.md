# Supported tags and respective `Dockerfile` links

-      [`3.6.5-cli`, `3.6-cli`, `3.6.5`, `3.6` (*3.6/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.6/Dockerfile)
-      [`3.6.5-fastcgi`, `3.6-fastcgi` (*3.6/fastcgi/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.6/fastcgi/Dockerfile)
-      [`3.7.3-cli`, `3.7-cli`, `3.7.3`, `3.7` (*3.7/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.7/Dockerfile)
-      [`3.7.3-fastcgi`, `3.7-fastcgi` (*3.7/fastcgi/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.7/fastcgi/Dockerfile)
-      [`3.8.1-cli`, `3.8-cli`, `3-cli`, `cli`, `3.8.1`, `3.8`, `3`, `latest` (*3.8/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.8/Dockerfile)
-      [`3.8.1-fastcgi`, `3.8-fastcgi`, `3-fastcgi`, `fastcgi` (*3.8/fastcgi/Dockerfile*)](https://github.com/estebanmatias92/docker-hhvm/blob/master/3.8/fastcgi/Dockerfile)

# What is HHVM?

HipHop Virtual Machine (HHVM) is a process virtual machine based on just-in-time (JIT) compilation, serving as an execution engine for PHP and Hack programming languages. By using the principle of JIT compilation, executed PHP or Hack code is first transformed into intermediate HipHop bytecode (HHBC), which is then dynamically translated into the x86-64 machine code, optimized and natively executed.

> [wikipedia.org/wiki/HipHop_Virtual_Machine](https://en.wikipedia.org/wiki/HipHop_Virtual_Machine)

![logo](https://raw.githubusercontent.com/estebanmatias92/docker-hhvm/master/logo.png)

# How to use this image

## With command line

For PHP projects run through the command line interface (CLI), you can do the following.

### Create a `Dockerfile` in your PHP project

       FROM estebanmatias92/hhvm:3.8-cli
       COPY . /usr/src/myapp
       WORKDIR /usr/src/myapp
       CMD [ "hhvm", "./your-script.php" ]

Then, run the commands to build and run the Docker image:

       docker build -t my-php-app .
       docker run -it --rm --name my-running-app my-php-app

### Run a single PHP script

For many simple, single file projects, you may find it inconvenient to write a complete `Dockerfile`. In such cases, you can run a PHP script by using the HHVM image directly:

       docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp estebanmatias92/hhvm:3.8-cli hhvm your-script.php

## How to install more HHVM extensions

This image comes with a script named `hhvm-ext-install`, you can use it to easily install HHVM extension.

As HHVM comes with a [large number of extensions](https://github.com/facebook/hhvm/wiki/Extensions) installed/enabled, this script only will help you to install the (non-official-yet) HHVM extensions available on Github.

So you have to pass the repositories (could be one or many) as argument for `hhvm-ext-install`.

For example, if you want to have a FastCGI image with [`pgsql`](https://github.com/dstelter/hhvm-pgsql) extension, you can inheriting the base image that you like, and write your own `Dockerfile` like this:

       FROM estebanmatias92/hhvm:3.7-fastcgi
       RUN apt-get update && apt-get install -y libpq-dev && rm -rf /var/lib/apt/lists/* \
           && hhvm-ext-install dstelter/hhvm-pgsql
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
Update this requires ["jq"](https://stedolan.github.io/jq/) linux package.
