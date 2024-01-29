# Lua Utils

A place to put some useful Lua functions.

I mainly just needed a cross-platform version of `io.popen 'ls'` for my [WezTerm](https://wezfurlong.org/) config. Other functions might come later.

[Wezterm](https://wezfurlong.org/) doesn't support loading shared objects ([and Wez doesnt want to](https://github.com/wez/wezterm/issues/2088)), so this library contains single-purpose binaries for anything that can't be done in pure Lua. The Lua module just uses `io.popen` to wrap the functionality.

It really isn't designed to be used by anyone else because its very specific to my own [dotfiles](https://github.com/ethanavatar/dotfiles/). Modifications would likely be required to make it work elsewhere. 
