#!/usr/bin/env bash

## Structure of command.
## script_name.sh --name -n <Name> --export <Export Location> --type <type> --sleep <Sleep time in second> --silent-mode --verbose --dry-run --help
## script_name.sh -n <Name> -e <Export Location> -t <type> -s <Sleep time in second> --silent -v -d -h

## Check line 652

## Function section

help()
{
    echo -e "   Hello, $USER, either you wanted to seek help or entered the wrong argument."
    echo -e ""
    echo -e "   Arch Linux custom offline Repository Generator"
    echo -e "   Version 0.0.1 (Alpha)"
    echo -e ""
    echo -e "   Created by Fatin Ilham"
    echo -e ""
    echo -e "   Usage: $0 [OPTIONS]"
    echo -e "   OPTIONS:"
    echo -e "   ========"
    echo -e "   --name <name>, -n <name>                 specify the file name."
    echo -e "   --export <directory>, -e <directory>     specify the export directory (Default: /cnt)."
    echo -e "   --type <type>, -t <type>                 specify the export file type."
    echo -e "   --editor                                 specify the text editor of the script (Default: nano)."
    echo -e "   --sleep <second(s)>, -s <second(s)>      specify idle time for shutdown after completion in second(s)."
    echo -e "   --silent-mode, --silent                  do everything without asking the user."
    echo -e "   --verbose, -v                            show every process to the user."
    echo -e "   --restore-apps-list                      restores the default package list that comes within the script in current directory in "apps.txt" file."
    echo -e "   --clean                                  cleans unnecessary files created by the script."
    echo -e "   --dry-run, -d                            try to run the script without making massive system changes to see if the script works."
    echo -e "   --help, -h                               Show this help page."
    echo -e ""
    echo -e "   Type:"
    echo -e "   ====="
    echo -e "   iso                                      compress the main file as iso file (default)."
    echo -e "   zip                                      compress the main file as zip file."
    echo -e "   tar                                      compress the main file as tar file."
    echo -e "   raw                                      export raw folder (NOT RECOMENDED As some file name could be invalid when exporting to the host machine)."
    echo -e ""
}

clean()
{
    if [[ -d /isotmp ]]
    then
        rm -rf /isotmp
        echo -e "Removed /isotmp"
    fi
    if [[ -d $HOME/isotmp ]]
    then
        rm -rf $HOME/isotmp
        echo -e "Removed $HOME/isotmp"
    fi
    if [[ -d /mnt/tmp/blankdb ]]
    then
        rm -rf /mnt/tmp/blankdb
        echo -e "Removed /mnt/tmp/blankdb"
    fi
}

