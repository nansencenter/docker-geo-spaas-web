#!/bin/bash
python manage.py collectstatic --no-input
uwsgi /opt/geospaas-app/uwsgi.ini
