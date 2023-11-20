#!/usr/bin/env sh

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
GRAY='\033[0;90m'
RESET_COLOR='\033[0m'

# Default value
plugin_type="start"
repository="github"
plugin_dir="$HOME/.config/nvim/pack/spw/"

# Help function
display_usage() {
  echo "Usage: $YELLOW$0$RESET_COLOR $GRAY-t$RESET_COLOR|$GRAY--type$RESET_COLOR <type> $GRAY-r$RESET_COLOR|$GRAY--repository$RESET_COLOR <repository> $GREEN-u$RESET_COLOR|$GREEN--username$RESET_COLOR <username> $GREEN-p$RESET_COLOR|$GREEN--plugin$RESET_COLOR <plugin>"
  echo "   or: $YELLOW$0$RESET_COLOR $GRAY<type>$RESET_COLOR $GRAY<repository>$RESET_COLOR $GREEN<username>$RESET_COLOR $GREEN<plugin>$RESET_COLOR\n"
  echo "       $YELLOW$0$RESET_COLOR -h|--help"
  echo "       Display this message\n"
  echo "Description:"
  echo "  Downloads from repository to $plugin_dir<plugin>\n"
  echo "Options:"
  echo "  $GRAY-t$RESET_COLOR, $GRAY--type$RESET_COLOR        Specify the plugin type (e.g. python, git) (default: $plugin_type)"
  echo "  $GRAY-r$RESET_COLOR, $GRAY--repository$RESET_COLOR  Specify the source repository (default: $repository)"
  echo "  $GREEN-u$RESET_COLOR, $GREEN--username$RESET_COLOR    Specify the plugin's repository owner"
  echo "  $GREEN-p$RESET_COLOR, $GREEN--plugin$RESET_COLOR      Specify the plugin's name"
}

# Parse command-line arguments
while [ "$#" -gt 0 ]; do
  case "$1" in
    -h|--help)
      display_usage
      exit 0
      ;;
    -t|--type)
      plugin_type="$2"
      shift 2
      ;;
    -r|--repository)
      repository="$2"
      shift 2
      ;;
    -u|--username)
      username="$2"
      shift 2
      ;;
    -p|--plugin)
      plugin="$2"
      shift 2
      ;;
    *)
      echo "Unkown option: $1"
      display_usage
      exit 1
      ;;
  esac
done

# Check if required arguments are provided
if [ -z "$username" ] || [ -z "$plugin" ]; then
  echo "The arguments `username` and `plugin` are required"
  display_usage
  exit 1
fi

# Clone the plugin directory
git clone "https://github.com/$username/$plugin.git" "$plugin_dir$plugin_type/$plugin"

echo "Plugin $plugin saved to $plugin_dir$plugin_type$plugin sucessfully!"

