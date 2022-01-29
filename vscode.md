# vscode的terminal里，conda activate 不起作用
    
原因：环境变量PATH前面加上了默认的一堆
解决方案：`shit + cmd + p` ,Preferences:Open Settings(JSON), 最后面添加```
 "terminal.integrated.env.osx":{
        "PATH": ""
    }
```