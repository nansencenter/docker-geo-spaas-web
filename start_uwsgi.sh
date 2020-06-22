#!/bin/bash
python manage.py collectstatic
uwsgi /opt/geospaas-app/uwsgi.ini
