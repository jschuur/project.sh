function create_project {

  PROJECTS_DIR=${HOME}/Code/Personal
  CONFIG_DIR=${HOME}/.config/project.sh
  # PACKAGE_INIT="npm init -y"
  # PACKAGE_INIT="yarn init -y"
  PACKAGE_INIT="pnpm init"
  # or CODE_EDITOR=$EDITOR for your default editor
  CODE_EDITOR=code
  DESCRIPTION="${2:-"A new and exciting project"}"
  INSPIRATION="You can do the thing!"
  AUTHOR="Your Name <you@email.com>"

  if [ ! -d "${PROJECTS_DIR}/${1}" ]; then
    mkdir -p "${PROJECTS_DIR}/${1}"
  fi
  cd "${PROJECTS_DIR}/${1}"

  git init > /dev/null
  eval "$PACKAGE_INIT > /dev/null"
  # modifies existing package.json https://docs.npmjs.com/cli/v9/commands/npm-pkg
  npm pkg set type='module'
  npm pkg set author=$AUTHOR
  npm pkg set description=$DESCRIPTION
  echo -e "# $1\n\n$DESCRIPTION" > README.md
  if [ -f "$CONFIG_DIR/README_footer.md" ]; then
    cat $CONFIG_DIR/README_footer.md >> README.md
  fi

  echo -e "node_modules\n.env" > .gitignore

  echo $INSPIRATION
  if [ -x "$(command -v say)" ]; then
    # You can also do `if [[ $(which say) ]];then...` to test for existence of an executable in your $PATH
    # Or you could do a host check and see if you're on Darwin (MacOS) and run the say command, since `say`
    # is installed on all Mac desktop operating systems... since Jaguar, I think? Maybe it was Panther. 
    say $INSPIRATION
  fi

  echo "Opening existing project \"${1}\" in your projects directory..."
  ${CODE_EDITOR} "${PROJECTS_DIR}/${1}"

}
