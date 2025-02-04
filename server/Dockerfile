FROM python:3.13-alpine

WORKDIR /home/app/server
COPY requirements.txt .
RUN pip install -U pip wheel setuptools
RUN pip install -r requirements.txt

ADD . /home/app/server
WORKDIR /home/app/server

ENTRYPOINT ["python3", "app.py"]
