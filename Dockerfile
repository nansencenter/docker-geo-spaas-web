FROM nansencenter/geospaas:2.0.0-slim

RUN apt update && \
    apt install -y gcc && \
    # Disable LTO optimization because the LTO versions from the standard
    # debian buster GCC and the version of GCC used by Anaconda are different
    LDFLAGS='-fno-lto' pip install uwsgi && \
    apt remove -y gcc && \
    apt clean && apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/geospaas-app

COPY geospaas_web/ geospaas_web
COPY uwsgi.ini manage.py start_uwsgi.sh ./
RUN mkdir -p static

#TODO: add HEALTHCHECK

EXPOSE 3032 9191

CMD ["./start_uwsgi.sh"]
