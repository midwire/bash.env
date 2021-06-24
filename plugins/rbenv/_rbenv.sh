pathmunge ~/.rbenv/bin before
pathmunge ~/.rbenv/shims before
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# This function is useful if you have installed ruby-build as a rbenv plugin using Git
function rbenv-update-versions {
  # Update the ruby-build plugin repo
  gitdir="$(rbenv root)"/plugins/ruby-build/.git
  worktree="$(rbenv root)"/plugins/ruby-build
  git --git-dir="$gitdir" --work-tree="$worktree" pull
}
