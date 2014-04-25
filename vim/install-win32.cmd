if not exist "%HOME%" set HOME=%HOMEDRIVE%%HOMEPATH%
if not exist "%HOME%" set HOME=%USERPROFILE%

call mklink /h %HOME%\_vimrc .\vimrc

call mkdir %HOME%\.vim\bundle
call git clone https://github.com/gmarik/Vundle.vim.git %HOME%\.vim\bundle\Vundle.vim

gvim -c PluginInstall! -c PluginClean -c qa

pause
