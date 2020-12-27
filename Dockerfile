FROM 716577323141.dkr.ecr.us-east-1.amazonaws.com/python:latest

WORKDIR /app

RUN apk update && apk add --no-cache postgresql-dev

RUN pip install psycopg2

COPY python/ .

# command to run on container start
CMD [ "python", "./postgres.py" ]