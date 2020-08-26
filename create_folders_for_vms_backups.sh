#!/bin/bash
get_hostname () {
if [ $type = 'lxc' ]
then
  cat $conff| grep -e '^hostname:' | awk '{print $2}'
else
  cat $conff| grep -e '^name:' | awk '{print $2}'
fi
}

get_config_list () {
for entry in "$search_dir"/*
do
#  echo "$entry"
  conf_file=`echo $entry | rev | cut -d'/' -f1 | rev |  cut -d'.' -f1 `
  conff=$entry
  folder=$conf_file"__"$type"__$(get_hostname)"
  echo $folder
  mkdir -p $target_folder/$folder
done
}


target_folder=/opt/2RESERV
type="lxc"
search_dir=/etc/pve/lxc
get_config_list

type="vms"
search_dir=/etc/pve/qemu-server
get_config_list
