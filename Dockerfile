ARG BASE_IMAGE=nansencenter/geospaas:latest
FROM ${BASE_IMAGE} as base

ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${VIRTUAL_ENV}/lib"

RUN conda install -y uwsgi \
&&  conda clean -a -y -f \
&&  rm /opt/conda/pkgs/* -rf \
&& find /opt/conda/ -follow -type f -name '*.a' -delete \
&& find /opt/conda/ -follow -type f -name '*.pyc' -delete

WORKDIR /opt/geospaas-app

COPY geospaas_web/ geospaas_web
COPY uwsgi.ini manage.py start_uwsgi.sh ./
RUN mkdir -p static

#TODO: add HEALTHCHECK

EXPOSE 3032 9191

CMD ["./start_uwsgi.sh"]
