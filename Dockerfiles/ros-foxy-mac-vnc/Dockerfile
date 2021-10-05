FROM arm64v8/ros:foxy-ros-core

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
    net-tools \
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
    tree

# locale-gen = language settings
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

# VNC Display settings
ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes
COPY . /app

# clean up first
RUN apt-get autoremove --purge --yes \
    && rm -rf /var/lib/apt/lists/* 

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

# ROS2 installation
RUN sudo apt update && sudo apt install curl gnupg2 lsb-release
RUN sudo apt update
RUN sudo apt install -y ros-foxy-desktop ros-foxy-rmw-fastrtps* ros-foxy-rmw-cyclonedds*

RUN sudo apt update && sudo apt install -y \
  build-essential \
  cmake \
  git \
  libbullet-dev \
  python3-colcon-common-extensions \
  python3-flake8 \
  python3-pip \
  python3-pytest-cov \
  python3-rosdep \
  python3-setuptools \
  python3-vcstool \
  wget
RUN python3 -m pip install -U \
  argcomplete \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest
# install Fast-RTPS dependencies  
RUN sudo apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev
# install Cyclone DDS dependencies
RUN sudo apt install --no-install-recommends -y \
  libcunit1-dev


# init catkin workspace
RUN mkdir -p $HOME/colcon_ws/src
RUN /bin/bash -c "source /opt/ros/foxy/setup.bash; cd ~/colcon_ws/;colcon build --symlink-install"

RUN echo "source /opt/ros/foxy/setup.bash" >> $HOME/.bashrc
RUN echo "source ~/colcon_ws/install/local_setup.bash" >> $HOME/.bashrc
RUN echo "" >> $HOME/.bashrc
RUN echo "export ROS_DOMAIN_ID=10" >> $HOME/.bashrc
RUN echo "" >> $HOME/.bashrc
RUN echo "export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp" >> $HOME/.bashrc
RUN echo "# export RMW_IMPLEMENTATION=rmw_fastrtps_cpp" >> $HOME/.bashrc
RUN echo "# export RCUTILS_CONSOLE_OUTPUT_FORMAT='[{severity} {time}] [{name}]: {message} ({function_name}() at {file_name}:{line_number})'" >> $HOME/.bashrc
RUN echo "export RCUTILS_CONSOLE_OUTPUT_FORMAT='[{severity}] [{time}]: {message}'" >> $HOME/.bashrc
RUN echo "export RCUTILS_COLORIZED_OUTPUT=1" >> $HOME/.bashrc
RUN echo "export RCUTILS_LOGGING_USE_STDOUT=0" >> $HOME/.bashrc
RUN echo "export RCUTILS_LOGGING_BUFFERED_STREAM=0" >> $HOME/.bashrc
RUN echo "" >> $HOME/.bashrc
RUN echo "" >> $HOME/.bashrc
RUN echo "alias cs='cd ~/colcon_ws/src'" >> $HOME/.bashrc
RUN echo "alias cm='cd ~/colcon_ws/ && colcon build --symlink-install'" >> $HOME/.bashrc
RUN echo "alias eb='vi ~/.bashrc'" >> $HOME/.bashrc
RUN echo "alias sb='source ~/.bashrc'" >> $HOME/.bashrc
RUN echo "alias rt='ros2 topic list'" >> $HOME/.bashrc
RUN echo "alias re='ros2 topic echo'" >> $HOME/.bashrc
RUN echo "alias rn='ros2 node list'" >> $HOME/.bashrc
RUN echo "alias af='ament_flake8'" >> $HOME/.bashrc
RUN echo "alias ac='ament_cpplint'" >> $HOME/.bashrc
RUN echo "alias ros2_init='. /opt/ros/foxy/setup.bash'" >> $HOME/.bashrc
RUN echo "" >> $HOME/.bashrc
RUN echo "alias killgazebo='killall -9 gazebo & killall -9 gzserver  & killall -9 gzclient'" >> $HOME/.bashrc

CMD ["/app/entrypoint.sh"]
EXPOSE 8080