appslist()
{
    echo -e "base base-devel busybox libelf lib32-libelf coreutils pacman pacman-mirrorlist linux linux-headers linux-lts linux-lts-headers linux-hardened linux-hardened-headers linux-hardened-docs linux-firmware util-linux arch-install-scripts archinstall archiso dkms mkinitcpio bash expect fish fisher zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search dbus-daemon-units gnupg kleopatra nano emacs vi vim neovim neovim-qt zed codeblocks code intellij-idea-community-edition pycharm-community-edition efibootmgr mtools grub os-prober plymouth systemd sudo cryptsetup lvm2 veracrypt openssh sshguard vsftpd filezilla font-manager xorg gtk2 gtk3 gtk4 gtk-doc i3 i3-wm i3blocks i3lock i3status dmenu awesome awesome-terminal-fonts hyprland hyprlock hyprpaper ttf-font-awesome ttf-liberation ttf-jetbrains-mono dolphin wofi waybar sway swayidle swaybg swayimg swaylock foot polkit cinnamon wayland gdm gnome gnome-desktop gnome-remote-desktop gnome-extra gnome-tweaks gnome-terminal gnome-keyring sddm plasma plasma-desktop plasma-meta kde-applications kate calc xfce4 xfce4-power-manager xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings intel-media-driver mesa networkmanager network-manager-applet netstat-nat wireless_tools wpa_supplicant openvpn nmap sqlmap vulscan hydra hashcat wifite aircrack-ng proxychains-ng metasploit netcat wireshark-cli wireshark-qt termshark dnsmasq kismet dsniff seahorse secrets keepass bitwarden keysmith kwalletmanager lastpass-cli bitwarden-cli qtpass pass gopass vault dialog tmux terminator pipewire pipewire-pulse pipewire-jack ffmpeg mpv jellyfin-ffmpeg jellyfin-server jellyfin-web jellyfin-mpv-shim python-jellyfin-apiclient git flatpak wine vkd3d wine-mono wine-gecko wine-staging winetricks gum fprintd bluez blueberry blueman bluez-utils cups system-config-printer reflector kmod cargo fakeroot debugedit binutils usbutils pciutils inetutils usbctl timeshift backuppc file-roller zip unzip fuse-zip dosfstools libisoburn cdrtools xorriso wget transmission-cli transmission-gtk transmission-qt transmission-remote-gtk libtransmission proxychains-ng intel-ucode amd-ucode nvidia nvidia-utils nvidia-lts libva-mesa-driver ufw lxc p7zip unrar tar rsync exfat-utils fuse-exfat ntfs-3g udisks2 udisks2-btrfs udisks2-lvm2 udisks2-qt5 udiskie flac jasper aria2 docker curl kdenlive krita thunderbird apt nix rpm-tools dnf htop btop bashtop bpytop powertop screenfetch neofetch jp2a figlet cmatrix blender godot godot-mono libreoffice lynx links w3m chromium firefox tor torbrowser-launcher onionshare nginx nginx-mainline nginx-mod-echo nginx-mod-naxsi apache wordpress wp-cli wpscan apr apr-util php-apache php-legacy-apache dune nodejs nodejs-emojione nodejs-lts-hydrogen nodejs-lts-iron nodejs-source-map nodejs-yaml nodejs-nopt python-hatch-nodejs-version valabind caddy babel-cli s3rver vlc gimp obs-studio audacity inkscape podman distrobox virtualbox libvirt virt-manager virt-install virt-viewer qemu-full qemu libguestfs vde2 openbsd-netcat gnu-netcat bridge-utils kitty xterm lxterminal qterminal alacritty ldns ttf-fira-code ttf-fira-mono ttf-firacode-nerd gnu-free-fonts noto-fonts ttf-jetbrains-mono java-runtime jdk-openjdk jre-openjdk jre-openjdk-headless jre-openjdk-headless openjdk-src rust go autoconf make cmake mokutil bc gcc gcc-libs gcc-objc gcc-go gcc-rust clang mingw-w64-binutils mingw-w64-crt mingw-w64-gcc mingw-w64-headers mingw-w64-winpthreads aarch64-linux-gnu-binutils aarch64-linux-gnu-gcc aarch64-linux-gnu-gdb aarch64-linux-gnu-glibc aarch64-linux-gnu-linux-api-headers musl blaze php mysql sqlite python python3 python-adblock python-pip"
    apps_list="base base-devel busybox libelf lib32-libelf coreutils pacman pacman-mirrorlist linux linux-headers linux-lts linux-lts-headers linux-hardened linux-hardened-headers linux-hardened-docs linux-firmware util-linux arch-install-scripts archinstall archiso dkms mkinitcpio bash expect fish fisher zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search dbus-daemon-units gnupg kleopatra nano emacs vi vim neovim neovim-qt zed codeblocks code intellij-idea-community-edition pycharm-community-edition efibootmgr mtools grub os-prober plymouth systemd sudo cryptsetup lvm2 veracrypt openssh sshguard vsftpd filezilla font-manager xorg gtk2 gtk3 gtk4 gtk-doc i3 i3-wm i3blocks i3lock i3status dmenu awesome awesome-terminal-fonts hyprland hyprlock hyprpaper ttf-font-awesome ttf-liberation ttf-jetbrains-mono dolphin wofi waybar sway swayidle swaybg swayimg swaylock foot polkit cinnamon wayland gdm gnome gnome-desktop gnome-remote-desktop gnome-extra gnome-tweaks gnome-terminal gnome-keyring sddm plasma plasma-desktop plasma-meta kde-applications kate calc xfce4 xfce4-power-manager xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings intel-media-driver mesa networkmanager network-manager-applet netstat-nat wireless_tools wpa_supplicant openvpn nmap sqlmap vulscan hydra hashcat wifite aircrack-ng proxychains-ng metasploit netcat wireshark-cli wireshark-qt termshark dnsmasq kismet dsniff seahorse secrets keepass bitwarden keysmith kwalletmanager lastpass-cli bitwarden-cli qtpass pass gopass vault dialog tmux terminator pipewire pipewire-pulse pipewire-jack ffmpeg mpv jellyfin-ffmpeg jellyfin-server jellyfin-web jellyfin-mpv-shim python-jellyfin-apiclient git flatpak wine vkd3d wine-mono wine-gecko wine-staging winetricks gum fprintd bluez blueberry blueman bluez-utils cups system-config-printer reflector kmod cargo fakeroot debugedit binutils usbutils pciutils inetutils usbctl timeshift backuppc file-roller zip unzip fuse-zip dosfstools libisoburn cdrtools xorriso wget transmission-cli transmission-gtk transmission-qt transmission-remote-gtk libtransmission proxychains-ng intel-ucode amd-ucode nvidia nvidia-utils nvidia-lts libva-mesa-driver ufw lxc p7zip unrar tar rsync exfat-utils fuse-exfat ntfs-3g udisks2 udisks2-btrfs udisks2-lvm2 udisks2-qt5 udiskie flac jasper aria2 docker curl kdenlive krita thunderbird apt nix rpm-tools dnf htop btop bashtop bpytop powertop screenfetch neofetch jp2a figlet cmatrix blender godot godot-mono libreoffice lynx links w3m chromium firefox tor torbrowser-launcher onionshare nginx nginx-mainline nginx-mod-echo nginx-mod-naxsi apache wordpress wp-cli wpscan apr apr-util php-apache php-legacy-apache dune nodejs nodejs-emojione nodejs-lts-hydrogen nodejs-lts-iron nodejs-source-map nodejs-yaml nodejs-nopt python-hatch-nodejs-version valabind caddy babel-cli s3rver vlc gimp obs-studio audacity inkscape podman distrobox virtualbox libvirt virt-manager virt-install virt-viewer qemu-full qemu libguestfs vde2 openbsd-netcat gnu-netcat bridge-utils kitty xterm lxterminal qterminal alacritty ldns ttf-fira-code ttf-fira-mono ttf-firacode-nerd gnu-free-fonts noto-fonts ttf-jetbrains-mono java-runtime jdk-openjdk jre-openjdk jre-openjdk-headless jre-openjdk-headless openjdk-src rust go autoconf make cmake mokutil bc gcc gcc-libs gcc-objc gcc-go gcc-rust clang mingw-w64-binutils mingw-w64-crt mingw-w64-gcc mingw-w64-headers mingw-w64-winpthreads aarch64-linux-gnu-binutils aarch64-linux-gnu-gcc aarch64-linux-gnu-gdb aarch64-linux-gnu-glibc aarch64-linux-gnu-linux-api-headers musl blaze php mysql sqlite python python3 python-adblock python-pip"
}

