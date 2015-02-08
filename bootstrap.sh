#!/bin/bash

#update self
git pull

#symlinks
PWD=`pwd`
PREFIX='.'
DOTFILES=`ls`
IGNOREFILES=( .. bak bootstrap.sh README.md .git .gitignore .gitmodules )

for DOTFILE in ${DOTFILES[@]}
do
  for IGNOREFILE in ${IGNOREFILES[@]}
  do
    if [ ${DOTFILE} == ${IGNOREFILE} ]
    then
      continue 2
    fi
  done

  SYMLINK="${HOME}/${PREFIX}${DOTFILE}"
  BACKUPTIME=`date +%s`
  BACKUPDIR="${PWD}/bak/${BACKUPTIME}"

  if [ ! -d ${BACKUPDIR} ]
  then
    mkdir -p ${BACKUPDIR}
  fi

  if [ -f ${SYMLINK} ]
  then
    cp -pfH ${SYMLINK} ${BACKUPDIR}
  fi

  echo "${PWD}/${DOTFILE} => ${SYMLINK}"
  ln -fs ${PWD}/${DOTFILE} ${SYMLINK}
done


#git
git submodule init
git submodule update


#vim
vim +BundleInstall +q +q


