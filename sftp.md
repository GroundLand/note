### SFTP

FTP : File Transfer Protocol，SFTP 使用ssh协议去认证和建立连接。可以添加对方给的公钥，来认证

命令：

1.建立连接

```shell
$ sftp username@serverIp
```

2.获取文件

```shell
$ get remoteFile
$ get -r remoteDirectory  #获取文件夹
```

3.传输文件

```shell
$ put localFile
$ put -r localDirectory #传输文件夹
```

4.退出

```shell
$ exit
```

