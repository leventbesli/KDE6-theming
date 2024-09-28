#!/bin/bash
set -e

# Variable for yellow color
YELLOW='\033[1;33m'
NC='\033[0m' # Reset color

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  printf "${YELLOW}Please run as root.${NC}\n"
  exit
fi

# 1. Install the Lightly theme system
printf "${YELLOW}Installing Lightly theme system...${NC}\n"
dnf install -y git cmake extra-cmake-modules "cmake(KDecoration2)" kwin-devel \
    kf6-kcolorscheme-devel kf6-kguiaddons-devel kf6-ki18n-devel kf6-kiconthemes-devel \
    kf6-kirigami-devel kf6-kcmutils-devel kf6-frameworkintegration-devel
# Check if the Lightly directory exists
if [ -d "Lightly" ]; then
  printf "${YELLOW}The Lightly directory already exists. Continue with installation? If yes, the Lightly directory will be deleted. (yes/no): ${NC}"
  read answer
  if [ "$answer" != "yes" ]; then
    printf "${YELLOW}Installation canceled. You can continue by deleting the Lightly directory.${NC}\n"
    exit 0
  fi
  # If the answer is yes, the old directory will be deleted
  rm -rf Lightly
fi

# Clone the Lightly repository and perform necessary steps
printf "${YELLOW}Cloning Lightly repository...${NC}\n"
git clone --single-branch --depth=1 https://github.com/Bali10050/Lightly.git
cd Lightly
mkdir build && cd build

printf "${YELLOW}Compiling Lightly...${NC}\n"
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib64 -DBUILD_TESTING=OFF ..
cd ./kdecoration/config/
make -j 12
cd ../../
make -j 12

printf "${YELLOW}Installing Lightly...${NC}\n"
sudo make install

cd ../..

# 2. Install Klassy and Kvantum theme systems
printf "${YELLOW}Installing Klassy and Kvantum theme systems...${NC}\n"
dnf config-manager --add-repo https://download.opensuse.org/repositories/home:paul4us/Fedora_40/home:paul4us.repo
dnf install -y klassy kvantum

# 3. Install Konsave backup tool
printf "${YELLOW}Installing Konsave...${NC}\n"
USER_HOME=$(eval echo ~${SUDO_USER})
dnf install -y python3-pip && sudo -u $SUDO_USER python3 -m pip install --user konsave

# 4. Import the otto-lightly-klassy_konsave.knsv file with Konsave
printf "${YELLOW}Importing Konsave file...${NC}\n"
sudo -u $SUDO_USER $USER_HOME/.local/bin/konsave -i "$(pwd)/otto-lightly-klassy_konsave.knsv"
sudo -u $SUDO_USER $USER_HOME/.local/bin/konsave -a otto-lightly-klassy_konsave

printf "${YELLOW}All processes completed successfully!${NC}\n"
