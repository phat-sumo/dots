# make setup for dots

help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?# "}; {printf "\033[32m%-10s\033[0m %s\n", $$1, $$2}'

ryuko: ag dmenu dunst dwm dwmblocks emacs hosts htop nvim picom st zsh # ag dmenu dunst dwm dwmblocks emacs hosts htop nvim picom st zsh 
lite: vim zsh-lite  

ag: 
	@echo "configuring ag..."
	@stow -R ag 2>&1 | grep -v $(STOW_BUG) || : 
	@cd ~/.ag && ./build.sh && sudo make install

chunkwm:
	@echo "configuring chunkwm..."
	@stow -R chunkwm 2>&1 | grep -v $(STOW_BUG) || : 

dmenu:
	@echo "configuring dmenu..."
	@stow -R dmenu 2>&1 | grep -v $(STOW_BUG) || : 
	@cd ~/.dmenu && sudo make clean install

dunst:
	@echo "configuring dunst..."
	@stow -R dunst 2>&1 | grep -v $(STOW_BUG) || : 

dwm:
	@echo "configuring dwm..."
	@stow -R dwm 2>&1 | grep -v $(STOW_BUG) || : 
	@cd ~/.dwm && sudo make clean install

dwmblocks:
	@echo "configuring dwmblocks..."
	@stow -R dwmblocks 2>&1 | grep -v $(STOW_BUG) || : 
	@cd ~/.dwmblocks && sudo make clean install

emacs:
	@echo "configuring emacs..."
	@stow -R emacs 2>&1 | grep -v $(STOW_BUG) || : 

firefox:
	@echo "configuring firefox..."
	@echo "TODO: get proper path for firefox install"

hosts:
	@echo "configuring ssh hosts..."
	@stow -R hosts 2>&1 | grep -v $(STOW_BUG) || : 

htop:
	@echo "configuring htop..."
	@stow -R htop 2>&1 | grep -v $(STOW_BUG) || : 

nvim:
	@echo "configuring neovim..."
	@stow -R nvim 2>&1 | grep -v $(STOW_BUG) || : 
	@cd rend && make nvim

picom:
	@echo "configuring picom..."
	@stow -R picom 2>&1 | grep -v $(STOW_BUG) || : 

scripts:
	@echo "configuring scripts..."
	@cd scripts
	@sudo make all 2>&1 | grep -v $(STOW_BUG) || : 

st:
	@echo "configuring st..."
	@stow -R st 2>&1 | grep -v $(STOW_BUG) || : 
	@cd ~/.st && sudo make clean install

vim:
	@echo "configuring vim..."
	@stow -R vim 2>&1 | grep -v $(STOW_BUG) || : 

yabai:
	@echo "configuring yabai..."
	@stow -R yabai 2>&1 | grep -v $(STOW_BUG) || : 

zsh:
	@echo "configuring zsh..."
	@stow -R zsh 2>&1 | grep -v $(STOW_BUG) || : 

zsh-lite:
	@echo "configuring zsh-lite..."
	@stow -R zsh-lite 2>&1 | grep -v $(STOW_BUG) || : 

.PHONY: ag chunkwm dmenu dunst dwm dwmblocks emacs firefox hosts htop nvim picom scripts st vim yabai zsh

STOW_BUG := "BUG in find_stowed_path? Absolute/relative mismatch between Stow dir .dots and path"
