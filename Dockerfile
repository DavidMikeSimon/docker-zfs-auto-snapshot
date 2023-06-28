FROM ubuntu:23.04

RUN apt update && apt install -y zfsutils-linux cron && rm -rf /var/lib/apt/lists/*

# Remove zfsutils-linux cron as it likely exists in the host
RUN rm -f /etc/cron.d/zfsutils-linux

RUN ln -s /dev/stdout /var/log/syslog

COPY zfs-auto-snapshot.sh /sbin/zfs-auto-snapshot
COPY zfs-auto-snapshot.cron /etc/cron.d/zfs-auto-snapshot

WORKDIR /

CMD /usr/sbin/cron -f -L 3
