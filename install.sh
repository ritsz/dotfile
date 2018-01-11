#1/bin/bash
# 1. Git, ctags, cscope, tmux, wget, tree etc etc

cd ~

sudo apt install git

git clone https://github.com/ritsz/dotfile.git ~/.dotfile

sudo apt install python-dev python3-dev

sudo apt install cscope ctags tmux

sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev



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

cd ~



# 3. Powerline

sudo apt-get install python3-pip

su -c 'pip3 install git+git://github.com/Lokaltog/powerline'

# 4. Fish
# 5. Add symlinks to dotfiles and cvh
# 6. Add crontab entry
