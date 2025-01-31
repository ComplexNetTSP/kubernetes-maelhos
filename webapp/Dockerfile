FROM python:3.9

WORKDIR /app
COPY . /app

# Default MongoDB host
ENV MONGO_HOST=localhost

RUN pip install flask pymongo

EXPOSE 5000
CMD ["python", "app.py"]
