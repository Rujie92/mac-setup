#! /bin/bash
# 全局变量
row_number=0
column_number=0
type=cli
WD=`pwd`

# 安装Homebrew并换TUNA源
install_homebrew() {
  if `command -v brew > /dev/null 2>&1`; then
    echo '👌  Homebrew已安装'
  else
    echo '🍼  正在安装Homebrew'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [[ $? -eq 0  ]]; then
      echo '🍻  Homebrew安装成功'
    else
      echo '🚫  Homebrew安装失败，请检查网络连接...'
      exit 127
    fi
  fi
}

install_mas() {
    if `command -v mas > /dev/null 2>&1`; then
        echo '👌  mas已安装'
    else
        echo '🍼  正在安装mas'

        brew install mas

        if [[ $? -eq 0  ]]; then
            echo '🍻  mas安装成功'
        else
            echo '🚫  mas安装失败，请检查网络连接...'
        exit 127
        fi
    fi
}

install_tools() {
    install_homebrew()
    install_mas()
}

# 检查是否已安装某软件包
check_installation() {
  if [[ $type == "cli" ]]; then
    brew list -l | grep $1 > /dev/null
  else
    brew cask list -1 | grep $1 > /dev/null
  fi

  if [[ $? -eq 0 ]]; then
     return 0
  fi

  return 1
}

# 使用brew安装软件包
install() {
  check_installation $1
  if [[ $? -eq 0 ]]; then
    echo "👌 ==>已安装" $1 "，跳过..."
  else
    echo "🔥 ==>正在安装 " $1
    if [[ "$type" == "cli" ]]; then
      brew install $1 > /dev/null
      echo $?
    else
      brew cask install $1 > /dev/null
    fi

    if [[ $? -eq 0 ]]; then
      echo "🍺 ==>安装成功 " $1
    else
      echo "🚫 ==>安装失败 " $1
    fi
  fi
}

# 显示菜单
show_menu() {
  echo
  read  -p "✨ 请选择要显示的软件包菜单列表类型 [0]命令行 [1]图形化(默认)：" ans
  echo

  case $ans in
    0) cd $WD && cat cli.txt && type="cli"
    ;;
    1) cd $WD && cat gui.txt && type="gui"
    ;;
    *) cd $WD && cat gui.txt && type="gui"
    ;;
  esac

  echo
}

# 检查AWK是否可用
check_awk() {
  if ! `command -v awk > /dev/null`; then
    echo 未检测到AWK，请先安装AWK再执行本程序...
    exit 127
  fi
}

# 利用awk，从cli.txt gui.txt两文件中截取软件包名称
get_package_name() {
  local file_name=$1
  local row=$2
  local col=$3
  awk -v line=$row -v field=$col '{if(NR==line){print $field}}' $file_name
}

# 计算与软件名称编号对应的行和列号码
# 不要破坏cli.txt gui.txt文件排版
# 否则会导致计算行列值失败，进而无法提取出正确的软件包名称
locate() {
  local tmp=`expr $1 + 2`
  row_number=`expr $tmp \/ 3`
  tmp=`expr $1 % 3`
  [ $tmp -eq 0 ] && tmp=3
  column_number=`expr $tmp \* 3 - 1`
}

mas_install() {
    mas install 409201541 409203825 409183694
}

# 程序入口
echo
echo "🙏  请花2秒时间看一下上述注意事项"
sleep 2s

install_tools()

install_softwares()

