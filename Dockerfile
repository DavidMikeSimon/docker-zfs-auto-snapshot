FROM ubuntu:23.04

RUN apt update && apt install -y zfsutils-linux cron && rm -rf /var/lib/apt/lists/*

# Remove existing builtin ubuntu cron stuff
RUN rm -rf    /etc/cron.d /etc/cron.hourly /etc/cron.daily /etc/cron.weekly /etc/cron.monthly
RUN mkdir -p  /etc/cron.d /etc/cron.hourly /etc/cron.daily /etc/cron.weekly /etc/cron.monthly

RUN ln -s /dev/stdout /var/log/syslog

COPY zfs-auto-snapshot.sh /sbin/zfs-auto-snapshot
COPY zfs-auto-snapshot.cron /etc/cron.d/zfs-auto-snapshot

WORKDIR /

CMD /usr/sbin/cron -f -L 3
