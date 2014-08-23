if [ -z "$SUNGOD_PHEONIX_ROOT" ]; then
  SUNGOD_PHEONIX_ROOT="$HOME/Development/phoenix"
fi

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

function sg {
  if [[ "$1" == "new" ]] || [[ "$1" == "n" ]]; then
    __sg_new "$@"
  fi

  if [[ "$1" == "install" ]] || [[ "$1" == "i" ]]; then
    __sg_install
  fi

  if [[ "$1" == "server" ]] || [[ "$1" == "s" ]]; then
    __sg_server
  fi
}
