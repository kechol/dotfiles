#!/usr/bin/env bash

#symlinks
PWD=`pwd`
PREFIX='.'
DOTFILES=`ls`
IGNOREFILES=( .. backup bootstrap.sh brew.sh osx.sh README.md .git .gitignore .gitmodules osx )

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
  BACKUPDIR="${PWD}/backup/${BACKUPTIME}"

  if [ ! -d ${BACKUPDIR} ]
  then
    mkdir -p ${BACKUPDIR}
  fi

  if [ -f ${SYMLINK} ] && [ ! -L ${SYMLINK} ]
  then
    cp -pfa ${SYMLINK} ${BACKUPDIR}
    echo "Move: ${BACKUPDIR}/${SYMLINK}"
  fi

  if [ ! -L ${SYMLINK} ] || [ ! -e ${SYMLINK} ]
  then
    echo "Link: ${PWD}/${DOTFILE} => ${SYMLINK}"
    rm -Rf ${SYMLINK}
    ln -fs ${PWD}/${DOTFILE} ${SYMLINK}
  fi
done

