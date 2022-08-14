#!/bin/bash

CMD="docker compose \
  -p parallax-trade \
  -f compose/compose.mariadb.yml \
  -f compose/compose.scraper.yml"

function build()
{
  echo "##### Docker Compose Build #####"
  eval "$CMD" --profile "$1" --env-file "$2" build
}

function run()
{
  echo "##### Docker Compose Run #####"
  eval "$CMD" --profile "$1" --env-file "$2" up --remove-orphans
}

function menu()
{
  PS3="빌드와 실행 방식을 선택하세요 > "
  COLUMNS=30
  options=("Build and Run" "Run" "Quit")
  select yn in "${options[@]}"; do
      case $yn in
          "Build and Run" ) build "$1" "$2"; run "$1" "$2"; break;;
          "Run" )           run   "$1" "$2"; break;;
          "Quit" )          exit;;
      esac
  done
}

echo
PS3="실행할 서비스를 선택하세요 > "
COLUMNS=20
options=(
  "Scraper"
  "MariaDB"
  "Quit"
)
select yn in "${options[@]}"; do
    case $yn in
        "Scraper")  menu  "scraper" ".env.local";     break;;
        "MariaDB")  menu  "mariadb" ".env.local";     break;;
        "Quit" )    exit;;
    esac
done