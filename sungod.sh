if [ -z "$SUNGOD_PHEONIX_ROOT" ]; then
  SUNGOD_PHEONIX_ROOT="$HOME/Development/phoenix"
fi

function __sg_usage {
  echo ""
  echo "Usage:"
  echo ""
  echo "  Sungod runs common phoenix development tasks"
  echo ""
  echo "  sungod new [application] (mix pheonix.new [application] $PWD/[application] )"
  echo "  sungod server (mix phoenix.server)"
  echo "  sungod install (mix do deps.get, compile)"
  echo "  sungod assets [-w] (gulp build, [-w gulp watch])"
  echo ""
  echo "  Or use the handy shortcut sg"
  echo ""
  echo "  sg n (new)"
  echo "  sg s (server)"
  echo "  sg i (install)"
  echo "  sg a (assets)"
  echo ""
}

function __sg_cdpheonix {
  cd "$SUNGOD_PHEONIX_ROOT"
}

function __sg_install {
  mix do deps.get, compile
}

function __sg_server {
  mix phoenix.start
}

function __sg_new {
  local appname="$2"
  local install_location="$PWD/$appname"

  __sg_cdpheonix

  mix phoenix.new "$appname" "$install_location"
  cd "$install_location"

  __sg_install
  __sg_server
}

function __sg_gulp_build {
  gulp build
}

function __sg_gulp_watch {
  gulp watch
}

function sungod {
  sg "$@"
}

function sg {
  if [[ "$1" == "new" ]] ||
     [[ "$1" == "n" ]]; then
    __sg_new "$@"
  fi

  if [[ "$1" == "install" ]] ||
     [[ "$1" == "i" ]]; then
    __sg_install
  fi

  if [[ "$1" == "server" ]] ||
     [[ "$1" == "s" ]]; then
    __sg_server
  fi

  if [[ "$1" == "server" ]] ||
     [[ "$1" == "s" ]]; then
    __sg_server
  fi

  if [[ "$1" == "assets" ]] ||
     [[ "$1" == "a" ]] ||
     [[ "$2" == "assets" ]] ||
     [[ "$2" == "a" ]]; then

    if [[ "$1" == "-w" ]] ||
       [[ "$2" == "-w" ]]; then

      __sg_gulp_watch

    else

      __sg_gulp_build

    fi
  fi

  if [[ -z "$1" ]]; then
    __sg_usage
  fi
}
