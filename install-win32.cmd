@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@rem Installing Curl on Windows
@mklink /H %ProgramFiles(x86)%\Git\cmd\curl.cmd %CD%\lib\curl.cmd
call mklink /h %HOME%\_vimrc %CD%\vimrc

call mkdir %HOME%\vimfiles\bundle
call git clone https://github.com/gmarik/Vundle.vim.git %HOME%\vimfiles\bundle\Vundle.vim

gvim -c PluginInstall! -c PluginClean -c qa

pause
