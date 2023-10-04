FROM python:3.10-slim-buster

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y libgdal-dev build-essential libpq-dev

RUN mkdir -p /home/geouser

RUN groupadd --gid 1001 geouser && \
    useradd --uid 1001 --gid geouser --home /home/geouser geouser

RUN pip install pipenv

ENV HOME=/home/geouser
ENV APP_HOME=/home/geouser/healthfacilities
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY ./Pipfile ./Pipfile.lock $APP_HOME
RUN pipenv install --deploy --dev --system

COPY . $APP_HOME

RUN chown -R geouser:geouser ${APP_HOME}

USER geouser