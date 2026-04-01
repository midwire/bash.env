source_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source Linux bash_completion if it exists
if [[ -f /etc/bash_completion ]]; then
  . /etc/bash_completion
fi

# Source plugin completions
for i in $source_dir/files/**/* ; do
  if [[ -r "$i" ]]; then
    . $i
  fi
done
unset i

# Turn on brew completion if it exists
if command -v brew &>/dev/null; then
  brew_prefix="$(brew --prefix)"
  if [[ -f "$brew_prefix/etc/bash_completion" ]]; then
    . "$brew_prefix/etc/bash_completion"
  fi
  unset brew_prefix
fi

# RVM completions
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

# Dynamic completions — lazy-loaded on first tab-complete per tool.
# This avoids running expensive `tool completion bash` at shell startup.

_lazy_completion() {
  local cmd="$1"
  local completion_cmd="$2"
  eval "_lazy_complete_${cmd}() {
    complete -r \"$cmd\" 2>/dev/null
    unset -f \"_lazy_complete_${cmd}\"
    eval \"\$($completion_cmd 2>/dev/null)\"
    return 124  # retry completion with the real handler
  }"
  complete -F "_lazy_complete_${cmd}" "$cmd"
}

# Register lazy completions for installed tools
command -v docker &>/dev/null && _lazy_completion docker "docker completion bash"
command -v kubectl &>/dev/null && _lazy_completion kubectl "kubectl completion bash"
command -v helm &>/dev/null && _lazy_completion helm "helm completion bash"
command -v npm &>/dev/null && _lazy_completion npm "npm completion"
command -v pip &>/dev/null && _lazy_completion pip "pip completion --bash"
command -v pip3 &>/dev/null && _lazy_completion pip3 "pip3 completion --bash"
command -v cargo &>/dev/null && _lazy_completion cargo "rustup completions bash cargo"
command -v rustup &>/dev/null && _lazy_completion rustup "rustup completions bash rustup"
command -v gh &>/dev/null && _lazy_completion gh "gh completion -s bash"
command -v minikube &>/dev/null && _lazy_completion minikube "minikube completion bash"
command -v kind &>/dev/null && _lazy_completion kind "kind completion bash"

# These use `complete -C` which is already lightweight (no subprocess at startup)
command -v terraform &>/dev/null && complete -C "$(command -v terraform)" terraform
command -v aws_completer &>/dev/null && complete -C "$(command -v aws_completer)" aws

# gcloud (file-based, also lightweight)
if [[ -r "/usr/share/google-cloud-sdk/completion.bash.inc" ]]; then
  . "/usr/share/google-cloud-sdk/completion.bash.inc"
elif [[ -n "${CLOUDSDK_ROOT_DIR:-}" && -r "${CLOUDSDK_ROOT_DIR}/completion.bash.inc" ]]; then
  . "${CLOUDSDK_ROOT_DIR}/completion.bash.inc"
fi
