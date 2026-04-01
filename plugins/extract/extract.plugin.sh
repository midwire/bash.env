# Extract plugin - universal archive extraction command

_extract_check_tool() {
  local tool="$1"
  if ! command -v "$tool" &>/dev/null; then
    echo "Error: '$tool' is not installed. Please install it to extract this format."
    return 1
  fi
  return 0
}

extract() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: extract <archive_file>"
    return 1
  fi

  local file="$1"

  if [[ ! -f "$file" ]]; then
    echo "Error: '$file' is not a valid file."
    return 1
  fi

  case "$file" in
    *.tar.gz|*.tgz)
      _extract_check_tool tar && tar xzf "$file"
      ;;
    *.tar.bz2|*.tbz2)
      _extract_check_tool tar && tar xjf "$file"
      ;;
    *.tar.xz|*.txz)
      _extract_check_tool tar && tar xJf "$file"
      ;;
    *.tar.zst)
      _extract_check_tool tar && _extract_check_tool zstd && tar --zstd -xf "$file"
      ;;
    *.tar)
      _extract_check_tool tar && tar xf "$file"
      ;;
    *.zip)
      _extract_check_tool unzip && unzip "$file"
      ;;
    *.gz)
      _extract_check_tool gunzip && gunzip "$file"
      ;;
    *.bz2)
      _extract_check_tool bunzip2 && bunzip2 "$file"
      ;;
    *.xz)
      _extract_check_tool unxz && unxz "$file"
      ;;
    *.zst)
      _extract_check_tool zstd && zstd -d "$file"
      ;;
    *.7z)
      _extract_check_tool 7z && 7z x "$file"
      ;;
    *.rar)
      _extract_check_tool unrar && unrar x "$file"
      ;;
    *.Z)
      _extract_check_tool uncompress && uncompress "$file"
      ;;
    *)
      echo "Error: unsupported archive format for '$file'."
      return 1
      ;;
  esac
}
