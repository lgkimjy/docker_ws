## Dokcerfile

#### Dockerfile format
명령어(INSTRUNCTION) 인자(arguments)

#### FROM 명령어
FROM <이미지>
FROM <이미지>:<태그>

example)
FROM ubuntu:latest -> 우분투 최신버전을 base 이미지로 사용
FROM node:12
FROM osrf/ros:melodic-desktop-full



### References
* https://www.daleseo.com/dockerfile/
* https://khj93.tistory.com/entry/Docker-Docker-File-%EC%9E%91%EC%84%B1%ED%95%98%EA%B8%B0-%EB%AA%85%EB%A0%B9%EC%96%B4
* http://pyrasis.com/book/DockerForTheReallyImpatient/Chapter20/05
* https://hub.docker.com/_/ros
* https://medium.com/@rookiecj/%EA%B0%91%EC%9E%90%EA%B8%B0-ros-%EA%B7%B8%EB%A6%AC%EA%B3%A0-docker%EA%B0%9C%EB%B0%9C%ED%99%98%EA%B2%BD-5b941c9ff098
* https://roomedia.tistory.com/entry/1일차-macOS-Catalina-10155에-ros2-foxy-설치하기
