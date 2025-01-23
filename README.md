# Starlink IPv6 Scan - (SLIPv6)

Scanning for starlink IPv6 ip addrs

# Build enviorment

-podman users: `sudo setenforce 0`

```
podman build -t xmap-juypter . 
```

```
podman run -v $(pwd):/notebooks -p 8888:8888 xmap-jupyter:latest 
```

TODO:
xmap -v -6 -iL addresses.txt -oN starlink_scan_results.txt

Sources:
https://geoip.starlinkisp.net/

https://arxiv.org/pdf/2412.18243

