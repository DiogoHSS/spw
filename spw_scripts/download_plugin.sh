#!/usr/bin/env sh

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
GRAY='\033[0;90m'
RESET_COLOR='\033[0m'

# Default values
default_repository="github"
# TODO: Add a way to change default dir
default_dir="$HOME/.config/nvim/pack/spw"

# Help function
display_usage() {
  echo "Usage: $YELLOW$0$RESET_COLOR $GRAY-r$RESET_COLOR|$GRAY--repository$RESET_COLOR <repository> $GREEN-u$RESET_COLOR|$GREEN--username$RESET_COLOR <username> $GREEN-n$RESET_COLOR|$GREEN--name$RESET_COLOR <plugin_name>"
  echo "   or: $YELLOW$0$RESET_COLOR $GRAY<repository>$RESET_COLOR $GREEN<username>$RESET_COLOR $GREEN<plugin_name>$RESET_COLOR\n"
  echo "Description:"
  echo "  Downloads from <repository> to $default_dir/<plugin_name>\n"
  echo "Options:"
  echo "  $GRAY-r$RESET_COLOR, $GRAY--repository$RESET_COLOR  Specify the source repository (default: $default_repository)"
  echo "  $GREEN-u$RESET_COLOR, $GREEN--username$RESET_COLOR    Specify the plugin's repository owner, required"
  echo "  $GREEN-n$RESET_COLOR, $GREEN--name$RESET_COLOR      Specify the plugin's name, required"
  echo "  $GRAY-h$RESET_COLOR, $GRAY--help$RESET_COLOR        Display this message"
}

if [ "$#" -lt 2 ]; then
  echo "Error: At least two arguments are required, <username> and <plugin_name>.\n"
  display_usage
  exit 1
fi

if [ "$#" -gt 6 ]; then
  echo "Error: Too many arguments\n\n"
  display_usage
  exit 1
fi

# Parse command-line arguments
while [ "$#" -gt 0 ]; do
  case "$1" in
    -h|--help)
      display_usage
      exit 0
      ;;
    -r|--repository)
      repository="$2"
      shift 2
      ;;
    -u|--username)
      username="$2"
      shift 2
      ;;
    -n|--name)
      plugin="$2"
      shift 2
      ;;
    *)
      # TODO: Allow more flexibility to giving arguments
      if [ "$#" -eq 3 ] && [ -z "$repository" ]; then
        repository="$1"
      elif [ "$#" -eq 2 ] && [ -z "$username" ]; then
        username="$1"
      elif [ "$#" -eq 1 ] && [ -z "$name" ]; then
        name="$1"
      else
        echo "Error: Too many arguments."
        display_usage
        exit 1
        # TODO: display taken variables and ask for confirmation to continue
      fi
      shift
      ;;
  esac
done

# Check if required arguments are provided
if [ -z "$username" ] || [ -z "$name" ]; then
  echo "The arguments <username> and <plugin> are required"
  display_usage
  exit 1
fi

if [ -z "$repository" ]; then
  repository="$default_repository"
fi

# Clone the plugin directory
# TODO: Add a way to change plugin name on install
git clone "https://$repository.com/$username/$name.git" "$default_dir/.downloads/$name"

echo "Plugin $name saved to $default_dir/.downloads/$name sucessfully!"

