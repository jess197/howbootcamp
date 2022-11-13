# Dockerfile, Image, Container
FROM python:3.9 

WORKDIR /usr/app/src

COPY ../requirements.txt ./

RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY how_bootcamp_fake_events.py ./

CMD ["python", "./how_bootcamp_fake_events.py"]