invalidname()
{
    invalidname=${name:1}
    if [[ $invalidname == "/" || $invalidname == "." ]]
    then
        echo -e "Do not use "$invalidname" at the end."
        echo -e "Error: 2 (Invalid argument)"
        exit 2
    elif [[ $name == "" ]]
    then
        echo -e "Error: 7 (Name not specified by user $USER)"
        exit 7
    fi
}

invaliddir()
{
    invaliddir=${export:1}
    if [[ $invaliddir == "/" ]]
    then
        echo -e "Do not use "$invaliddir" at the end of directory"
        echo -e "Error: 2 (Invalid argument)"
        exit 2
    elif [[ $export == "" ]]
    then
        echo -e "Error: 7 (Export directory not selected by user $USER)"
        exit 7
    fi
}

dirconf()
{
    echo -e "Export directory $export NOT found on system."
    read -p "   Do you want to make directory ($export) in order to continue? [Y/n] " dircreateconf
    if [[ $dircreateconf == "n" || $dircreateconf == "N" ]]
    then
        echo -e "Error: 7 (Could not setup export directory)"
        exit 7
    else
        mkdir $export
        echo -e "Export directory $export created and assigned."
        sleep 3
    fi
}

editorinstall()
{
    read -p ""$text_editor" was not found on your system.\nDo you want to install "$text_editor"? [Y/n]:" edinconf
    if [[ $edinconf == "n" || $edinconf == "N" ]]
    then
        echo -e "Error: 96(Editor not configured.)"
        exit 96
    else
        pacman -Sy $text_editor --noconfirm
    fi

}

autoeditorcheck()
{
    for text_editor in nano vim vi nvim emacs
    do
        if [[ -f /usr/bin/$text_editor ]]
        then
            EDITOR=$text_editor
            break;
        else
            continue;
        fi
        echo -e "Error: 96(Editor not configured.)"
        exit 96
    done
}

