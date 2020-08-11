1. 在当前目录直接运行 **echo * ** ，会打印出当前目录下的文件名(隐藏的文件不会打印)

2. regex

   - **?**  一个字符
   - **\*** match 0或多个字符
   - [A-z]*.class

3. Ctrl+d，不仅适用于以下的sort命令，也适用于wc等其他命令

   ```shell 
   $ sort
   Tony
   Barbara
   Harry
   Dirk
   Ctrl+d  // 终结
   ```

4. \> 和 >> 的区别

- \> 会直接替换掉原来的内容 
- \>> 会追加在原来的内容的后面eg： cat file1>>file2,两个文件合并

5. 在后台运行

   command > out &   //运行该命令之后，会打印出两个参数，第一个参数 任务命令数字 第二个是PID

6. Unix 系统从程序一般都在硬盘，只有当执行时才会进入内存中

7. sed命令

   正则表达式  */

8. 定义变量，不允许 = 两边有空格；没有数据类型之分；

9. 算数运算 $((3*4));$((8#100)) 八进制

10. grep 命令可跟单引号 grep ‘we are’ filename

11. single quotes tell the shell to ignore *all* enclosed characters, double quotes say to ignore *most*,有三个在双引号里不会被忽略的符号： ¥  ` /

12. \$0 代表运行文件的路径名eg： ./var3.sh  \$0 的值为 ./var3.sh  ；if run /home/cl/var3.sh  the result is $/home/cl/var3.sh$

13. *$#*参数的个数，*$\** 全部参数，*$$*获取当前线程，$?获取上一条命令执行的返回状态

14. 参数需要传入*"susan T"*,类似于这种匹配的，可以脚本引用参数鞋厂*"$1"*即可

15. 判断if

    ```shell
    if commandt
    then
    command
    command
    ...
    fi
    ```

    当commandt被执行完成，该命令的退出状态(_Whenever any program completes execution, it returns an exit status code to the shell_)为**零**，位于_then_和_if_中间的命令将会被执行。

16. ### test 

    - 测试两个值是否相等，*test $count = 1*,**等号两边有空格**

    - 取反，**！**

    - 与表达式：expr1 -a expr2

    - 或表达式：expr1 -o expr2

    - 判断一个变量是否为null，*test "$day"*返回true则不是null，返回false是null

      ![](/Users/cl/Pictures/testDoubleQuotes.png)

In the first case, test was not passed any arguments because the shell ate up the four spaces in

blanks. In the second case, test got one argument consisting of four space characters which is

not null.

17. 数字比较
    - int1 -eq int2 是否等于
    - int1 -ge int2 是否大于等
    - int1 -gt int2 大于
    - int1 -le int2 小于等于
    - int1 -lt int2 小于
    - int1 -ne int2 不等于

18. 文件判断操作符

    ![test](/Users/cl/Documents/note/image/FileOperator.png)

19. if else 语法

    ```shell
    if command
    then
    	command
    	command
    else
    	command
    	command
    ...
    fi
    ```

20. 退出

    exit 1   #失败退出

21. case语法结构

    如果符合其中一个分支时，则紧跟其后的命令将会被执行，**直到遇到 双分号(double semicolons)**

    ![case](https://github.com/GroundLand/note/blob/master/image/case.png?raw=true)

22. 双括号

    ![](/Users/cl/Pictures/doubleBracket.png)

Eg:

```bash
#!/bin/bash
# using double parenthesis #
val1=10
#
if (( $val1 ** 2 > 90 )) then
       (( val2 = $val1 ** 2 ))
       echo "The square of $val1 is $val2"
    fi

```



23. read从文件中读取

    ```bash
    #!/bin/bash
    # reading data from a file #
    count=1
    cat test | while read line do
       echo "Line $count: $line"
       count=$[ $count + 1]
    done
    echo "Finished processing the file"
    ```

    while循环会持续通过read命令处理文件中的行，直到read命令以非零退出状态码退出



24. 标准文件描述符

    ![](/Users/cl/Pictures/standFileDesc.png)

25. 文件信号

    ![](/Users/cl/Documents/note/image/linux_signal.png)





