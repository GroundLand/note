ConcurrentHashMap(jdk1.8)

#### 1.前言

- 为了兼容老版本，segment依然保留
- key和value都不能为空
- 底层与jdk1.8的HashMap一样，采取“数组+链表+红黑树”的结构,不是TreeNode，而是TreeBin对象，里面有线程一些操作
- 再更新时借用了CAS算法，在hash值相同的链表的头节点使用synchronized锁

#### 2 .CAS锁







JNI (Java Native Interface)