#1/bin/bash
# 1. Git, ctags, cscope, tmux, wget, tree etc etc

cd ~

sudo apt install git

git clone https://github.com/ritsz/dotfile.git ~/.dotfile

ln -s ~/.dotfile ~/.dotfiles

sudo apt install python-dev python3-dev

sudo apt install cscope ctags tmux wget curl

sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev

sudo apt install clang clang-format clang-tidy



# 2. New vim

git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
            --enable-cscope \
            --prefix=/usr/local

make VIMRUNTIMEDIR=/usr/local/share/vim/vim80
sudo apt install checkinstall
sudo checkinstall
sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

cd ~



# 3. Powerline

# 4. Fish

sudo apt-get install fish



# 5. Add symlinks to dotfiles and cvh

sudo cat ~/.dotfile/.bashrc >> ~/.bashrc
source ~/.bashrc

mkdir -p ~/.vim/colors
ln -s ~/.dotfile/.vimrc ~/.vimrc
ln -s ~/.dotfile/.tmux.conf ~/.tmux.conf
sudo ln -s ~/.dotfile/cvh /usr/bin/cvh 
sudo ln -s ~/.dotfile/dracula.vim ~/.vim/colors/dracula.vim

# 6. Add crontab entry
