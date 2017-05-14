FROM ubuntu:15.10

###
# working in container
# arecord -vvv -f dat /dev/null -D plughw:CARD=CODEC,DEV=0
##

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
apt-get -y dist-upgrade

RUN apt-get -y install \
curl \
alsa-utils \
git-core \
python-pyside \
python-pocketsphinx \
python-gobject-2 \
python-gst0.10 \
python-gobject-2-dev \
gstreamer0.10-pocketsphinx \
gstreamer0.10-alsa \
gstreamer0.10-plugins-base \
gstreamer0.10-plugins-good \
gstreamer0.10-plugins-bad \
gstreamer0.10-plugins-ugly

WORKDIR /

RUN git config --global http.sslVerify false
RUN git clone https://gitlab.com/jezra/blather.git

WORKDIR /blather

RUN echo ""  >> /root/.bashrc
RUN echo "function test-microphone() {"  >> /root/.bashrc
RUN echo "arecord -vvv -f dat /dev/null -D plughw:CARD=CODEC,DEV=0" >> /root/.bashrc
RUN echo "}" >> /root/.bashrc

RUN apt-get -y install npm && \\
npm install mqtt-cli -g

RUN ln /usr/bin/nodejs /usr/bin/node

COPY config/commands.conf /root/.config/blather/commands.conf
COPY config/sentences.corpus /root/.config/blather/sentences.corpus
COPY config/lm /root/.config/blather/language/lm
COPY config/dic /root/.config/blather/language/dic

COPY scripts/runBlather.sh /usr/bin/runBlather.sh
COPY scripts/hue_change_color.sh /usr/local/bin/hue_change_color.sh
COPY scripts/alarmclock_mqtt_event.sh /usr/local/bin/alarmclock_mqtt_event.sh
COPY scripts/roomba_mqtt_event.sh /usr/local/bin/roomba_mqtt_event.sh

CMD [ '/usr/bin/runBlather.sh' ]

RUN apt-get -y clean && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /tmp/*