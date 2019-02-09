FROM docker.elastic.co/beats/filebeat:6.6.0

RUN sudo rm /usr/share/filebeat/filebeat.yml
COPY filebeat.yml /usr/share/filebeat/filebeat.yml
