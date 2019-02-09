FROM docker.elastic.co/beats/filebeat:6.6.0

USER root
RUN chmod /usr/share/filebeat/
RUN rm /usr/share/filebeat/filebeat.yml
COPY filebeat.yml /usr/share/filebeat/filebeat.yml