editorconf()
{
    if [[ $EDITOR != "" && -f /usr/bin/$EDITOR ]]
    then
        echo -e "Text editor is set to $EDITOR"
        sleep 3
    else
        echo -e "Text editor not found."
        echo -e "Installing "nano""
        sleep 3
        pacman -S nano --noconfirm && EDITOR="nano"
    fi
}

smdircheck()
{
    if [[ -d $export ]]
    then
        echo -e "The ($export) directory exists. Assigned export directory to $export"
        sleep 3
    else
        echo -e "Silent mode enabled. But $export directory not found. Creating $export without user: $USER's permission."
        sleep 3
        mkdir $export
        echo -e "Assigned export directory to $export"
        sleep 3
    fi
}

dircheck()
{
    if [[ -d $export ]]
    then
        echo -e "Export directory $export found. Assigned export directory to $export"
        sleep 3
    else
        dirconf
    fi
}

copycatexport()
{
    #    name=$(cat $location/name)
    #    export=$(cat $location/export)

    #    na=$(cat $location/na)
    #    nb=$(cat $location/nb)
    #    nc=$(cat $location/nc)
    #    nd=$(cat $location/nd)
    #    ne=$(cat $location/ne)

    cp /mnt/$na $export/

    cp /mnt/$nb $export/

    cp /mnt/custom/$name/$nc $export/ && cp /mnt/custom/$name/$nc /mnt/

    cp /mnt/custom/$name/$nd $export/ && cp /mnt/custom/$name/$nd /mnt/

    cp /mnt/custom/$name/$ne $export/ && cp /mnt/custom/$name/$ne /mnt/
}

formaltimer()
{
    export Sleep

    if [[ $sleep -ge 86400 ]]
    then
        tday=$(( $sleep / 86400 ))
        tdayrem=$(( $sleep % 86400 ))
        thour=$(( $tdayrem / 3600 ))
        thourrem=$(( $tdayrem % 3600 ))
        tminute=$(( $thourrem / 60 ))
        tminuterem=$(( $thourrem % 60 ))
        tsecond=$tminuterem
    elif [[ $sleep -lt 86400 && $sleep -ge 3600 ]]
    then
        tday=0
        thour=$(( $sleep / 3600 ))
        thourrem=$(( $sleep % 3600 ))
        tminute=$(( $thourrem / 60 ))
        tminuterem=$(( $thourrem % 60 ))
        tsecond=$tminuterem
    elif [[ $sleep -lt 3600 && $sleep -ge 60 ]]
    then
        tday=0
        thour=0
        tminute=$(( $sleep / 60 ))
        tminuterem=$(( $sleep % 60 ))
        tsecond=$tminuterem
    elif [[ $sleep -lt 60 ]]
    then
        tday=0
        thour=0
        tminute=0
        tsecond=$sleep
    elif [[ $sleep -eq 0 ]]
    then
        sleep=0
        no_sleep=1
    else
        echo -e "Error: 24 (Invalid timer setting)"
        exit 24
    fi
}

log_export()
{
    echo -e "$na    $ca $ma\n" >> /mnt/log.txt
    echo -e "$nb    $cb $mb\n" >> /mnt/log.txt
    echo -e "$nc    $cc $mc\n" >> /mnt/log.txt
    echo -e "$nd    $cd $md\n" >> /mnt/log.txt
    echo -e "$ne    $ce $me\n" >> /mnt/log.txt
}

rerunfunc()
{
    echo -e "Script failed to complete the task successfully.\n\n"
    echo -e "Do you want to rerun the script? [Y/n]"
    read failedrerun
    if [[ $failedrerun == "n" || $failedrerun == "N" ]]
    then
        echo -e "Error: 99 (Failed)"
        exit 99
    else
        sudo "$0" "$@"
    fi
}

## Storing the arguments

