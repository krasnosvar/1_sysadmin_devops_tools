# powershell -executionpolicy bypass -File 'C:\Users\Den\Documents\choco.ps1'
$Packages = 'libreoffice',
            'foxitreader',
            'fbreader',
            'gimp',
            'vlc',
            'audacity',
            'copyq',
            'flameshot',
            'rufus',
            'telegram',          
            'keepassxc',
            'telegram',
            'rocketchat',

            'googlechrome',
            'vivaldi',
            'brave',
            'firefox',
            'librewolf',

            'forticlientvpn',
            'openvpn-connect',
            'openconnect-gui',
            'wireshark',
            'termius',
            'winscp',
            'putty',
            'kitty',
            'teraterm',

            'git',
            'python3',
            'golang',
            'openjdk8',
            'openjdk21',
            'vscode',
            'vscodium',
            'neovim',
            'pycharm-community',
            'notepadplusplus',

            'ansible',
            'terraform',
            'opentofu.portable',
            'dbeaver-ce',
            'httpie',
            'curl',
            'postman',

            'docker-desktop',
            'kubernetes-cli',
            'podman-desktop',
            'rancher-desktop',

            'wsl-ubuntu-2204',
            'wslgit',
            'virtualbox',
            'steam'


If(Test-Path -Path "$env:ProgramData\Chocolatey") {
  # DoYourPackageInstallStuff
  ForEach ($PackageName in $Packages)
    {
        choco install $PackageName -y
    }
}
Else {
  # InstallChoco
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))


  # DoYourPackageInstallStuff
  ForEach ($PackageName in $Packages)
    {
        choco install $PackageName -y
    }
}
