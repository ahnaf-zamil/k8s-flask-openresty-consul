local dns_res = require "resty.dns.resolver"

local query_domain = os.getenv("APP_NAME") .. ".service.dc1.consul"
local dns_conf = { os.getenv("DNS_URL"), 8600 }


local function abort(reason, status_code)
    ngx.status = status_code
    ngx.say(reason)
end

local dns, _ = dns_res:new { nameservers = { dns_conf }, timeout = 200 }

if not dns then
    return abort("DNS couldnt be resolved", 500)
end

local entries, _ = dns:query(query_domain, { qtype = dns.TYPE_SRV })

ngx.log(ngx.STDERR, dns_conf[1]);

if not entries then
    return abort("No records found", 502)
end

if entries[1].port then
    local t_ip = dns:query(entries[1].target)[1].address

    ngx.var.proxy_address = t_ip .. ":" .. entries[1].port
else
    return abort("No valid ports found", 500)
end
