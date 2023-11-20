#!/usr/bin/env sh

# Default values
pack_dir="$HOME/.config/nvim/pack/spw"
init_file="$HOME/.config/nvim/init.lua"
lua_dir="$HOME/.config/nvim/lua/spw"
init_lua_file="$lua_dir/init.lua"

if [ ! -d "$pack_dir" ]; then
  mkdir -p "$pack_dir"
  echo "Created package directory at ${pack_dir}\n"
fi

if [ ! -d "$lua_dir" ]; then
  mkdir -p "$lua_dir"
  echo "Created package config directory at ${lua_dir}"
  touch "$init_lua_file"
  echo "Created package config file $init_lua_file\n"
fi

if [ ! -f "$init_lua_file" ]; then
  touch "$init_lua_file"
  echo "Created package config file $init_lua_file\n"
fi

if ! grep -q "require('spw')" "$init_file"; then
  sed -i '1s/^/-- Plugin manager config\nrequire('"'"'spw'"'"')\n\n/' "$init_file"
  echo "Modified config at ${init_file}"
fi

