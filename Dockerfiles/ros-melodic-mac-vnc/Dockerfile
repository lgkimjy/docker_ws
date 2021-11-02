# This is an auto generated Dockerfile for ros:desktop-full
# generated from docker_images/create_ros_image.Dockerfile.em
FROM arm64v8/ros:melodic

ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install -y \
    libusb-dev \
    libspnav-dev \
    libbluetooth-dev \
    libcwiid-dev \
    qt5-default \
    libncurses5-dev \
    x11-apps \
    net-tools \ 
    iputils-ping \
    fluxbox \
    novnc \
    supervisor \
    x11vnc \
    xterm \
    xvfb \
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
    python3-pip \
    python3-tk \
    python-matplotlib \
    sudo

# locale-gen = language settings
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1340 \
    DISPLAY_HEIGHT=800 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes
COPY . /app

# clean up first
RUN apt-get autoremove --purge --yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ros/rosdep/sources.list.d/20-default.list

# packages 설치
#RUN rosdep init && rosdep update
RUN rosdep init
RUN apt-get install python-rosinstall -y
# RUN apt-get install -q -y ros-melodic-rqt*

# rosdep는 ROOT권한으로 실행하는걸 권장하지 않는다
ARG UNAME="junyoung"
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

# init catkin workspace
RUN mkdir -p $HOME/catkin_ws/src
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash; cd catkin_ws/src; catkin_init_workspace; catkin_make -C ${HOME}/catkin_ws"

# node들을 실행할때 필요한 환경변수들은 미리 초기화 한다.
RUN echo "source /opt/ros/melodic/setup.bash" >> $HOME/.bashrc
RUN echo "source $HOME/catkin_ws/devel/setup.bash" >> $HOME/.bashrc
RUN echo "export ROS_HOSTNAME=localhost" >> $HOME/.bashrc
RUN echo "export ROS_MASTER_URI=http://localhost:11311" >> $HOME/.bashrc
RUN echo "# export ROS_HOSTNAME=$(hostname -I | awk '{print $1}')" >> $HOME/.bashrc
RUN echo "# export ROS_MASTER_URI=http://$(hostname -I | awk '{print $1}'):11311" >> $HOME/.bashrc
RUN echo "alias cw='cd ~/catkin_ws'" >> $HOME/.bashrc
RUN echo "alias cs='cd ~/catkin_ws/src'" >> $HOME/.bashrc
RUN echo "alias cm='catkin_make -C ~/catkin_ws/'" >> $HOME/.bashrc
RUN echo "alias eb='vi ~/.bashrc'" >> $HOME/.bashrc
RUN echo "alias sb='source ~/.bashrc'" >> $HOME/.bashrc

CMD ["/app/entrypoint.sh"]
EXPOSE 2020