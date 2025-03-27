#!/bin/sh
# Install nomachine

#wget 'https://download.nomachine.com/download/8.14/Linux/nomachine_8.14.2_1_amd64.deb'
#dpkg -i nomachine_8.14.2_1_amd64.deb
##	lsof -i tcp:4000
#rm nomachine_8.14.2_1_amd64.deb


apt update -y
# should be running this from ~/gits/Confs/

cd ~/gits/Confs/
git pull
cd ~/gits/ask/
git pull
cd ~/gits/Mousetrap/
git pull
cd ~/gits/pizzachit/
git pull

cd ~/gits/Confs/
chmod +x ./prepare.sh


cp tmux.conf /etc
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/
cd ~/gits/Mousetrap
bash *sh
cd ~/gits/ask
mkdir -p ~/gits/Confs/all/
bash *sh
ask --render-all
cd ~/gits/pizzachit/
bash *sh

git clone https://github.com/SirVer/ultisnips ~/.config/nvim/ultisnips/

sudo vmhgfs-fuse .host:/ /mnt/hgfs/ -o allow_other -o uid=1000
chsh root -s $(command -v bash)


apt purge vim
apt install jc jq yq netcat-traditional -y

#custom jq function for json to yaml


echo ZGVmIHlhbWxpZnkyOgogICAgKG9iamVjdHMgfCB0b19lbnRyaWVzIHwgKG1hcCgua2V5IHwgbGVuZ3RoKSB8IG1heCArIDIpIGFzICR3IHwKICAgICAgICAuW10gfCAoLnZhbHVlIHwgdHlwZSkgYXMgJHR5cGUgfAogICAgICAgIGlmICR0eXBlID09ICJhcnJheSIgdGhlbgogICAgICAgICAgICAiXCgua2V5KToiLCAoLnZhbHVlIHwgeWFtbGlmeTIpCiAgICAgICAgZWxpZiAkdHlwZSA9PSAib2JqZWN0IiB0aGVuCiAgICAgICAgICAgICJcKC5rZXkpOiIsICIgICAgXCgudmFsdWUgfCB5YW1saWZ5MikiCiAgICAgICAgZWxzZQogICAgICAgICAgICAiXCgua2V5KTpcKCIgIiAqICgua2V5IHwgJHcgLSBsZW5ndGgpKVwoLnZhbHVlKSIKICAgICAgICBlbmQKICAgICkKICAgIC8vIChhcnJheXMgfCBzZWxlY3QobGVuZ3RoID4gMClbXSB8IFt5YW1saWZ5Ml0gfAogICAgICAgICIgIC0gXCguWzBdKSIsICIgICAgXCguWzE6XVtdKSIKICAgICkKICAgIC8vIC4KICAgIDsK |base64 -d > ~/.jq

cd ~/.config/nvim
git clone https://github.com/preservim/vim-markdown.git
printf "vim.opt.runtimepath:append('~/.config/nvim/vim-markdown/')\n" >> ~/.config/nvim/init.lua

vmhgfs-fuse .host:/ /mnt/hgfs/ -o allow_other -o uid=1000

mkdir -p /root/work
cp /mnt/hgfs/Documents/info.yaml /root/work
echo "Close this terminal and restart"
