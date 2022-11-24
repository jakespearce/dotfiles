#!/bin/bash

# If the dotfile exists in the dotfile directory then delete dotfile from original source and replace with a symlink pointing to the specified dotfile in the ~/dotfile dir

# Adding a new dotfile:
# 1. Make a copy of the dotfile to the ~/dotfiles dir
# 2. Add a corresponding variable containing the path to the dotfile in the Paths for dotfiles section
# 3. Add a variable for the symlink location in the Symlink targets section
# 4. Add a call to the Function calls section - Call the create_symlink_to_dotfile function supplying the symlink location and dotfile location as arguments in that order


dotfiles_dir="${HOME}/dotfiles"


# Paths for dotfiles

vimrc_dotfile="${dotfiles_dir}/vim/vimrc"
i3_dotfile="${dotfiles_dir}/i3/config"
i3status_dotfile="${dotfiles_dir}/i3status/config"
bashrc_dotfile="${dotfiles_dir}/login/bashrc"
terminator_dotfile="${dotfiles_dir}/terminator/config"
xmodmap_dotfile="${dotfiles_dir}/login/Xmodmap"
zshrc_dotfile="${dotfiles_dir}/login/zshrc"


# Symlink targets

vimrc_symlink_target="${HOME}/.vimrc"
i3_symlink_target="${HOME}/.config/i3/config"
i3status_symlink_target="${HOME}/.config/i3status/config"
bashrc_symlink_target="${HOME}/.bashrc"
terminator_symlink_target="${HOME}/.config/terminator/config"
xmodmap_symlink_target="${HOME}/.Xmodmap"
zshrc_symlink_target="${HOME}/.zshrc"


create_symlink_to_dotfile(){

	local symlink_target="$1"
	local dotfile="$2"

	# If the dotfile supplied as argument exists
	if [ -e "$dotfile" ]; then
		# Replace the target file with a symlink poiting to dotfile location
		rm "$symlink_target" 2>/dev/null
		ln -s "$dotfile" "$symlink_target"
		[[ $? -eq 0 ]] && echo "${dotfile} symlinked to ${symlink_target}"
	else
		# Display the reason for not symlinking in red
		echo -e "\033[0;31m Error: file not found: ${dotfile} \033[0m"
	fi

}


# Function calls
create_symlink_to_dotfile "$vimrc_symlink_target"  "$vimrc_dotfile"
create_symlink_to_dotfile "$i3_symlink_target" "$i3_dotfile"
create_symlink_to_dotfile "$i3status_symlink_target" "$i3status_dotfile"
create_symlink_to_dotfile "$bashrc_symlink_target" "$bashrc_dotfile"
create_symlink_to_dotfile "$terminator_symlink_target" "$terminator_dotfile"
create_symlink_to_dotfile "$xmodmap_symlink_target" "$xmodmap_dotfile"
create_symlink_to_dotfile "$zshrc_symlink_target" "$zshrc_dotfile"

