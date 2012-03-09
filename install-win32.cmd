@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

call mklink %HOME%\_gvimrc .\gvimrc
call mklink %HOME%\_vimrc .\vimrc

call mkdir %HOME%\.vim\bundle
call git clone https://github.com/gmarik/vundle.git %HOME%/.vim/bundle/vundle

@gvim.exe +BundleInstall! +BundleClean +q

pause
