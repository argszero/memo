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
