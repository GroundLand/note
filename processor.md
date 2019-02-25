#### Mybatis开启二级缓存

```xml
<setting name="cacheEnabled"value="true"/>
```

默认一级缓存



 多个sqlsession共享一个缓存，根据namespace 区分，顺序  二级缓存-> 一级缓存 -> 数据库 

#### 分布式缓存

