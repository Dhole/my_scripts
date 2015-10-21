#! /bin/sh

# Commands taken from http://guttula.com/STM32F4/toolchain-setup.html

sudo apt-get install git screen

# Install gcc toolchain for arm M*
sudo apt-get install binutils-arm-none-eabi
sudo apt-get install gcc-arm-none-eabi

# Install dependencies for st-link
sudo apt-get install libusb-1.0-0-dev autoconf

# Download st-link tools from github
cd ~
mkdir -p ~/github
cd github
git clone https://github.com/texane/stlink.git
cd stlink
./autogen.sh
./configure
make

# Make links to binaries at ~/bin
mkdir -p ~/bin
echo 'export HOME_BIN=$HOME/bin' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME_BIN' >> ~/.bashrc
ln -s ~/github/stlink/st-flash ~/bin/st-flash
ln -s ~/github/stlink/st-util ~/bin/st-util
ln -s ~/github/stlink/st-info ~/bin/st-info
ln -s ~/github/stlink/st-term ~/bin/st-term

ln -s ~/github/stlink ~/stlink.git

# Add udev rules to enable programming with st-link with regular user
sudo cp ~/github/stlink/*.rules /etc/udev/rules.d/
sudo service udev restart

# Install arm gdb
# Workarround because gdb-arm-none-eabi overwrites a file from gcc-argm-none-eabi
sudo apt-get -o Dpkg::Options::="--force-overwrite" install gdb-arm-none-eabi

# Install openocd for debugging:
sudo apt-get install openocd

# Tutorials: http://eliaselectronics.com/?s=stm32f4
# More Tuts: http://www.wolinlabs.com/blog/linux.stm32.discovery.gcc.html
# Low level: http://regalis.com.pl/en/arm-cortex-stm32-gnulinux/

# Download working directory template with examples
cd ~/github
git clone https://github.com/devthrash/STM32F4-workarea.git
git clone https://github.com/rowol/stm32_discovery_arm_gcc.git
# git clone https://github.com/istarc/stm32

exit

# To compile and run codes:
cd ~/github/stm32_discovery_arm_gcc/blinky
make
make burn

cat "set auto-load safe-path /" >> ~/.gdbinit

# Load and run binary with gdb
cd ~/github/stm32_discovery_arm_gcc/blinky
arm-none-eabi-gdb blinky.elf
# (gdb) continue
# (gdb) ^C # get to a gdb prompt
# (gdb) reload
# (gdb) run

# Alt.
cgdb -d arm-none-eabi-gdb blinky.elf

