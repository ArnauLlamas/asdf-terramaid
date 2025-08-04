#!/usr/bin/env bash

set -euo pipefail

TOOL_NAME="terramaid"
TOOL_TEST="terramaid --version"
OWNER="RoseSecurity"
REPO="$TOOL_NAME"
GH_REPO="https://github.com/${OWNER}/${REPO}"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

list_all_versions() {
  list_github_releases
}

list_github_releases() {
  curl "${curl_opts[@]}" \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$OWNER/$REPO/releases \
  | awk -F': ' '/tag_name/{gsub(/[v",]*/, "");print $2}'
}

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  local platform
  [ "Linux" = "$(uname)" ] && platform="Linux" || platform="Darwin"

  local arch
  case "$(uname -m)" in
    x86_64) arch=x86_64 ;;
    x86) arch=i368 ;;
    aarch64|arm64) arch=arm64 ;;
  esac

  url="$GH_REPO/releases/download/v${version}/Terramaid_${platform}_${arch}.tar.gz"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3/bin"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"

    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/$tool_cmd "$install_path"

    chmod +x "$install_path/$tool_cmd"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful in $install_path!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
