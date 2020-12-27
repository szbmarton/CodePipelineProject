FROM python:3.8-alpine

WORKDIR /app

RUN apk update && apk add --no-cache postgresql-dev

RUN pip install psycopg2

COPY python/ .

# command to run on container start
CMD [ "python", "./postgres.py" ]