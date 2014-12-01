apt-get update
apt-get install -y vim-nox build-essential npm git curl nodejs-legacy

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

gem install sass bourbon neat bitters

# do work in app directory
# pushd /vagrant
# su vagrant
# npm install
# exit
# popd
