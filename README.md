# demo-spring-tomcat

build package

	mvn clean package
	
build image

	docker build -t <repo>/demo-spring-tomcat:latest .
	
run image (forground)

	docker --rm -it -p 8080:8080 -v $HOME/tmp:/home/spring/data <image>
	
run image (background)

	docker --rm -d -p ...