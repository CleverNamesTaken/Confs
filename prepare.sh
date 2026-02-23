#!/bin/sh
# Install nomachine

#wget 'https://download.nomachine.com/download/8.14/Linux/nomachine_8.14.2_1_amd64.deb'
#dpkg -i nomachine_8.14.2_1_amd64.deb
##	lsof -i tcp:4000
#rm nomachine_8.14.2_1_amd64.deb


apt update -y

#Sorry vim.  I hate you vimscript.
apt purge vim -y
apt install -y jc jq yq netcat-traditional neovim golang-go pipx git
pipx install git+https://github.com/Pennyw0rth/NetExec
rm -f /root/.nxc/workspaces/default/rdp.db

pushd ../Ask/
git remote set-url origin https://github.com/CleverNamesTaken/Ask
git pull
popd
pushd ../Mousetrap/
git remote set-url origin https://github.com/CleverNamesTaken/Ask
git pull
popd
pushd ../pizza_chit.nvim/
git remote set-url origin https://github.com/CleverNamesTaken/Ask
git pull
popd

cp tmux.conf /etc
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/

mkdir -p ~/.config/ask
cp ask.yaml ~/.config/ask/config.yaml
mkdir -p /tmp/snippets

pushd ../Mousetrap/
bash *sh
popd
pushd ../Ask/
mkdir -p ~/gits/Confs/all/
go build
mv ask /usr/bin/
chmod +x /usr/bin/
mkdir -p /tmp/snippets/all
ask render ultisnips
popd

git clone https://github.com/SirVer/ultisnips ~/.config/nvim/ultisnips/
chsh root -s $(command -v bash)

#custom jq function for json to yaml


echo ZGVmIHlhbWxpZnkyOgogICAgKG9iamVjdHMgfCB0b19lbnRyaWVzIHwgKG1hcCgua2V5IHwgbGVuZ3RoKSB8IG1heCArIDIpIGFzICR3IHwKICAgICAgICAuW10gfCAoLnZhbHVlIHwgdHlwZSkgYXMgJHR5cGUgfAogICAgICAgIGlmICR0eXBlID09ICJhcnJheSIgdGhlbgogICAgICAgICAgICAiXCgua2V5KToiLCAoLnZhbHVlIHwgeWFtbGlmeTIpCiAgICAgICAgZWxpZiAkdHlwZSA9PSAib2JqZWN0IiB0aGVuCiAgICAgICAgICAgICJcKC5rZXkpOiIsICIgICAgXCgudmFsdWUgfCB5YW1saWZ5MikiCiAgICAgICAgZWxzZQogICAgICAgICAgICAiXCgua2V5KTpcKCIgIiAqICgua2V5IHwgJHcgLSBsZW5ndGgpKVwoLnZhbHVlKSIKICAgICAgICBlbmQKICAgICkKICAgIC8vIChhcnJheXMgfCBzZWxlY3QobGVuZ3RoID4gMClbXSB8IFt5YW1saWZ5Ml0gfAogICAgICAgICIgIC0gXCguWzBdKSIsICIgICAgXCguWzE6XVtdKSIKICAgICkKICAgIC8vIC4KICAgIDsK |base64 -d > ~/.jq

cd ~/.config/nvim
git clone https://github.com/preservim/vim-markdown.git

printf "vim.opt.runtimepath:append('~/.config/nvim/vim-markdown/')\n" >> ~/.config/nvim/init.lua
echo "Close this terminal and restart"
