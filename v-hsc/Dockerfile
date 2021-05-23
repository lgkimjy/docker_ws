# base image는 noetic 
FROM osrf/ros:noetic-desktop-focal

ENV LANG en_US.UTF-8

# 그래픽지원을 위한 mesa-dri 추가
RUN apt-get update && apt-get install -y \
    libusb-dev \
    libspnav-dev \
    libbluetooth-dev \
    libcwiid-dev \
    qt5-default \
    libncurses5-dev \
    ros-noetic-joint-state-controller \
    ros-noetic-gazebo-ros-control \
    ros-noetic-effort-controllers \
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
    tree \
    sudo

# locale-gen = language settings
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
RUN apt-get install python3-rosinstall -y
RUN apt-get install -q -y ros-noetic-rqt*

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

# # 프로젝트에서 생성된 파일은 HOST에 MOUNT된 플더를 이용한다.
# VOLUME /docker_share
# # ln == symbolic links
# RUN ln -s /docker_share $HOME

# init catkin workspace
# RUN source /opt/ros/noetic/setup.bash
RUN mkdir -p $HOME/catkin_ws/src && cd $HOME/catkin_ws/src
# RUN cd $HOME/catkin_ws && catkin_make

ADD alice3_vsc/ ~/

# node들을 실행할때 필요한 환경변수들은 미리 초기화 한다.
RUN echo "source /opt/ros/noetic/setup.bash" >> $HOME/.bashrc
RUN echo "source $HOME/catkin_ws/devel/setup.bash" >> $HOME/.bashrc
RUN echo "export ROS_HOSTNAME=localhost" >> $HOME/.bashrc
RUN echo "export ROS_MASTER_URI=http://localhost:11311" >> $HOME/.bashrc
RUN echo "alias cw='cd ~/catkin_ws'" >> $HOME/.bashrc
RUN echo "alias cs='cd ~/catkin_ws/src'" >> $HOME/.bashrc
RUN echo "alias cm='cd ~/catkin_ws && catkin_make'" >> $HOME/.bashrc
RUN echo "alias eb='vi ~/.bashrc'" >> $HOME/.bashrc
RUN echo "alias sb='source ~/.bashrc'" >> $HOME/.bashrc