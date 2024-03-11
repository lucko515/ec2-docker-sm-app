FROM python:3.9

EXPOSE 80
EXPOSE 8080

# set the working directory
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
RUN apt-get install libgl1
RUN apt-get install nano

# Create DIR and CD to it
RUN mkdir app
WORKDIR /app

# copy the requirements file
COPY requirements.txt .

# install the dependencies
RUN pip install -r requirements.txt

# copy the app files
COPY . .

# CMD ["python", "app.py"]
CMD exec gunicorn --bind :$PORT --workers 3 --threads 8 --timeout 0 wrapper:app

