FROM ubuntu:23.04

RUN apt update && apt install -y zfsutils-linux wget unzip cron && rm -rf /var/lib/apt/lists/*

# Remove zfsutils-linux cron as it likely exists in the host
RUN rm -f /etc/cron.d/zfsutils-linux

RUN wget -O zfs-auto-snapshot.zip https://github.com/zfsonlinux/zfs-auto-snapshot/archive/92db087bb019957166ee70c88c6c967e5fd28a70.zip
RUN unzip zfs-auto-snapshot.zip -d /tmp
WORKDIR /tmp/zfs-auto-snapshot-master-92db087bb019957166ee70c88c6c967e5fd28a70

RUN make install PREFIX=/usr

WORKDIR /
RUN rm -rf /tmp/zfs-auto-snapshot-master-92db087bb019957166ee70c88c6c967e5fd28a70

# Keep only the daily and hourly schedules
RUN rm -f /etc/cron.d/zfs-auto-snapshot /etc/cron.monthly/zfs-auto-snapshot /etc/cron.weekly/zfs-auto-snapshot

CMD /usr/sbin/cron -f -l
