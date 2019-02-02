FROM docker.elastic.co/beats/filebeat:6.6.0

COPY filebeat.yml /usr/share/filebeat/filebeat.yml
