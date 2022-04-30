import uuid
from flask import Flask
import consul
import os
import signal

PORT = 5000

service_id = uuid.uuid4().hex
app = Flask(__name__)
consul = consul.Consul(host=os.environ["CONSUL_IP"], port="8500")
consul.agent.service.register(
    "flask-app",
    service_id=service_id,
    port=PORT,
    address=os.environ["POD_IP"],
    tags=["master"],
)

signal.signal(signal.SIGTERM, lambda x, _: consul.agent.service.deregister(service_id))


@app.route("/")
def get_pid():
    return f"Service ID: {service_id}"


if __name__ == "__main__":
    app.run(port=PORT, host="0.0.0.0")
    consul.agent.service.deregister(service_id)
