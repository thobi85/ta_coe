# CoE to HTTP server Docker
Technische Alternative COE to HTTP Server Docker

Implementation of the following Git into a normal Docker and not in a specific Home Assistant Docker
https://gitlab.com/DeerMaximum/ta-coe/

The specific Home Assistant Docker can be found here:
https://github.com/DeerMaximum/ha-addons

# Configuration

## CoE

### Receiving messages
To configure CoE, follow these instructions (German) and enter the IP of your server.
The node number on the C.M.I. can be chosen arbitrarily and have no influence on the function of the addon.

### Sending messages
To send messages the server needs the IP address of the C.M.I. and a CAN node number under which it should be visible in the C.M.I..
These data are configured using the CLI parameters --coe-ip and --coe-node.

### Versions
There are two CoE versions, V1 and V2, which can be set via the CLI parameter --coe-version.
The default is V1. The version must also be set in the C.M.I.

### HTTP
The web server has no configuration options.

# Usage
The data can be received with a GET request. Since the received data are not cached between server
restarts and the data are transferred from the C.M.I. only piece by piece. It can happen after a restart of the server
that there is no data yet and the request is answered with a status code 204.
The full API documentation can be found at IP:9000/docs

## Docker Compose
In Docker Compose I use the command to start the script and to provide the relevant information

```
    command: >
      python3 main.py
      --coe-node 'number'
      --coe-ip 'IP'
      --coe-version v2
      --debug
```
