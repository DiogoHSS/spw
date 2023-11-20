#!/usr/bin/env sh

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET_COLOR='\033[0m'

# Default value
plugin_type="start"
repository="github"
plugin_dir="$HOME/.config/nvim/pack/spw/"

# Help function
display_usage() {
  echo "Usage: $0 ${YELLOW}-t${RESET_COLOR}|${YELLOW}--type${RESET_COLOR} <type> ${YELLOW}-r${RESET_COLOR}|${YELLOW}--repository${RESET_COLOR} <repository> ${YELLOW}-u${RESET_COLOR}|${YELLOW}--username${RESET_COLOR} <username> ${YELLOW}-p${RESET_COLOR}|${YELLOW}--plugin${RESET_COLOR} <plugin>"
  echo "   or: $0 <type> <repository> <username> <plugin>\n"
  echo "       $0 ${YELLOW}-h${RESET_COLOR}|${YELLOW}--help${RESET_COLOR}"
  echo "       Display this message\n"
  echo "Description:"
  echo "  Downloads from repository to ${plugin_dir}<plugin>\n"
  echo "Options:"
  echo "  ${GREEN}-t${RESET_COLOR}, ${GREEN}--type${RESET_COLOR}        Specify the plugin type (e.g. python, git) (default: ${plugin_type})"
  echo "  ${GREEN}-r${RESET_COLOR}, ${GREEN}--repository${RESET_COLOR}  Specify the source repository (default: ${repository})"
  echo "  ${GREEN}-u${RESET_COLOR}, ${GREEN}--username${RESET_COLOR}    Specify the plugin's repository owner"
  echo "  ${GREEN}-p${RESET_COLOR}, ${GREEN}--plugin${RESET_COLOR}      Specify the plugin's name"
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
git clone "https://github.com/$username/$plugin.git" "${plugin_dir}${plugin_type}${plugin}"

echo "Plugin ${plugin} saved to ${plugin_dir}${plugin_type}${plugin}sucessfully!"