while [[ $# -gt 0 ]]
do
    case $1 in
        -n|--name)
            name=$2
            export name
            if [[ ${2:1} == "/" ]]
            then
                echo -e "Do not use "/" at the end of directory"
                echo -e "Error: 2 (Invalid argument)"
                exit 2
            fi
            shift 2
            ;;

        -e|--export)
            export=$2
            export export
            if [[ ${2:1} == "/" ]]
            then
                echo -e "Do not use "/" at the end of directory"
                echo -e "Error: 2 (Invalid argument)"
                exit 2
            fi
            shift 2
            ;;

        -t|--type)
            type=$2
            export type
            case $type in
                iso)
                    format=1
                    ;;
                zip)
                    format=2
                    ;;
                tar)
                    format=3
                    ;;
                raw)
                    format=4
                    ;;
                *)
                    echo -e "Error: 1 (Invalid argument $2)"
                    help
                    exit 1
                    ;;
            esac
            shift 2
            ;;

        --editor)
            text_editor=$2
            shift 2
            ;;

        -s|--sleep)
            sleep=$2
            export sleep
            formaltimer
            shift 2
            ;;

        -v|--verbose)
            verbose=1
            shift
            ;;

        --silent-mode|--silent)
            silent_mode=1
            shift
            ;;

        --restore-apps-list)
            appslist
            exit 0
            ;;

        --clean)
            clean
            exit 0
            ;;

        -h|--help)
            help
            exit 0
            ;;

        *)
            echo -e "Unknown flag / option "$1""
            if [ $2 != "" ]
            then
                echo -e "With argument $2"
            fi
            echo -e "Error: 1 (Invalid Argument)"
            help
            exit 1
            ;;

    esac
done

## OS checking

release_file=/etc/os-release

if [[ $silent_mode -eq 1 ]]
then
    echo -e "\n\nSilent Mode enabled. User will not be interrupted by prompts. Users are thought to be aware of RISKS."
    sleep 5
elif grep -q "Arch" $release_file
then
    echo -e "\n\nThe OS is Arch Linux.\n\nRunning this script on Bare Metal (Without Hypervisor / Virtual Machine) could result damages to your computer files.\nIn this case, you could deny the process right now\nOR\nRUN it on YOUR OWN RISK."
    sleep 5
    read -p "   Are you sure, you really want to run this script? [y/N] " conf

    [[ $conf != "y" || $conf != "Y" ]] && echo -e " Error: 99 (Service denied by user)" ; exit 99
else
    echo -e "The OS is not specifically Arch Linux...\n\nRemember that this script is specially designed for Arch Linux running on a virtual machine.\nThis script might also work on Arch Linux Based Distributions.\nRunning this script on distribution other than Arch Linux and running it on Bare Metal (Without Hypervisor / Virtual Machine) could result damages to your computer files.\nIn this case, you could deny the process right now\nOR\nRUN it on YOUR OWN RISK."
    sleep 3
    read -p "   Are you sure, you really want to run this script? [y/N] " conf

    [[ $conf != "y" || $conf != "Y" ]] && echo -e " Error: 99 (Service denied by user)" ; exit 99
fi

## Checking Pacman commands.

if [[ -f /usr/bin/pacman || -f /usr/sbin/pacman ]]
then
    echo -e "Pacman command found."
else
    echo -e "Error: 4 (Commands not found)"
    exit 4
fi

## Checking privileges

if [[ $EUID -ne 0 ]]
then
    if [[ $silent_mode -eq 1 ]]
    then
        echo -e "You are not running the script as ROOT user. Sudo privilege needed"
        echo "Attempting to rerun as root..."
        sleep 3
        sudo "$0" "$@"
    else
        echo -e "You are not running the script as ROOT user. Sudo privilege needed."
        sleep 4
        read -p "   Want to run this script again as root? [Y/n]: " sudo_confirm
        if [[ $sudo_confirm == "y" || $sudo_confirm == "Y" || $sudo_confirm == "" ]]
        then
            echo "Attempting to rerun as root..."
            sleep 3
            sudo "$0" "$@"
        elif [[ $sudo_confirm == "n" || $sudo_confirm == "N" ]]
        then
            echo -e "Okay, exiting..."
            echo -e "Error: 1 (no ROOT access)"
            exit 1
        else
            echo -e "Error: 98 (Service denied by user)"
            exit 98
        fi
    fi
else
    echo -e "You are running as root."
    sleep 2
fi

## Exporting important variables

name2=$(echo $name)
export2=$(echo $export)
type2=$(echo $type)
sleep2=$(echo $sleep)

## Determining the name of the Exported file / folder

if [[ $silent_mode -eq 1 ]]
then
    if [[ $name2 != "" ]]
    then
        name=$name2
        invalidname
        echo -e "Silent mode enabled. Creating name as "$name""
    else
        name="Custom_Repo"
        echo -e "Silent mode enabled. Creating name of the file / folder as "$name""
        sleep 3
    fi
else
    if [[ $name2 != "" ]]
    then
        name=$name2
        invalidname
    else
        read -p "   What do you want to name your repository file (without extention) / folder? " name
        invalidname
        echo -e "Repository file / folder name is set to $name"
        sleep 3
    fi
fi

## Determining the export location of the ISO file.

