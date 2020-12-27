FROM python:3.8-alpine

WORKDIR /app

RUN pip install psycopg2

COPY python/ .

# command to run on container start
CMD [ "python", "./postgres.py" ]