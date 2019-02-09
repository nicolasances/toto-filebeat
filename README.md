# Container with Filebeat
This container ingests the logs of other containers running in the Toto environment.

This project configures Filebeat to work with Toto Microservices.
Adding new microservices to the environment shouldn't require a new build.

## Building it
This is made to be built as part of a Toto environment setup.

## How to run it
To run this in a Toto environment, `docker run` it as follows:
```
docker run -d --name filebeat --network totonet -u root -v /var/lib/docker/containers:/var/lib/docker/containers -v /var/run/docker.sock:/var/run/docker.sock  toto-filebeat
```

## Notes on Filebeat - How to set it up manually
### Configuration
Configuration of Filebeat using the `filebeat.yml` file. <br/>
The following is a sample yml file to read logs from **one of** the Docker containers.

```
filebeat.inputs:
- type: log
  paths:
    - /var/lib/docker/containers/2bc5da1eea56e44311e7ef76d25f3aaff05a138a5a6f12bd7f4da6de1e92c968/2bc5da1eea56e44311e7ef76d25f3aaff05a138a5a6f12bd7f4da6de1e92c968-json.log

output.console:
  pretty: true
```

To get instead the logs for **all** the Docker containers:

```
filebeat.inputs:
- type: log
  paths:
    - /var/lib/docker/containers/*/*.log

output.file:
  path: "/tmp/filebeat"
  filename: filebeat
  rotate_every_kb: 10000
  number_of_files: 3

```
***Note that it is better to send the logs to file when monitoring ALL the containers, since that also ingests also the filebeat logs!***

### Starting Filebeat in a Docker container
You can run Filebeat in a Docker container. Remember the following:
 * Mount the docker logs volume `/var/lib/docker/containers`
 * Mount the filebeat configuration file
```
docker run -d --name filebeat -u root -v /home/nicolas/beats/filebeat.yml:/usr/share/filebeat/filebeat.yml -v /var/lib/docker/containers:/var/lib/docker/containers  docker.elastic.co/beats/filebeat:6.6.0
```
Note that the `-u root` is important for filebeat to have access to the log files
