## Apache + PHP + Xdebug

A Debian image using Apache (prefork), PHP and Xdebug

- Debian 12
- Apache 2.4.61
- PHP 8.2.20
- Xdebug 3.2.0


## Running

```shell
git clone ...
docker compose up \
	--mount type=bind,source=/path/to/php-project,target=/var/www/html \
	--mount type=bind,source=/path/to/apache-site-config.conf,target=/etc/apache2/sites-enabled/something.conf
```

By default Apache is listening on 8000, Xdebug on 9003.

## Environment

Here's the environment you can play with

```
ENV APACHE_SERVER_NAME="example.localhost"
ENV APACHE_LISTEN_PORT="*:80"
ENV XDEBUG_CLIENT_PORT="9003"
```

## See Also

- https://matthewsetter.com/setup-step-debugging-php-xdebug3-docker/
- https://peterbabic.dev/blog/php-xdebug-in-docker/

## Configuring Xdebug for IDE


### Check Xdebug Connection

Just use `socat` to listen, should get some spew with XML.

```
socat tcp-listen:9003 stdout
```


### VSCode

Your .vscode/launch.json should include a part like this snippet.
The key `/var/www/html` is the path on the server and it's value is the localpath.

```json
{
	"configurations": [
		{
			"name": "Listen for Xdebug",
			"type": "php",
			"request": "launch",
			"port": 9003,
			"pathMappings": {
				"/var/www/html": "${workspaceRoot}/webroot"
			}
		}
	]
}
```
