# Flask deployment on k8s with OpenResty and Consul

This is my first Kubernetes project where I deploy multiple Flask pods on Kubernetes.

Every Flask application instance (pod) is registered on a Consul server. I also have my [custom OpenResty](https://github.com/ahnaf-zamil/openresty-consul-proxy) deployment that uses a Lua script to query Consul for Flask services using DNS SRV, and then proxies the request. The OpenResty server is put on the Edge using a LoadBalancer service.

**P.S:** _At the moment_ I've hardcoded the Consul IP on both the deployment configs in [`kubernetes/`](./kubernetes/). Make sure to change it to your own Consul local IP when you want to use it (make sure it's your LAN IP or else the pods will try to access localhost and fail because it's a container).

## License

It's MIT folks, use it however you wish :D
