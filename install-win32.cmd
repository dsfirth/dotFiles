@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

REM Installing Curl on Windows
call mklink /H "%ProgramFiles%\Git\cmd\curl.cmd" "%CD%\lib\curl.cmd"

call mklink /H "%HOME%\_vimrc" "%CD%\vimrc"

IF NOT EXIST "%HOME%/.vim/bundle/vundle" (
	call mkdir "%HOME%\.vim\bundle"
)

IF NOT EXIST "%HOME%/.vim/bundle/Vunde.vim" (
	call git clone https://github.com/gmarik/Vundle.vim.git "%HOME%/.vim/bundle/Vundle.vim"
) ELSE (
	call cd "%HOME%/.vim/bundle/Vunde.vim"
	call git pull
	call cd %HOME%
)

call gvim +BundleInstall! +BundleClean +qall
pause
