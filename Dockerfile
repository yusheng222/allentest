FROM java:8

ADD app.jar app.jar

CMD ["java","-jar","app.jar"]
