function project {
  cd ~/Code/Personal
  mkdir -p $1
  cd $1
  git init
  npm init -y
  touch README.md
  echo 'node_modules' > .gitignore
  echo '.env' >> .gitignore
  code .
}