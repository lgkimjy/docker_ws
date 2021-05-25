FROM osrf/ros:melodic-desktop-full

MAINTAINER junyoungkim <lgkimjy@naver.com>

RUN mkdir -p tests/a

# 프로젝트에서 생성된 파일은 HOST에 MOUNT된 플더를 이용한다.
VOLUME /docker_share
# ln == symbolic links
RUN ln -s /docker_share $HOME