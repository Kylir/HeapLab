FROM ubuntu:20.04

# Update the system and install the packages
RUN echo "Let's try again..."
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get install -y sudo tmux python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential ruby

# Install one_gadget
RUN gem install --no-document one_gadget

# Create a new user that can sudo
RUN useradd -s /bin/bash -m heaplab
RUN echo "heaplab ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/heaplab
USER heaplab
WORKDIR /home/heaplab

# Install pwndbg version 2024.02.14
RUN git clone --depth 1 --branch 2024.02.14 https://github.com/pwndbg/pwndbg; \
    cd pwndbg; \
    ./setup.sh

# Add local bin to the PATH
ENV PATH="/home/heaplab/.local/bin:${PATH}"
# Make sure pwndbg is not complaining
ENV LC_CTYPE="C.UTF-8"

# Install pwntools
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade pwntools

# Copy tmux config (optional)
COPY ./tmux.conf ./.tmux.conf

# open a shell
CMD ["bash"]
