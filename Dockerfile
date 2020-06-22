FROM nansencenter/geospaas:v1.0.0

# The pip version of uwsgi is not compatible with the conda Python version used in geospaas
RUN conda install uwsgi

WORKDIR /opt/geospaas-app

COPY geospaas_web/ geospaas_web
COPY uwsgi.ini manage.py start_uwsgi.sh ./
RUN mkdir -p static

#TODO: add HEALTHCHECK

EXPOSE 3032 9191

CMD ["./start_uwsgi.sh"]
