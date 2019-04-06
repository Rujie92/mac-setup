#! /bin/bash

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

install() {
    mas install 409201541 409203825 409183694
}

# 程序入口
echo
echo "🙏  请花2秒时间看一下上述注意事项"
sleep 2s

install_tools()

install()

