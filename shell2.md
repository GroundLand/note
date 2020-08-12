### 函数

1.1 创建函数：

方式一

```bash
function name {
	commands
}
```

方式二

```bash
name() {
	commands
}

```

1.2  使用函数

```bash
 ...
 func1  #使用commands命令一样
 ...
```

 函数需要先定义，再使用。且函数名是唯一的。新定义的函数会覆盖原来的定义的函数，并且脚本也不会产生任何错误信息。

1.3 函数返回值

bash shell会把函数当成一个小型脚本，运行结束时会返回一个推出状态码

- 默认推出状态码

  就是执行完函数时，可以用$?来确定函数的退出状态

- 函数输出 return 要返回的值

1.4  变量

函数接收传参，直接用$1,\$2与脚本使用参数一致，

全局变量

​     在脚本中定义的任何变量都是全局变量，在函数方法内定义的不带修饰符的也是全局变量

```bash
#!/bin/bash
# demonstrating a bad use of variables
function func1 {
    temp=$[ $value + 5 ]
    result=$[ $temp * 2 ]
}
temp=4
value=6
func1
echo "The result is $result" 9 if [ $temp -gt $value ]
then
echo "temp is larger"
else 10s
   echo "temp is smaller"
fi
```



局部变量

在函数内部使用**local** 修饰符关键字



引用函数库

shell脚本里面

```bash
. ./funcs.sh
```

命令行

1. 当在命令行上定义函数时，你必须记得在每个命令后面加个分号，这样shell就能知道在哪里 是命令的起止了

```shell
$ functiondivem{echo$[$1/$2]; } 
$ divem 100 5
20
```

2. 采用多行方式来定义函数

```shell
$ function multem { 
> echo $[ $1 * $2 ] 
> }
$ multem 2 5
10 
$
```

在命令行上创建函数要小心。因为创建的函数名与内建命令重名，函数将会覆盖原来的命令









 