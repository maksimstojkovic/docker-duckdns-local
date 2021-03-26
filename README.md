# Duck DNS Local IP Updater

[![docker build](https://github.com/maksimstojkovic/docker-duckdns-local/actions/workflows/docker-build.yml/badge.svg)](https://github.com/maksimstojkovic/docker-duckdns-local/actions/workflows/docker-build.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/maksimstojkovic/duckdns-local)](https://hub.docker.com/repository/docker/maksimstojkovic/duckdns-local)
[![Docker Stars](https://img.shields.io/docker/stars/maksimstojkovic/duckdns-local)](https://hub.docker.com/repository/docker/maksimstojkovic/duckdns-local)

Updates DuckDNS to the host's local network IP address at the frequency specified.

## Variables

* `TOKEN`: DuckDNS account token (obtained from [Duck DNS](https://www.duckdns.org)).
* `SUBDOMAIN`: DuckDNS subdomain (e.g. `test` from `test.duckdns.org`).
* `DELAY`: Delay between IP address updates (e.g. `5`, 5 minutes or more recommended).
* `INTERFACE`: Network interface to poll for IP address (e.g. `wlan0`, `eth0`)).

## Recommended `docker run` Command

```
docker run -d --name duckdns -e TOKEN=<token> -e SUBDOMAIN=<subdomain> -e DELAY=<delay> -e INTERFACE=<interface> --network host --restart unless-stopped maksimstojkovic/duckdns-local
```

For example:

```
docker run -d --name duckdns -e TOKEN=XXXXX -e SUBDOMAIN=XXXXX -e DELAY=5 -e INTERFACE=wlan0 --network host --restart unless-stopped maksimstojkovic/duckdns-local
```
