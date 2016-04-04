#!/usr/bin/env bash

#symlinks
PWD=`pwd`
PREFIX='.'
DOTFILES=`ls`
IGNOREFILES=( .. bak bootstrap.sh brew.sh osx.sh README.md .git .gitignore .gitmodules osx )

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
    cp -pfa ${SYMLINK} ${BACKUPDIR}
  fi

  echo "${PWD}/${DOTFILE} => ${SYMLINK}"
  rm -Rf ${SYMLINK}
  ln -fs ${PWD}/${DOTFILE} ${SYMLINK}
done

