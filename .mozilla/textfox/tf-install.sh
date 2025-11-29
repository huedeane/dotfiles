#!/bin/bash
# textfox installation script

print_logo() {
  cat <<EOF
   __            __  ____          
  / /____  _  __/ /_/ __/___  _  __
 / __/ _ \| |/_/ __/ /_/ __ \| |/_/
/ /_/  __/>  </ /_/ __/ /_/ />  <  
\__/\___/_/|_|\__/_/  \____/_/|_|  
EOF
}

clean_path() {
  local fp="$1"
  fp="${fp/#\~/$HOME}" # Expand ~ to $HOME
  fp="${fp%/}"         # Remove trailing slash if exists
  fp="${fp/\/\//\/}"   # Remove double slashes
  fp="${fp//\'/}"      # Remove single quotes
  fp="${fp//\"/}"      # Remove double quotes
  echo "$fp"
}

backup_profile() {
  local fp="$1"
  backup_filepath=~/.mozilla/textfox/backup
  echo "${backup_filepath}/chrome.bak"
  if [ -d "${backup_filepath}/chrome.bak" ]; then
    read -rp "Do you want to restore your backup? (y/N): " backup_profile
    if [[ "$backup_profile" =~ ^[yY]$ ]]; then
      rm -rf "${fp}/chrome"
      rm -rf "${fp}/user.js"
      cp -rv "${backup_filepath}/chrome.bak" "${fp}/chrome"
      exit 0
    fi
  else
    echo "No backup found, creating."
    echo "${fp}/chrome"
    if [ -d "${fp}/chrome" ]; then
      echo "Info: Backing up existing chrome directory..."
      echo "${fp}/chrome"
      echo "${backup_filepath}/chrome.bak"
      cp -rv "${fp}/chrome" "${backup_filepath}/chrome.bak"
    fi
  fi
}

copy_chrome() {
  local fp="$1"
  fp="$(clean_path "${fp}")"
  if [[ -d "${fp}" ]]; then
    echo "Copying textfox/chrome/ -> ${fp}/chrome/"
    rm -rf "${fp}/chrome"
    cp -r "$HOME/.mozilla/textfox/chrome" "${fp}/chrome"
  else
    echo "The specified Firefox profile path does not exist: ${fp}"
    return 1
  fi
}

install_user_js() {
  local fp="$1"
  fp="$(clean_path "${fp}")"

  # Optionally install user.js
  read -rp "Do you want to install the user.js file? (Y/N): " install_js

  case "$install_js" in
  [Yy]*)
    cp -v "$HOME/.mozilla/textfox/user.js" "$fp/user.js"
    ;;
  *)
    echo "Skipping user.js installation."
    ;;
  esac
}

tf_install() {
  printf "\nInstalling textfox...\n"

  local fp

  file_path=$(find ~/.mozilla/firefox/ -type d -name "*.default-release" -print -quit)
  fp="$(clean_path "${file_path}")"

  # Check if profile folder exists
  if [ -z "$fp" ]; then
    echo "Error: Profile does not exist"
    exit 1
  fi

  echo "Using Firefox Profile @ ${fp}"
  backup_profile "${fp}"
  copy_chrome "${fp}"
  install_user_js "${fp}"
  printf "✓ Installation completed\n"
}

print_logo
tf_install "$@"
