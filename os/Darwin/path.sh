# Xcode
pathmunge "/Developer/usr/bin"
# for brew
pathmunge "/usr/local/bin" before
# local scripts before anyting else
pathmunge "$HOME/bin" before
