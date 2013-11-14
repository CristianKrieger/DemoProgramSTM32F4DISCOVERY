DemoProgramSTM32F4DISCOVERY
===========================
Since ST Microelectronics example code for the STM32F4DISCOVERY board is targeted to IDE's like Keil or TrueStudio (which cost money), you are unable to compile it, run it, or debug it; so I decided to adapt the code for it's Demonstration example in order to be compatible with arm-none-eabi. With this, no IDE is required for compiling, running or debugging (Open-Source FTW).
The project has a makefile ready for compilation and can be run immediately.
#Instructions#
### Install the STM32 ARM development toolchain
First, download the gcc-arm-none-eabi-linux package from [Launchpad](https://launchpad.net/gcc-arm-embedded).
Now change to the download directory, unpack the file and move it to the proper location and add it to the environment variable (If you receive an error like: No such file or directory. Its due to a 32 bit file unable to run on a 64 bit OS, try getting a library for compatibility):

> cd Downloads
tar xjvf gcc-arm-none-eabi-4_7-2013q1-20130313-linux.tar.bz2
sudo mv gcc-arm-none-eabi-4_7-2013q1-20130313-linux /opt/ARM
echo "PATH=$PATH:/opt/ARM/bin" >> ~/.bashrc
source ~/.bashrc
arm-none-eabi-gcc --version

Install all the needed dependencies for STLink:

> sudo apt-get install git zlib1g-dev libtool flex 
bison libgmp3-dev libmpfr-dev libncurses5-dev libmpc-dev 
autoconf texinfo build-essential libftdi-dev libusb-1.0.0-dev

The STM32F4 Discovery has the STLinkV2 programmer on board. The stlink tool for linux is available only as source code and needs to be compiled first (do it on your home directory):

> git clone https://github.com/texane/stlink.git
cd stlink
./autogen.sh
./configure
make

The stlink tool needs to be installed and made availabe via the PATH variable.

> sudo mkdir /opt/stlink
cd /opt/stlink
sudo cp ~/stlink/st-flash .
sudo cp ~/stlink/st-util .
echo "PATH=$PATH:/opt/stlink" >> ~/.bashrc
source ~/.bashrc

Now, the tool needs to be granted access of the devices via USB.

> sudo cp ~/src/stlink/49-stlinkv2.rules /etc/udev/rules.d
sudo udevadm control --reload-rules

### Compile the project
The project is already compiled, however, if you want to do it again, just navigate to the main folder and type 'make' on your terminal. All dependencies and parameters have been configured on the makefile.

### Connect to your board
In order to load and run the program, you need to do the following:
1. Connect your board via USB
2. Open a terminal and run st-util, the utility should identify your board and start listening at 4242 (Do not kill the process or close the terminal).
3. Open another terminal and navigate to the project's main directory.
4. Start the debugger by using 'arm-none-eabi-gdb main.elf'.
5. Once inside the debugger, use 'tar ext:4242' to connect the debugger to the board.
6. Load the program to the device by using 'load'.
7. Once it finishes, you can use any of the usual gdb commands like 'run' to start the program (you might need to press reset on the board in some cases).

##Credits
This tutorial was based on Elia's Electronics Blog entry: http://eliaselectronics.com/stm32f4-tutorials/setting-up-the-stm32f4-arm-development-toolchain/