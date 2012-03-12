# Xcode
pathmunge "/Developer/usr/bin"
# for bundler --binstubs
pathmunge "./bin" before
# for brew
pathmunge "/usr/local/bin" before
# local scripts before anyting else
pathmunge "$HOME/bin" before
