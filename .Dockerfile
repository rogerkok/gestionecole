FROM python:alpine3.10
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt /app/
RUN python -m pip install --upgrade pip
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev
RUN pip install  --trusted-host pypi.python.org --no-cache-dir  -r requirements.txt
COPY . /app/


#COPY requirements.txt /app/requirements.txt
#ENTRYPOINT ["python", "./launch.py"]