#!/bin/bash

# Git submodule 초기화
function init_and_update_submodules() {
  echo ">> Initialize and update submodules <<"
  git submodule init && git submodule update
}

# 각 submodule의 branch 세팅
function checkout_branch() {
  branchName=$1
  echo ">> Checkout branch to $branchName <<"
  git submodule foreach git checkout $branchName
}

# 각 submodule의 node 패키지 설치
function install_node_modules() {
  echo ">> Install node modules <<"
  git submodule foreach yarn
}

# 실행
function run_init()
{
  init_and_update_submodules # submodule 초기화 및 소스 업데이트
  checkout_branch "$1" # main 브랜치로 변경
  copy_npmrc # .npmrc 복사
  install_node_modules # node modules 설치
}

# 메뉴 출력
function menu()
{
  PS3="Please select which option > "
  COLUMNS=30
  options=("Develop branch" "Main branch" "Quit")
  select yn in "${options[@]}"; do
      case $yn in
          "Develop branch" )  run_init develop; break;;
          "Main branch" )     run_init main;    break;;
          "Quit" )            exit;;
      esac
  done
}

menu