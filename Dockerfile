FROM clearlinux:latest AS builder

ENV VERSION_ID 33620

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args

COPY --from=clearlinux/os-core:latest /usr/lib/os-release /

RUN source /os-release

RUN mkdir /install_root

RUN swupd os-install -V $VERSION_ID \
    --path /install_root --statedir /swupd-state \
    --bundles=os-core-update,php-basic,curl --no-boot-update

RUN mkdir /os_core_install

COPY --from=clearlinux/os-core:latest / /os_core_install/

RUN cd / && \
    find os_core_install | sed -e 's/os_core_install/install_root/' | xargs rm -d &> /dev/null || true


FROM clearlinux/os-core:latest

COPY --from=builder /install_root /

RUN set -ex \
	mkdir -p /var/www/html \
	&& cd /usr/share/defaults/php \
	&& { \
		echo '[global]'; \
		echo 'error_log = /proc/self/fd/2'; \
		echo; echo '; https://github.com/docker-library/php/pull/725#issuecomment-443540114'; echo 'log_limit = 8192'; \
		echo; \
		echo '[www]'; \
		echo '; if we send this to /proc/self/fd/1, it never appears'; \
		echo 'access.log = /proc/self/fd/2'; \
		echo; \
		echo 'clear_env = no'; \
		echo; \
		echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
		echo 'catch_workers_output = yes'; \
		echo 'decorate_workers_output = no'; \
	} | tee php-fpm.d/docker.conf \
	&& { \
		echo '[global]'; \
		echo 'daemonize = no'; \
		echo; \
		echo '[www]'; \
        echo 'user = httpd'; \
        echo 'group = httpd'; \
		echo 'listen = 9000'; \
        echo 'pm = dynamic'; \
	} | tee php-fpm.d/zz-docker.conf

WORKDIR /var/www/html

COPY docker-php-entrypoint /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-php-entrypoint

ENTRYPOINT ["docker-php-entrypoint"]

STOPSIGNAL SIGQUIT

EXPOSE 9000

CMD ["php-fpm"]
