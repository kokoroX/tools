#!/bin/bash

shell_path=$(cd "$(dirname "$0")";pwd)

dirname=$shell_path"/icons"

json_file="Contents.json"

json_file_path=$shell_path/$json_file

json_target_path=$dirname/$json_file

filename_array=(
  "icon-20@2x" "icon-20@3x"
  "icon-29@2x" "icon-29@3x"
  "icon-40@2x" "icon-40@3x"
  "icon-60@2x" "icon-60@3x"
  "icon-20"
  "icon-29"
  "icon-40"
  "icon-76" "icon-76@2x"
  "icon-83.5@2x"
  "icon-1024")

size_array=(
  "40" "60"
  "58" "87"
  "80" "120"
  "120" "180"
  "20"
  "29"
  "40"
  "76" "152"
  "167"
  "1024")

generate_icon() {
  for ((i=0;i<${#size_array[@]};++i)); do

  new_file_path=$dirname"/"${filename_array[i]}".png"

  cp $input $new_file_path

  sips -Z ${size_array[i]} $new_file_path

  done
}

echo "请输入原图地址（绝对路径）："
read input
if [ -z $input ]
then
  echo "输入为空"
  exit
fi

mkdir $dirname

cp $json_file_path $json_target_path

generate_icon
