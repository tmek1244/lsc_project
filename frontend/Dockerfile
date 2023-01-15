FROM python:alpine

ENV APP_HOME /app
COPY . $APP_HOME
WORKDIR $APP_HOME

RUN pip install Flask requests

# ENTRYPOINT ["python"]
CMD ["python3", "app.py"]
