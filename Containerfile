FROM registry.fedoraproject.org/fedora-minimal:latest

RUN microdnf install iproute \
procps-ng \
net-tools \
ethtool \
bpftrace \
bcc-tools \
man \
sysstat \
tcpdump \
strace \
bind-utils \
blktrace \
conntrack \
perf \
&& rm -Rf /var/cache/yum
