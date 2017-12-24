FROM ubuntu
MAINTAINER <safiuremailid@gmail.com>
RUN apt-get install -y \
openssh-server sudo passwd \
mkdir /var/run/sshd \
ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa \
echo redhat | passwd --stdin root
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
mQGiBDxqtR8RBACbySxGrtf+flbowryS1Hj4z3zzEXD4CAEq6RjSGMtIraCDRJfp
6Gexs+lQ6IhpdC4GfX70SUMjXXvT5suhXYeGOM4iJHqUsksgzEKjUqcfj1l3qmOs
/doE8lcGGHcYbMplBcfuop+shZYiv9GEJ3gutwn/dNnhs/QA9bCdIj03lwCgvAcy
QpT5JdTym2p2icd5e91mGIUEAJMw6JHTTcCiyoTRy7k8Cf65d8S7bTDLr6pqJVE2
XU41CvW/pgL31akYAxpeZJJnsBaLaUiqh6K0qgfEMlDwDeC6gVogHBxWkEXdK1dr
tGL4GIUcxQ1+ZvQhGg7dtjanmfMlylVgS+C48awJySkinRmaQDbQ0MKdFchLc/y1
OR3IA/0VkIvlidehMPbZCalqhS9AEsDiFq5/u5AsQzDEp2nmTGlmBqjhc39kEnu4
qKq08az1Gt6Q7sxXbjH/jYtDgd49FW5Yg4k5B3hpTgnbyRE6SGlKksu8qTmYkDve
4rej6pvJRHwp6hDKxDG8qQoLWIgOfVC8960nurqx56QdV9YMsLQga2V2aW4gc2Vn
dWluIDxzZWd1aW5AYXBhY2hlLm9yZz6IVwQTEQIAFwUCPGq1HwULBwoDBAMVAwID
FgIBAheAAAoJEKy3f8Lobims3E0An0x3rrUMIijUMFoqnoT7muNGwmAzAJ990TWj
dZO4ayh1M+cWhjaw9W+44bkBDQQ8arUkEAQApaMm5HUB1Yk2x5MavAs/O4zfWnOx
YFOeXIPfGvhlhF2/Lrjs9icaa/tOM/CTCes19nDWP5Fc+pQxmgSPrgt3fsShwZJe
p3iYodLbM76uXEgSvI4Wh6kwViHbN4V1GxJAd2ZPVb1v+lauGUCOgPFGw99UV9sO
tTRXSbFS6AgqQzMAAwUD/jq6boxlnab/GUmKrILeLkv1X0G2/AEXEGRmG0nkhVdj
OShoqtPr4y/UhMzJUOequs2CdvRlTIyAyZqN7A0Qp4mFfmsvp0dYYssTtE4bCzZe
WxSKgjtBWBHXnH+Qzjb5R2Tz28kAxNY+dt7yxC+CkXWDZq/rsPgsXNbWXT49FnF8
iEYEGBECAAYFAjxqtSQACgkQrLd/wuhuKazl7QCfQkz5t/3T6EtXZCcXz/hlswyI
z30AoLr/7hwXgedEepBk/Gm9HUsbMnM8
=S1mb
ENV TOMCAT_URL  https://www.apache.org/dist/tomcat/tomcat-9/v9.0.2/bin/apache-tomcat-9.0.2.tar.gz
RUN set -x \
    && curl -fSL "$TOMCAT_URL" -o tomcat.tar.gz \
    && curl -fSL "$TOMCAT_URL.asc" -o tomcat.tar.gz.asc \
    && gpg --verify tomcat.tar.gz.asc \
    && tar -xvf tomcat.tar.gz --strip-components=1 \
    && rm bin/*.bat \
    && rm tomcat.tar.gz*
ADD $WORKSPACE/build/distributions/myjavacode-${ARTIFACT_VERISON}.war $CATALINA_HOME/webapps
EXPOSE 8080
CMD ["/usr/sbin/tomcat" -"D"]
