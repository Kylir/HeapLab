FROM ubuntu:20.04

# Update the system and install the packages
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get install -y sudo python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential ruby

# Install one_gadget
RUN gem install --no-document one_gadget

# Create a new user that can sudo
RUN useradd -m heaplab
RUN echo "heaplab ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/heaplab
USER heaplab
WORKDIR /home/heaplab

# Install pwndbg
RUN git clone https://github.com/pwndbg/pwndbg; \
    cd pwndbg; \
    ./setup.sh

# Add local bin to the PATH
ENV PATH="/home/heaplab/.local/bin:${PATH}"
# Make sure pwndbg is not complaining
ENV LC_CTYPE="C.UTF-8"

# Install pwntools
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade pwntools

# open a shell
CMD ["bash"]
