FROM nansencenter/geospaas:v0.4

# The pip version of uwsgi is not compatible with the conda Python version used in geospaas
RUN conda install uwsgi
# There is an incompatibility if those are installed using conda
RUN pip install django-prometheus djangorestframework markdown django-filter

ARG GEOSPAAS_API_VERSION=0.0.1
RUN pip install --no-cache-dir https://github.com/nansencenter/django-geo-spaas-rest-api/releases/download/${GEOSPAAS_API_VERSION}/geospaas_rest_api-${GEOSPAAS_API_VERSION}-py3-none-any.whl

WORKDIR /opt/geospaas-app

COPY geospaas_web/ geospaas_web
COPY uwsgi.ini manage.py start_uwsgi.sh ./
RUN mkdir -p static

EXPOSE 3032 9191

CMD ["./start_uwsgi.sh"]
