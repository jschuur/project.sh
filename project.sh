function project {
  PROJECTS_DIR=~/Code/Personal
  CONFIG_DIR=~/.config/project.sh
  # or CODE_EDITOR=$EDITOR for your default editor
  CODE_EDITOR=code
  DESCRIPTION="${2:-"A new and exciting project"}"
  INSPIRATION="You can do the thing!"
  AUTHOR="Your Name <you@email.com>"

  if [ -d "$PROJECTS_DIR/$1" ]; then
    echo "Opening existing project $1 in your projects directory..."
    cd $PROJECTS_DIR/$1

    $CODE_EDITOR .
    return
  fi

  cd $PROJECTS_DIR
  mkdir -p $1
  cd $1

  git init > /dev/null
  npm init -y > /dev/null
  npm pkg set type='module'
  npm pkg set author=$AUTHOR
  npm pkg set description=$DESCRIPTION
  echo -e "# $1\n\n$DESCRIPTION" > README.md
  if [ -f "$CONFIG_DIR/README_footer.md" ]; then
    cat $CONFIG_DIR/README_footer.md >> README.md
  fi

  echo -e "node_modules\n.env" > .gitignore

  if [ -x "$(command -v say)" ]; then
    echo $INSPIRATION
    say $INSPIRATION
  fi

  $CODE_EDITOR .
}
