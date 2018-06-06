#!/bin/bash
# 文件夹内所有 jpg 文件替换成 png
# 原样保留其他文件

shell_path=$(cd "$(dirname "$0")";pwd)
default_output_path=$shell_path"/images"

handle_file() {
  suffix="jpg"
  origin_path=$1"/"${2}

  if [ ${2##*.} == $suffix ]
  then
    sips -s format png $origin_path --out ${1/$input/$output}"/"${2%%.*}.png
  else
    cp $origin_path ${1/$input/$output}"/"${2}
  fi
}

mk_folder() {
  mkdir -p ${1/$input/$output}
}

get_sub_element() {
    for element in `ls $1`
    do
        element_full_path=$1"/"$element
        if [ -d $element_full_path ]
        then
            mk_folder $element_full_path
            get_sub_element $element_full_path
        else
            handle_file $1 $element
        fi
    done
}

echo "请输入需要转换的文件夹路径（绝对路径）："
read input
if [ -z $input ]
then
  echo "输入为空"
  exit
fi

echo "请输入需要导出的文件夹路径（绝对路径）：默认" $default_output_path
read output
output=${output:-$default_output_path}

# echo $output

if [ -d $output ]
then
  echo "文件夹已存在"
  exit
fi

mkdir $output
get_sub_element $input
