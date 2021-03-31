param (
    [Parameter(Position=0)]
    [ValidateSet('all','install','update','pathogen','clean')]
    [string]$Target = 'all'
)

switch ($Target)
{
    'all'   { $_ = "update" }
    'install' {
        Write-Output "Backing up existing .vim and _vimrc to $HOME/.vim.bak, $HOME/_vimrc.bak,"
        if (Test-Path -Path "$HOME\.vim") { Move-Item -Path "$HOME\.vim" -Destination "$HOME\.vim.bak" }
        if (Test-Path -Path "$HOME\_vimrc") { Move-Item -Path "$HOME\_vimrc" -Destination "$HOME\_vimrc.bak" }

        Write-Output "initializing submodules,"
        git submodule update --init

        Write-Output "linking up new .vim and _vimrc,"
        New-Item -Path "$HOME\.vim" -ItemType Junction -Value "$PSScriptRoot\vim"
        New-Item -Path "$HOME\_vimrc" -ItemType HardLink -Value "$PSScriptRoot\vimrc"
        Write-Output "All done.  Happy Vimming!"
    }
    'update' {
        git submodule foreach git pull origin master
        $_ = "pathogen" # fall-through
     }
    'pathogen' {
        Invoke-WebRequest -Uri "https://tpo.pe/pathogen.vim" -OutFile "$PSScriptRoot\vim\autoload\pathogen.vim"
     }
    'clean' {
        Remove-Item -Path "$HOME\.vim","$HOME\_vimrc" -Recurse -Force -ErrorAction Ignore
    }
}
