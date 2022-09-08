FROM registry.fedoraproject.org/fedora-minimal:latest

RUN microdnf install -y iproute \
vim-minimal \
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
tar \
nload \
dstat \
&& rm -Rf /var/cache/yum
