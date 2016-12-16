New-Item -Path "$env:HOME\_vimrc" -ItemType "SymbolicLink" -Value "$PSScriptRoot\vimrc" -ErrorAction SilentlyContinue

# ensure the ~/.vim/autoload, ~/.vim/bundle, ~/.vim/colors directories exists
if (!(Test-Path -Path "$env:HOME\.vim\autoload")) New-Item -Path "$env:HOME\.vim\autoload" -ItemType "Directory"
if (!(Test-Path -Path "$env:HOME\.vim\bundle")) New-Item -Path "$env:HOME\.vim\bundle" -ItemType "Directory"
if (!(Test-Path -Path "$env:HOME\.vim\colors")) New-Item -Path "$env:HOME\.vim\colors" -ItemType "Directory"

Invoke-WebRequest -Uri "http://www.vim.org/scripts/download_script.php?src_id=24649" -OutFile "$env:HOME\.vim\colors\jellybeans.vim"
Invoke-WebRequest -Uri "https://tpo.pe/pathogen.vim" -OutFile "$env:HOME\.vim\autoload\pathogen.vim"

Set-Location -Path "$env:HOME\.vim\bundle"
git clone https://github.com/tpope/vim-sensible.git
git clone https://github.com/tpope/vim-surround.git
