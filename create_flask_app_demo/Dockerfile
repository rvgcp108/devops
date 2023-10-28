#Set base Image to be used for this application
FROM python:3.9-buster
#Set working directory path
WORKDIR /app
#Copy installed packages in docker
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
#Copy everything into docker app from this directory
COPY . .
#Setup ENV for application
ENV FLASK_RUN_HOST=0.0.0.0
#Expose the Port no for app to be run
EXPOSE 5000
#Finaly to run the app pass this argument
CMD ["flask", "run"]