FROM python:3.11-alpine

WORKDIR /app

RUN apk add --no-cache postgresql-client

COPY requirements.txt .
COPY app/ .  
COPY run.sh .

RUN pip install -r requirements.txt

ENV PYTHONUNBUFFERED=1

CMD ["sh", "run.sh"]