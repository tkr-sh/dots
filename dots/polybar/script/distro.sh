case $1 in
    ubuntu)
        echo "%{F#D63708}%{F-}"
        ;;
    debian)
        echo "%{F#B9165A}%{F-}"
        ;;
    centos)
        echo "%{F#8CAE35}%{F-}"
        ;;
    fedora)
        echo "%{F#2E3563}%{F-}"
        ;;
    arch)
        echo "%{F#2280BC}%{F-}"
        ;;
   gentoo)
        echo "%{F#806FA1}󰣨%{F-}"
        ;;
    *)
        echo "%{F}%{F-}"
        ;;
esac
