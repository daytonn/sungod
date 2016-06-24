#!/usr/bin/env bash

__sg_usage() {
  echo ""
  echo "Usage:"
  echo ""
  echo "  Sungod runs common phoenix development tasks"
  echo ""
  echo "  sungod new [application]  (mix pheonix.new application)"
  echo "  sungod server             (mix phoenix.server)"
  echo "  sungod install            (mix do deps.get, compile)"
  echo "  sungod assets [-w]        (gulp build, [-w gulp watch])"
  echo "  sungod migrate            (mix ecto.migrate Repo)"
  echo "  sungod migration [table]  (mix ecto.gen.migration Repo [table])"
  echo "  sungod rollback [-a]      (mix ecto.rollback Repo, [-a --all])"
  echo ""
  echo "  Or use the handy shortcut sg"
  echo ""
  echo "  sg  n (new)"
  echo "  sg  s (server)"
  echo "  sg  i (install)"
  echo "  sg  a (assets)"
  echo "  sg  m (migrate)"
  echo "  sg mg (migration)"
  echo ""
}

__sg_install() {
  mix "do" deps.get, compile
}

__sg_server() {
  mix phoenix.server
}

__sg_new() {
  local appname="$1"
  local install_location="$PWD/$appname"

  mix phoenix.new "$install_location" --app "$appname"
  cd "$install_location" || exit

  __sg_install
  __sg_server
}

__sg_migrate() {
  mix ecto.migrate Repo
}

__sg_migration() {
  if [[ -n "$1" ]]; then
    local table="$1"
    mix ecto.gen.migration Repo "$table"
  else
    echo "table not defined!"
  fi
}

__sg_rollback() {
  if [[ "$1" == "-a" ]] ||
     [[ "$1" == "--all" ]] ||
     [[ "$2" == "-a" ]] ||
     [[ "$2" == "--all" ]]; then

    mix ecto.rollback Repo --all
  else
    mix ecto.rollback Repo
  fi
}

sungod() {
  sg "$@"
}

sg() {
  if [[ -z "$1" ]]; then
    __sg_usage
  else
    if [[ "$1" == "new" ]] || [[ "$1" == "n" ]]; then
      __sg_new "$2"
    fi

    if [[ "$1" == "install" ]] || [[ "$1" == "i" ]]; then
      __sg_install
    fi

    if [[ "$1" == "server" ]] || [[ "$1" == "s" ]] ||
       [[ "$1" == "serve" ]] || [[ "$1" == "start" ]]; then
      __sg_server
    fi

    if [[ "$1" == "migrate" ]] || [[ "$1" == "m" ]]; then
      __sg_migrate
    fi

    if [[ "$1" == "migration" ]] || [[ "$1" == "mg" ]]; then
      __sg_migration "$2"
    fi

    if [[ "$1" == "rollback" ]] || [[ "$1" == "rb" ]] ||
       [[ "$2" == "rollback" ]] || [[ "$2" == "rb" ]]; then
      __sg_rollback "$@"
    fi
  fi
}
