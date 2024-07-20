FROM amazoncorretto:17.0.8-alpine3.18
ENV APP_HOME /usr/src/app 
WORKDIR $APP_HOME
COPY target/*.jar $APP_HOME/app.jar
EXPOSE 8080
CMD [ "java", "-jar", "app.jar" ]