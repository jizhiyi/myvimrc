#!/usr/bin/env bash


# 获取日期
function get_datetime()
{
    time=$(date "+%Y%m%d%H%M%S")
    echo $time
}

# 判断文件是否存在
function is_exist_file()
{
    filename=$1
    if [ -f $filename ]; then
        echo 1
    else
        echo 0
    fi
}

# 判断目录是否存在
function is_exist_dir()
{
    dir=$1
    if [ -d $dir ]; then
        echo 1
    else
        echo 0
    fi
}

#备份原有的.vimrc文件
function backup_vimrc_file()
{
    old_vimrc=$HOME"/.vimrc"
    is_exist=$(is_exist_file $old_vimrc)
    if [ $is_exist == 1 ]; then
        time=$(get_datetime)
        backup_vimrc=$old_vimrc"_bak_"$time
        read -p "Find "$old_vimrc" already exists,backup "$old_vimrc" to "$backup_vimrc"? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            cp $old_vimrc $backup_vimrc
        fi
    fi
}

#备份原有的.vimrc.custom.plugins文件
function backup_vimrc_custom_plugins_file()
{
    old_vimrc_plugins=$HOME"/.vimrc.custom.plugins"
    is_exist=$(is_exist_file $old_vimrc_plugins)
    if [ $is_exist == 1 ]; then
        time=$(get_datetime)
        backup_vimrc_plugins=$old_vimrc_plugins"_bak_"$time
        read -p "Find "$old_vimrc_plugins" already exists,backup "$old_vimrc_plugins" to "$backup_vimrc_plugins"? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            cp $old_vimrc_plugins $backup_vimrc_plugins
        fi
    fi
}

#备份原有的.vimrc.custom.config文件
function backup_vimrc_custom_config_file()
{
    old_vimrc_config=$HOME"/.vimrc.custom.config"
    is_exist=$(is_exist_file $old_vimrc_config)
    if [ $is_exist == 1 ]; then
        time=$(get_datetime)
        backup_vimrc_config=$old_vimrc_config"_bak_"$time
        read -p "Find "$old_vimrc_config" already exists,backup "$old_vimrc_config" to "$backup_vimrc_config"? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            cp $old_vimrc_config $backup_vimrc_config
        fi
    fi
}

#备份原有的.vim目录
function backup_vim_dir()
{
    old_vim=$HOME"/.vim"
    is_exist=$(is_exist_dir $old_vim)
    if [ $is_exist == 1 ]; then
        time=$(get_datetime)
        backup_vim=$old_vim"_bak_"$time
        read -p "Find "$old_vim" already exists,backup "$old_vim" to "$backup_vim"? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            cp -R $old_vim $backup_vim
        fi
    fi
}

# 备份原有的.vimrc和.vim
function backup_vimrc_and_vim()
{
    backup_vimrc_file
    backup_vimrc_custom_plugins_file
    backup_vimrc_custom_config_file
    backup_vim_dir
}

# 拷贝文件
function copy_files()
{
    rm -rf ~/.vimrc
    ln -s ${PWD}/.vimrc ~

    rm -rf ~/.vimrc.custom.plugins
    ln -s ${PWD}/.vimrc.custom.plugins ~

    rm -rf ~/.vimrc.custom.config
    ln -s ${PWD}/.vimrc.custom.config ~

    mkdir -p ~/.vim
    rm -rf ~/.vim/colors
    ln -s ${PWD}/colors ~/.vim/colors
    rm -rf ~/.vim/autoload
    ln -s ${PWD}/autoload ~/.vim/autoload

    mkdir -p ~/.config/clangd
    ln -s ${PWD}/clangd/config.yaml ~/.config/clangd
}


backup_vimrc_and_vim
copy_files

