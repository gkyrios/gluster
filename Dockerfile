FROM redhat/ubi9:latest

LABEL architecture="x86_64" \
      name="gluster/glusterfs-client" \
      version="10.5" \
      vendor="Red Hat, Inc" \
      summary="This image has a running glusterfs service ( UBI + Gluster 10.5 client)" \
      io.k8s.display-name="Gluster 10.5 client" \
      io.k8s.description="Gluster Client Image is based on UBI Image which is used to mount a glusterfs volume." \
      description="Gluster Client Image is based on UBI Image which is used to mount a glusterfs volume." \
      io.openshift.tags="gluster,glusterfs,glusterfs-client"

ENV container docker

ADD gluster-10.repo /etc/yum.repos.d/gluster-10.repo
RUN sed -i "s/LANG/\#LANG/g" /etc/locale.conf
RUN dnf --setopt=tsflags=nodocs -y update &&\
dnf --setopt=tsflags=nodocs -y install wget nfs-utils attr iputils iproute &&\
dnf install -y glusterfs-fuse &&\
dnf clean all

# Directory for coredumps. Note,kernel.core_pattern must be configured as such
RUN mkdir -p /var/log/core

ENTRYPOINT ["tail", "-f", "/dev/null"]

#CMD ["/bin/bash"]
