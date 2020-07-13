### beans

依赖注入：依赖一个bean并不是自己创建和掌管其生命周期，而是有spring创建并在依赖的地方注入其bean

_@Configuration_在Spring中表示为一个提供给Spring上下文的 一个配置类，_@Bean_表示返回的的对象必须添加到 Spring上下文的bean中(唯一表示默认为方法名)

@SpringBootApplication 是以下三个注解的复合体：

- _@SpringBootConfiguration_

- _@EnableAutoConfiguration_

- _@ComponentScan_ 


#### devtools

在JVM中，两个独立的类加载器来加载程序，一个class loader加载src/main/路径下的大部分文件，java 代码和propertise文件，另一个class loader加载一些依赖库，这部分代码不会经常被更改。

spring boot 启动命令：

```shell
mvn spring-boot:run
```

#### 关系型数据库

Spring支持 JDBC,也支持 JPA

