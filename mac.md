# 个性化
vim ~/.bash_profile
```
export PATH="/usr/local/opt/openssl/bin:/Users/argszero/scm/github.com/argszero/memo/bin:$PATH"
alias ls="ls -G"
alias ll="ls -Gl"
# change history size and format
export HISTIGNORE="ls:ll:cd:pwd"
export HISTFILESIZE=10000
export HISTSIZE=10000
export HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT="[$(tput setaf 6)%F %T$(tput sgr0)]: " # colorful date
```

# mac下maven配置文件目录
/usr/local/Cellar/maven/3.5.2/libexec/conf/settings.xml

# max下vscode中vim插件连续移动需要多次按键而不能按住不动的问题
```
  https://stackoverflow.com/questions/39972335/how-do-i-press-and-hold-a-key-and-have-it-repeat-in-vscode/44010683#44010683
  控制台里执行：defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool falseaaaa，然后重启vscode
  defaults write com.todesktop.230313mzl4w4u92 ApplePressAndHoldEnabled -bool false
```
# 命令行sudo 支持touch id

sudo vim /etc/pam.d/sudo
add:
auth sufficient pam_tid.so
auth  sufficient    pam_tid.so

docker run --name mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -e MYSQL_DATABASE=test -p 3306:3306 -d mysql:8

# asdf mvn不能识别 asdf的java的问题

修改/Users/argszero/.asdf/shims/mvn,添加
```
# export JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 | grep 'java.home' | awk '{print $3}')
export JAVA_HOME=$(asdf where java)
```