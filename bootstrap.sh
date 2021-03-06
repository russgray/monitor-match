apt-get update
apt-get install -y vim-nox build-essential npm git curl nodejs-legacy fabric

# grab rc files for niceness
if [ -d /home/vagrant/.vim/bundle ]; then
    rm -rf /home/vagrant/.vim/bundle
fi
git clone https://github.com/gmarik/Vundle.vim.git /home/vagrant/.vim/bundle/Vundle.vim
curl -s https://dl.dropboxusercontent.com/u/490360/vim/.vimrc -o /home/vagrant/.vimrc

npm install -g browserify
npm install -g gulp
npm install -g npm-check-updates
npm install -g npm-clean
npm install -g jasmine-node
npm install -g bower

# do work in app directory
pushd /vagrant
su vagrant
npm install --no-bin-links
exit
popd
