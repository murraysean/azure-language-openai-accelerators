FROM mcr.microsoft.com/azurelinux/base/python:3

WORKDIR /app

COPY src/ /app
COPY requirements.txt /app

RUN pip install -r requirements.txt

EXPOSE 7000

CMD flask --app server run --host=0.0.0.0 --port 7000
