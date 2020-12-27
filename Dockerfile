FROM 716577323141.dkr.ecr.us-east-1.amazonaws.com/python:latest

WORKDIR /app

RUN apk update && apk add libpq

RUN apk add --no-cache --virtual .build-deps \
    postgresql-dev gcc python3-dev musl-dev \ 
    && pip install --no-cache-dir psycopg2 \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

COPY python/ .

# command to run on container start
CMD [ "python", "./postgres.py" ]