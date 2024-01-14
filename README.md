# HeapLab environment in a container

This project is a Docker file to set-up the environment needed to do the [HeapLab online courses](https://www.udemy.com/course/linux-heap-exploitation-part-1) from Max Kemper from Udemy.

Note: Work in progress! I just started the online course and I can't be sure this is working properly. Use at your own risk.

## How to use it

- Clone the project: `git clone https://`
- Navigate to the new directory: `cd HeapLab`
- Build the image: `docker built . -t heaplab`
- Create a folder for your HeapLab resources: `mkdir resources`
- Run the container with a volume: `docker run -it -v ./resources/:/home/heaplab/resources heaplab:latest`

You should be able to put binaries and scripts in the `resources` folder and the files will be accessible to both your host and container.

## Build steps details

The steps are the following:
- Start from a Ubuntu 20.04 official image
- Update the list of packages
- Install the packages: Python3, Git, libssl-dev, libffi-dev, build-essential, Ruby
- Install one_gadget from the Gem
- Create a user called heaplab
- Install pwndbg from the github repository
- Add `~/.local/bin` to the path
- Install pwntools from pip
- The main command is to run a bash shell
