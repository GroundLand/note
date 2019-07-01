1. 在当前目录直接运行 **echo * ** ，会打印出当前目录下的文件名(隐藏的文件不会打印)

2. regex

   - **?**  一个字符
   - ***** match 0或多个字符
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

