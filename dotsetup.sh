# Path to the JSON file
PACKAGE_JSON=".dotpackage.json"

# Function to check if the script is run with sudo privileges
function check_sudo() {
   if [ "$(id -u)" -eq 0 ] && [ "$1" != "bypass" ]; then
    echo "Do not run this script with sudo. Exiting."
    exit 1
  fi

  if [ "$(id -u)" -ne 0 ]; then
    if [[ "$PWD" == "$HOME/dotfiles" ]]; then
      echo "Delete and moving files."
      cd ~
      cp -rf ~/dotfiles/. ~/
      rm -rf dotfiles
    fi
 
    echo "Executing with bypass"
    exec sudo bash "$0" "bypass" "$@"
  fi
}

# Function to detect the package manager
function detect_package_manager() {
  if command -v apt-get &>/dev/null; then
    PACKAGE_MANAGER="apt"
    INSTALL_CMD="apt install -y"
  elif command -v dnf &>/dev/null; then
    PACKAGE_MANAGER="dnf"
    INSTALL_CMD="dnf install -y"
  elif command -v yum &>/dev/null; then
    PACKAGE_MANAGER="yum"
    INSTALL_CMD="yum install -y"
  elif command -v pacman &>/dev/null; then
    PACKAGE_MANAGER="pacman"
    INSTALL_CMD="pacman -S --noconfirm"
  else
    echo "Unsupported package manager. Please install manually."
    exit 1
  fi
}

# Reload to sudo
check_sudo "$@"

# Detect the package manager
detect_package_manager

# Check if jq is installed before proceeding
check_jq_installed

# Read the JSON file and parse the package list using jq
# Install packages listed in the JSON file
for package in $(jq -r '.packages[] | @base64' "$PACKAGE_JSON"); do
  _jq() {
    echo ${package} | base64 --decode | jq -r ${1}
  }

  name=$(_jq '.name')
  version=$(_jq '.version')
  install_type=$(_jq '.install_type')
  exec_command=$(_jq '.exec')
  echo ""
  echo "---$name---"
  # Handle installation based on install type
  if [ "$install_type" == "command" ] && [ "$exec_command" != "" ]; then
    echo "Running custom installation command: $exec_command"
    echo ""
    install_custom_command "$exec_command"
  elif [ "$install_type" == "package-manager" ] && [ "$version" == "latest" ]; then
    echo "Installing the latest version of $name..."
    install_latest "$name"
  elif [ "$install_type" == "package-manager" ] && [ "$version" != "latest" ]; then
    echo "Installing $name version $version..."
    install_version "$name" "$version"
  fi
done

echo ""
echo "---Finished---"
echo "Setup complete!"

