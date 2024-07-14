# Canvas Server

Server component for the Canvas project

## Installation

### Linux

```bash
$ git clone https://github.com/idncsk/canvas-server /path/to/canvas-server
$ cd /path/to/canvas-server/src
$ npm install
$ npm start # or npm pm2:start
```

To automatically start canvas-server as a system (or user) service, please consult https://pm2.keymetrics.io/docs/usage/startup/

### Windows

```cmd
> git clone https://github.com/idncsk/canvas-server /path/to/canvas-server
> cd /path/to/canvas-server/src
> npm install
> npm start
```

### Docker

```bash
$ git clone https://github.com/idncsk/canvas-server /path/to/canvas-server
$ cd /path/to/canvas-server
$ docker-compose up --build
# or, to ensure you are running the latest and greatest
# $ docker-compose build --no-cache
# $ docker-compose up --force-recreate
# Cleanup
$ docker-compose down --rmi all

```

Supported ENV vars with their defaults

```bash
${CANVAS_SERVER_CONFIG:-./config}:/opt/canvas-server/config
${CANVAS_SERVER_HOME:-./user}:/opt/canvas-server/user
${CANVAS_SERVER_DATA:-./data}:/opt/canvas-server/data
${CANVAS_SERVER_VAR:-./var}:/opt/canvas-server/var
```

## Configuration

```bash
# To disable "portable" mode, create /path/to/canvas-server/user/.ignore
# This will store all Canvas server data to your home dir ~/.canvas

# Edit canvas-server configuration before starting the server
$ cd /path/to/canvas-server/config  # Or ~/.canvas/config
$ cp example-server.json server.json 
$ cp example-client.json client.json
# Or /path/to/canvas-server/config/example-*.json  ~/.canvas/config/*.json
```

## Update Canvas Server

```bash
$ cd /path/to/canvas-server/src
# Stop the canvas server
$ npm run stop # or npm run pm2:stop
$ rm -rf ./node_modules # Ensure we have a clean plate
# Fetch the latest version of canvas-server from Github
$ git pull origin main # or dev if you are feeling adventurous
$ npm install
$ npm start # or npm run pm2:start
```
