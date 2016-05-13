FROM fedora
WORKDIR /root
EXPOSE 22
CMD /sshd.sh
ADD sshd.sh /sshd.sh
RUN : \
 && dnf update -y \
 && dnf install -y \
      openssh-server \
      openssh-clients \
      ca-certificates \
      git \
      zlib-devel ruby ruby-devel gem firefox libXtst-devel xorg-x11-server-Xvfb \
 && dnf groupinstall -y "C Development Tools and Libraries" \
 && dnf groupinstall -y "Development Tools" \
 && dnf groupinstall -y "RPM Development Tools" \
 && gem install bundler --no-ri --no-rdoc \
 && /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N '' \
 && /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_dsa_key -C '' -N '' \
 && :
EXPOSE 22
