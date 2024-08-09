ARG BUILD_FROM
FROM $BUILD_FROM

# Copy data for add-on


COPY run.sh /
RUN chmod a+x /run.sh  

RUN apk add --no-cache python3
RUN apk add --no-cache py3-pip
RUN apk add opencv
RUN apk add git
RUN apk add py3-numpy
RUN apk add py3-opencv
RUN apk add py3-paho-mqtt
RUN apk add py3-aiohttp
RUN apk add py3-pillow
RUN apk add mosquitto-clients

WORKDIR /opt/app
RUN git clone https://github.com/NickWaterton/Roomba980-Python.git
RUN pip install --break-system-packages irbt

CMD [ "/run.sh" ]
