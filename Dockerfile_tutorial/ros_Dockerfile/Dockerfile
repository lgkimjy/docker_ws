# base image는 kinetic 
FROM osrf/ros:kinetic-desktop-full

ENV LANG en_US.UTF-8

# 그래픽지원을 위한 mesa-dri 추가
RUN apt-get update && apt-get install -y \
    tmux \
    curl \
    wget \
    vim \
    sudo \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    mesa-utils \
    unzip \
    locales \
    ntp \
    whois \
    sudo

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

# clean up first
RUN apt-get autoremove --purge --yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ros/rosdep/sources.list.d/20-default.list

# packages 설치
#RUN rosdep init && rosdep update
RUN rosdep init
RUN apt-get install python-rosinstall -y
RUN apt-get install -q -y ros-kinetic-rqt*

# rosdep는 ROOT권한으로 실행하는걸 권장하지 않는다
# HOST_USER from build arguemnt
ARG HOST_USER
ARG UNAME=${HOST_USER}
ARG UID=1000
ARG GID=1000
ARG HOME=/home/${UNAME}
RUN useradd -rm -d ${HOME} -s /bin/bash -g root -G sudo,audio,video,plugdev -u ${UID} ${UNAME}
RUN mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} 


USER ${UNAME}
WORKDIR $HOME

# 생성된 USER 계정으로 실행
RUN sudo rosdep fix-permissions 
RUN rosdep update 

# 프로젝트에서 생성된 파일은 HOST에 MOUNT된 플더를 이용한다.
VOLUME /docker_share
RUN ln -s /docker_share $HOME

# init catkin workspace
#RUN source /opt/ros/kinetic/setup.bash
#RUN mkdir -p $HOME/docker_share/catkin_ws/src && cd $HOME/docker_share/catkin_ws/src && catkin_init_workspace
#RUN cd $HOME/docker_share/catkin_ws && catkin_make
# CATKIN으로 생성한 워크스페이스에서 초기 MAKE과정을 하기 위한 스크립트 추가
# 이 파일은 한번만 실행하면된다.
ADD initial-workspace.sh $HOME/

# node들을 실행할때 필요한 환경변수들은 미리 초기화 한다.
RUN echo "source /opt/ros/kinetic/setup.bash" >> $HOME/.bashrc
RUN echo "source \$HOME/docker_share/catkin_ws/devel/setup.bash" >> $HOME/.bashrc
RUN echo "export ROS_HOSTNAME=localhost" >> $HOME/.bashrc
RUN echo "export ROS_MASTER_URI=http://localhost:11311" >> $HOME/.bashrc
RUN echo "alias cw='cd ~/docker_share/catkin_ws'" >> $HOME/.bashrc
RUN echo "alias cs='cd ~/docker_share/catkin_ws/src'" >> $HOME/.bashrc
RUN echo "alias cm='cd ~/docker_share/catkin_ws && catkin_make'" >> $HOME/.bashrc

ADD ros_entrypoint2.sh /