if [[ $silent_mode -eq 1 ]]
then
    if [[ $export2 != "" ]]
    then
        export=$export2
        invaliddir
        smdircheck
    else
        export="/cnt"
        invaliddir
        echo -e "Silent mode enabled. But Export directory not specified. Assigning export directory to $export without user: $USER's permission."
        sleep 3
        smdirchec5
    fi
else
    if [[ $export2 != "" ]]
    then
        export=$export2
        invaliddir
        echo -e "Export directory specified to $export"
        sleep 3
        dircheck
    else
        echo -e "Export directory not specified by user $USER"
        read -p "   Where do you want to export? " export
        invaliddir
        echo -e "Export directory specified to $export"
        sleep 3
        dircheck
    fi
fi

## Determining post-operation work.

if [[ $silent_mode -eq 1 ]]
then
    if [[ $sleep2 != "" ]]
    then
        sleep=$sleep2
        echo -e "Silent mode enabled. Shutting down computer after $sleep seconds."
        sleep 5
    elif [[ $sleep2 -eq 0 ]]
    then
        echo -e "Silent mode enabled. Computer will shutdown immediately when the process is successfully completed."
        sleep 5
    else
        echo -e "Silent mode enabled. Doing nothing if process completed."
        sleep 5
    fi
else
    read -p "Do you want to turn off your computer after completing the operation? [y/N]" act_sleep 
    if [[ $act_sleep == "y" || $act_sleep == "Y" ]]
    then
        read -p "   Set the timer period (in seconds) after fully Completing process (Press enter to do nothing after process completed.): " sleep
        export sleep
        formaltimer
        sleep 5
    else
        echo -e "Computer will stay awake after the process is successfully completed."
        sleep 5
        no_sleep=1
    fi
fi


na="$name.iso"
nb="$name.iso.sha256.txt"
nc="package-sha256.sum.txt"
nd="package-list.lst.txt"
ne="package-sum-integrity-sha256.sum.txt"


resofsuccess="Failed"

if [[ $EUID -eq 0 ]]
then
    if [[ -d /isotmp || -d $HOME/isotmp ]]
    then
        rm -rf /isotmp;
        rm -rf $HOME/isotmp;
    fi
    mkdir /isotmp
else
    mkdir $HOME/isotmp
fi

if [[ $EUID -eq 0 && -d /isotmp ]]
then
    location=/isotmp
elif [[ -d $HOME/isotmp ]]
then
    location=$HOME/isotmp
else
    echo -e "Error: 7 (Could not create /isotmp or $HOME/isotmp directory)"
    exit 7
fi

export location

export name
export export

export na
export nb
export nc
export nd
export ne

export HOME

cd $HOME

## Backing up original Pacman configuration.

if [[ -f /etc/pacman.conf.bak ]]
then
    cp /etc/pacman.conf.bak /etc/pacman.conf
else
    cp /etc/pacman.conf /etc/pacman.conf.bak
fi

## Reconfiguring the default editor.

unset EDITOR

if [[ $silent_mode -eq 1 ]]
then
    if [[ -z $text_editor ]]
    then
        echo -e "Text editor not defined by user $USER"
        autoeditorcheck
    else
        if [[ -f /usr/bin/$text_editor ]]
        then
            EDITOR=$text_editor
        else
            echo -e "Text editor not selected by user $USER. Checking for default text editors"
            sleep 2
            autoeditorcheck
            editorconf
        fi
    fi
else
    if [[ ! -z $text_editor && -f /usr/bin/$text_editor ]]
    then
        EDITOR=$text_editor
    elif [[ ! -z $text_editor && ! -f /usr/bin/$text_editor ]]
    then
        editorinstall
    else
        echo -e "Which text editor do you want to pick for editing?"
        echo -e "1. nano"
        echo -e "2. vim"
        echo -e "3. vi"
        echo -e "3. nvim"
        echo -e "4. emacs"
        read -p "Choose any option or write your prefered terminal based text editor [1, 2, 3, 4]: " text_editor_select

        case $text_editor_select in
            1)
                text_editor="nano"
                ;;
            2)
                text_editor="vim"
                ;;
            3)
                text_editor="vi"
                ;;
            4)
                text_editor="emacs"
                ;;
            *)
                read -p "Are you sure you want to use $text_editor_select \nThis script will not gurantee that it will work properly or not. [Y/n]" usertexteditorselectconf
                if [[ $usertexteditorselectconf != "n" || $usertexteditorselectconf != "N"]]
                then
                    text_editor=$text_editor_select
                else
                    echo -e "Error: 96 (Text editor not configured.)"
                    exit 96
                fi
                ;;
        esac
