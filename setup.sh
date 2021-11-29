#!/bin/bash

cd ${HONME}

new_dir=dotfiles

create_sym_link() {
    # ln -sb original_file sym_link
    # above will work on ubuntu but not on osx
    # -s == --symbolic on ubuntu
    # -b == --backup on ubuntu

    # -f is testing file existence
    # -d is testing directory existence
    # -L is testing symbolic link existence
    # see "man test" for detail
    if  test -f ${1}  ; then
	echo ${1}
	mv ${1} dotfiles.old/.
    fi

    if  test -d ${1}  ; then
	echo ${1}
	mv ${1} dotfiles.old/.
    fi

    ln -s ${new_dir}/${1} .
}

mkdir -p dotfiles.old

create_sym_link .screenrc
create_sym_link .bash_profile
create_sym_link .bashrc
create_sym_link .bashrc_custom
create_sym_link .dir_colors
create_sym_link .emacs.d
create_sym_link .byobu

cd -
