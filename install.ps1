New-Item -Path "$env:HOME\_vimrc" -ItemType "SymbolicLink" -Value "$PSScriptRoot\vimrc" -ErrorAction SilentlyContinue

# ensure the ~/.vim/colors directory exists
if (!(Test-Path -Path "$env:HOME\.vim\colors"))
{
    New-Item -Path "$env:HOME\.vim\colors" -ItemType "Directory"
}

Invoke-WebRequest -Uri "http://www.vim.org/scripts/download_script.php?src_id=24649" -OutFile "$env:HOME\.vim\colors\jellybeans.vim"