fi


$EDITOR /etc/pacman.conf

## If reflector exists, remove it.

[[ -f /usr/bin/reflector ]] && pacman -Rns reflector --noconfirm;

## Backing up original Pacman mirrorlist that came with ISO

if [[ -f /etc/pacman.d/mirrorlist.iso-original.bak ]]
then
    cp /etc/pacman.d/mirrorlist.iso-original.bak /etc/pacman.d/mirrorlist
else
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.iso-original.bak
fi

## Installing necessary tools and prerequisites

#while ! pacman -Sy archlinux-keyring xorriso zip expect wget libisoburn cdrtools --noconfirm;
#do
#    echo -e "Prerequisites failed to install and update.\nRetrying..."
#done
#
#echo -e "Prerequisites installed and updated successfully..."


while ! pacman -Sy archlinux-keyring nano xorriso zip expect wget libisoburn cdrtools --noconfirm ; do :; done
echo -e "Prerequisites installed and updated successfully..."
sleep 3

## Creating and backing up Pacman All mirrors

if [[ -f /etc/pacman.d/mirrorlist.all-official.bak ]]
then
    cp /etc/pacman.d/mirrorlist.all-official.bak /etc/pacman.d/mirrorlist
else
    mkdir $HOME/mirrorlist/
    cd $HOME/mirrorlist/
    while ! wget https://archlinux.org/mirrorlist/all/ ; do :; done
    mv $HOME/mirrorlist/* $HOME/mirrorlist/mirrorlist.all-official.bak
    mv $HOME/mirrorlist/mirrorlist.all-official.bak /etc/pacman.d/
    cp /etc/pacman.d/mirrorlist.all-official.bak /etc/pacman.d/mirrorlist
    rm -rf $HOME/mirrorlist
fi

nano /etc/pacman.d/mirrorlist

## User defined disk configuration [ This Section needs automation depending on total disk capacity ]

lsblk

sleep 7

cfdisk

mkswap /dev/sda1 ; swapon /dev/sda1 ; 

mkfs.ext4 /dev/sda2 && mount /dev/sda2 /mnt || umount /mnt && mkfs.ext4 /dev/sda2 && mount /dev/sda2 /mnt

## Prepearing for downloading packages

mkdir -p /mnt/custom/$name && mkdir -p /mnt/tmp/blankdb

cp $export/install-packages-automatically-script.exp $HOME/install-packages-automatically-script.exp

cp $export/*apps.txt $HOME/apps.txt

cp $HOME/apps.txt $location/apps.txt

if [[ ! -Z $EDITOR ]]
then
    $EDITOR $location/apps.txt
else
    echo -e "No Default Text editors found.\nIncorrect Text editor specified"
    echo -e "Error: 96 (Text editor not found)"
    exit 96
fi


## Downloading Pacman packages only

if [[ $silent_mode -eq 1 ]]
then
    pacman -Syyw --cachedir /mnt/custom/$name --dbpath /mnt/tmp/blankdb $(cat $location/apps.txt) --noconfirm
else
    pacman -Syyw --cachedir /mnt/custom/$name --dbpath /mnt/tmp/blankdb $(cat $location/apps.txt)
 #    while ! expect $HOME/install-packages-automatically-expect-script.exp ; do :; done
fi


cd /mnt/custom/$name/
rm  package-list.lst.txt package-sha256.sum.txt package-sum-integrity-sha256.sum.txt $name.db $name.db.tar.zst $name.files $name.files.tar.zst;
repo-add ./$name.db.tar.zst ./*[^sig]
chmod 7777 -R /mnt/custom/$name/ && sha256sum * >> /mnt/custom/$name/package-sha256.sum.txt

cd /mnt/custom/$name/
echo -e "SHA-256 sum of 'package-sha256.sum.txt' \n " >> /mnt/custom/$name/package-sum-integrity-sha256.sum.txt
sha256sum package-sha256.sum.txt >> /mnt/custom/$name/package-sum-integrity-sha256.sum.txt

cd /mnt/custom/$name/
ls >> ./package-list.lst.txt
ls | grep 'package-list.lst.txt'

chmod 7777 -R /mnt
cd /mnt/custom/$name/
xorriso -as mkisofs -o /mnt/$name.iso -iso-level 3 -full-iso9660-filenames -R -J -joliet -allow-lowercase -allow-multidot -relaxed-filenames -rock ./*
cd /mnt/
sha256sum $name.iso >> /mnt/$name.iso.sha256.txt;


copycatexport


## Testing.... Here....

for ns in na nb nc nd ne
do
    if [[ -f /mnt/$ns ]]
    then
        declare "c${ns:1}="Created""
    else
        declare "c${ns:1}="Not Created""
    fi

    if [[ -f $export/$ns ]]
    then
        declare "m${ns:1}=" and Transfered.""
    else
        declare "m${ns:1}=" but Not Transfered.""
    fi
done


## If above not work, Then Use this. [ Remember, here "eval" is used. It has security Concerns ]


#for ns in na nb nc nd ne
#do
#    if [[ -f /mnt/$ns ]]
#    then
#        createdvar="c${ns:1}"
#        eval "$createdvar="Created""
#    else
#        createdvar="c${ns:1}"
#        eval "$createdvar="Not Created""
#    fi
#
#    if [[ -f $export/$ns ]]
#    then
#        madevar="m${ns:1}"
#        eval "$madevar="and Transfered""
#    else
#        madevar="m${ns:1}"
#        eval "$madevar=" but Not Transfered.""
#    fi
#done


## If none of above work, use this...
## This is the manual and bloated method...


#if [[ -f /mnt/$na ]]
#then
#    ca="Created"
#else
#    ca="Not Created"
#fi
#
#if [[ -f $export/$na ]]
#then
#    ma=" and Transfered."
#else
#    ma=" but Not Transfered."
#fi
#
#if [[ -f /mnt/$nb ]]
#then
#    cb="Created"
#else
#    cb="Not Created"
#fi
#
#if [[ -f $export/$nb ]]
#then
#    mb=" and Transfered."
#else
#    mb=" but Not Transfered."
#fi
#
#if [[ -f /mnt/$nc ]]
#then
#    cc="Created"
#else
#    cc="Not Created"
#fi
#
#if [[ -f $export/$nc ]]
#then
#    mc=" and Transfered."
#else
#    mc=" but Not Transfered."
#fi
#
#if [[ -f /mnt/$nd ]]
#then
#    cd="Created"
#else
#    cd="Not Created"
#fi
#
#if [[ -f $export/$nd ]]
#then
#    md=" and Transfered."
#else
#    md=" but Not Transfered."
#fi
#
#if [[ -f /mnt/$ne ]]
#then
#    ce="Created"
#else
#    ce="Not Created"
#fi
#
#if [[ -f $export/$ne ]]
#then
#    me=" and Transfered."
#else
#    me=" but Not Transfered."
#fi



if [[ -f $export/$na && -f $export/$nb && -f $export/$nc && -f $export/$nd && -f $export/$ne ]]
then
    resofsuccess="fully completed"
    comp=1
elif [[ -f $export/$na || -f $export/$nb || -f $export/$nc || -f $export/$nd || -f $export/$ne ]]
then
    resofsuccess="partially completed"
    comp=2
else
    resofsuccess="failed"
fi


## These two lines are vanished as junk
# day=$(date +"%d")
# daysuffix=$(case $day in 1|01|21|31) echo "st";; 2|02|22) echo "nd";; 3|03|23) echo "rd";; *) echo "th";; esac)


## day=$(date +"%d")

case $(date +"%d") in
    1|01|21|31)
        daysuffix="st"
        ;;
    2|02|22)
        daysuffix="nd"
        ;;
    3|03|23)
        daysuffix="rd"
        ;;
    *)
        daysuffix="th"
        ;;
esac


if [[ $comp -eq 1 ]]
then
    echo -e "Process $resofsuccess on $(date +" %A %d")$daysuffix $(date +" %B, %Y At %T")\nAll Done!!!\nHave a nice day!!!\n\nHere is The log...\n\n" >> /mnt/log.txt
else
    echo -e "Process $resofsuccess\n\nHere is The log...\n\n" >> /mnt/log.txt
    log_export
    cat /mnt/log.txt
    mv /mnt/log.txt $export/
    rerunfunc
fi

cat /mnt/log.txt

mv /mnt/log.txt $export/

if [[ $no_sleep -ne 1 ]]
then
    while [[ $sleep -ne 0 ]]
    do
        echo -e "$sleep\n"
        sleep 1
        sleep=$(( $sleep -1 ))
    done
    cat /mnt/log.txt
    mv /mnt/log.txt $export/
    shutdown
fi

exit 0