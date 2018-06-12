FROM ansible/awx_task:latest

LABEL maintainer Walter de Donato <dedonato@nm-2.com>

USER root

RUN yum -y install openssh-server && \
    sshd-keygen && \
    ssh-keygen -A && \
    echo -e "\n\
[program:sshd]\n\
command = /sbin/sshd\n\
directory = /\n\
autostart = true\n\
autorestart = true\n\
stopwaitsecs = 5\n\
stdout_logfile=/dev/stdout\n\
stdout_logfile_maxbytes=0\n\
stderr_logfile=/dev/stderr\n\
stderr_logfile_maxbytes=0\n" >> /supervisor_task.conf

USER 1000

CMD /tini -- /bin/sh -c /usr/bin/launch_awx_task.sh
