FROM estebanmatias92/hhvm:3.5

MAINTAINER "Matias Esteban" <estebanmatias92@gmail.com>

# Copy config files
COPY config/hhvm/php.ini /etc/hhvm/php.ini

# Forward error logs to the container log devices
RUN ln -sf /dev/stderr /var/log/hhvm/error.log

WORKDIR /var/www

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/hhvm"]

CMD ["--mode", "server"]
