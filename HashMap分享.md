## HashMap分享

#### 1. 一些概念

```java
final float loadFactor;  //负载因子
transient int size;      //这个HashMap中总共有多少个键值对
transient int modCount;  //对该HashMap修改的次数
int threshold;           //真实容量
```

- 影响HashMap性能的两个参数：初始化容量大小和负载因子(权衡时间和空间消费)

-  真实容量=初始化容量大小*负载因子

#### 2. 初始化(构造函数)

列举其中的两种

```java
//只是初始化负载因子，数组初始化在resize()方法 
public HashMap() {
        this.loadFactor = DEFAULT_LOAD_FACTOR; 
 }

//可以初始化容量大小，和负载因子
public HashMap(int initialCapacity, float loadFactor) {
        if (initialCapacity < 0)
            throw new IllegalArgumentException("Illegal initial capacity: " +
                                               initialCapacity);
        if (initialCapacity > MAXIMUM_CAPACITY)
            initialCapacity = MAXIMUM_CAPACITY;
        if (loadFactor <= 0 || Float.isNaN(loadFactor))
            throw new IllegalArgumentException("Illegal load factor: " +
                                               loadFactor);
        this.loadFactor = loadFactor;
        this.threshold = tableSizeFor(initialCapacity);  //经过该函数计算之后的值是2的倍数
    }

```

```java
 	/**
     * 将会返回是2的倍数的数值，例如传参为9，则出参为16
     */
    static final int tableSizeFor(int cap) {
        int n = cap - 1;
        n |= n >>> 1;
        n |= n >>> 2;
        n |= n >>> 4;
        n |= n >>> 8;
        n |= n >>> 16;
        return (n < 0) ? 1 : (n >= MAXIMUM_CAPACITY) ? MAXIMUM_CAPACITY : n + 1;
    }
```



#### 3.put()方法

- 获取数组index的计算：_(n - 1) & hash_ 即对数组length长度取模(&比%更高效率)
- 1.8中，当链表长度大于8时，会将链表长度换成红黑树(平衡二叉树)，方便高效查找。

```java
   public V put(K key, V value) {
        return putVal(hash(key), key, value, false, true);
    }
   /**
     *
     * @param hash hash for key
     * @param key the key
     * @param value the value to put
     * @param onlyIfAbsent 如果为true，将不会更改原来的值
     * @param evict if false, the table is in creation mode.
     * @return previous value, or null if none
     */
    final V putVal(int hash, K key, V value, boolean onlyIfAbsent,
                   boolean evict) {
        Node<K,V>[] tab; Node<K,V> p; int n, i;
        //初始化表
        if ((tab = table) == null || (n = tab.length) == 0)
            n = (tab = resize()).length;
        //如果hash取模计算之后的Node为null
        if ((p = tab[i = (n - 1) & hash]) == null)
            tab[i] = newNode(hash, key, value, null);
        //如果hash取模计算之后的Node不为null
        else {
            Node<K,V> e; K k;
            //将tab[i]也就是节点p的hash值,key值与新增的hash值，key值进行比较
            //如果相等，获取该节点
            if (p.hash == hash &&
                ((k = p.key) == key || (key != null && key.equals(k))))
                e = p;
            //如果是红黑二叉树，则进行对应的红黑二叉树插入计算
            else if (p instanceof TreeNode)
                e = ((TreeNode<K,V>)p).putTreeVal(this, tab, hash, key, value);
            else {
                //如果不是tab[i]所在位置的第一个节点，遍历
                for (int binCount = 0; ; ++binCount) {
                    if ((e = p.next) == null) {
                        //在结尾追加新节点
                        p.next = newNode(hash, key, value, null);
                        //当节点数量大于8时，转换成红黑树
                        if (binCount >= TREEIFY_THRESHOLD - 1) // -1 for 1st
                            treeifyBin(tab, hash);
                        break;
                    }
                    if (e.hash == hash &&
                        ((k = e.key) == key || (key != null && key.equals(k))))
                        break;
                    p = e;
                }
            }
            if (e != null) { // existing mapping for key
                V oldValue = e.value;
                //如果onlyIfAbsent为true且原来的值为null时，也会替换掉原来的值
                if (!onlyIfAbsent || oldValue == null)
                    e.value = value;
                //给LinkedHashMap用的
                afterNodeAccess(e);
                return oldValue;
            }
        }
        ++modCount;
        //判断是否大于真实容量大小(初始化容量大小*负载因子) 
        if (++size > threshold)
            resize();
        //给LinkedHashMap用的
        afterNodeInsertion(evict);
        return null;
    }
```



#### 4.hash()方法

- 获取key的hash值，hashCode()返回类型的是int，int是32位的，_h>>>16即取得h的高16位，再与上h的低16位，这样做的目的是为了table在length很小时，也能让高低都参与到hash的计算中(put方法有写明)

```java
 static final int hash(Object key) {
        int h;
        return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
    }
```

#### 5.get()方法

```java
public V get(Object key) {
        Node<K,V> e;
        return (e = getNode(hash(key), key)) == null ? null : e.value;
    }

 final Node<K,V> getNode(int hash, Object key) {
        Node<K,V>[] tab; Node<K,V> first, e; int n; K k;
        if ((tab = table) != null && (n = tab.length) > 0 &&
            (first = tab[(n - 1) & hash]) != null) {  //根据hash值取模计算出数组索引值
            if (first.hash == hash && // 总是检查第一个
                ((k = first.key) == key || (key != null && key.equals(k))))
                return first;
            if ((e = first.next) != null) {
                if (first instanceof TreeNode)    //是否为红黑树，
                    return ((TreeNode<K,V>)first).getTreeNode(hash, key);
                do {
                    if (e.hash == hash &&
                        ((k = e.key) == key || (key != null && key.equals(k))))
                        return e;
                } while ((e = e.next) != null);
            }
        }
        return null;
    }
```

#### 6. resize()方法（扩容）

- 数组大小超过最大值，则不会扩容，直接返回原数组
- 扩容是将原来的大小乘以2，真实容量也是乘以2

```java
 final Node<K,V>[] resize() {
        Node<K,V>[] oldTab = table;
        int oldCap = (oldTab == null) ? 0 : oldTab.length;
        int oldThr = threshold;
        int newCap, newThr = 0;
        //如果容器不为空
        if (oldCap > 0) {
            if (oldCap >= MAXIMUM_CAPACITY) {
                threshold = Integer.MAX_VALUE;
                return oldTab;
            }
            else if ((newCap = oldCap << 1) < MAXIMUM_CAPACITY &&
                     oldCap >= DEFAULT_INITIAL_CAPACITY)
                newThr = oldThr << 1; // double threshold
        }
        else if (oldThr > 0) 
            newCap = oldThr;
        else {               // 数组初始化
            newCap = DEFAULT_INITIAL_CAPACITY;
            newThr = (int)(DEFAULT_LOAD_FACTOR * DEFAULT_INITIAL_CAPACITY);
        }
        if (newThr == 0) {
            float ft = (float)newCap * loadFactor;
            newThr = (newCap < MAXIMUM_CAPACITY && ft < (float)MAXIMUM_CAPACITY ?
                      (int)ft : Integer.MAX_VALUE);
        }
        //给全局真实容量赋值
        threshold = newThr;
        @SuppressWarnings({"rawtypes","unchecked"})
            Node<K,V>[] newTab = (Node<K,V>[])new Node[newCap];
        table = newTab;
        if (oldTab != null) {
            for (int j = 0; j < oldCap; ++j) {
                Node<K,V> e;
                if ((e = oldTab[j]) != null) {   //赋值并判断
                    oldTab[j] = null;
                    if (e.next == null)
                        newTab[e.hash & (newCap - 1)] = e;
                    else if (e instanceof TreeNode)  //如果是红黑二叉树
                        ((TreeNode<K,V>)e).split(this, newTab, j, oldCap);
                    else { // preserve order
                        Node<K,V> loHead = null, loTail = null;
                        Node<K,V> hiHead = null, hiTail = null;
                        Node<K,V> next;
                        do {
                            next = e.next;
                            //判断hash值对应的二进制位置上是不是0,如果是0保持不变，是1需要换位
                            if ((e.hash & oldCap) == 0) {  
                                if (loTail == null)
                                    loHead = e;
                                else
                                    loTail.next = e;
                                loTail = e;
                            }
                            else {
                                if (hiTail == null)
                                    hiHead = e;
                                else
                                    hiTail.next = e;
                                hiTail = e;
                            }
                        } while ((e = next) != null);
                        //如果hash值对应的二进制位值是1，则位置不变，如果是0则位置加上原来的容量
                        if (loTail != null) {
                            loTail.next = null;
                            newTab[j] = loHead;
                        }
                        if (hiTail != null) {
                            hiTail.next = null;
                            newTab[j + oldCap] = hiHead;
                        }
                    }
                }
            }
        }
        return newTab;
    }

```

关于搬迁的下标变动，根据hash()方法计算出字符串ss的hash值，对hash值取模，计算出数组下标位置，第5位上是0，所以扩大数组大小之后，下标位置依然保持不变，但弟6位是1，所以再次扩大数组大小之后，位置加上原来数组的大小32，即下标变为42。

```java
		String ss = "ss";
        int hash = System.identityHashCode(ss) ^ System.identityHashCode(ss) >>> 16;

        System.out.println(hash);
        System.out.println(hash & 15);
        System.out.println(hash & 31);
        System.out.println(hash & 63);


        System.out.println(Integer.toBinaryString(hash));
        System.out.println(Integer.toBinaryString(hash & 15));
        System.out.println(Integer.toBinaryString(hash & 31));
        System.out.println(Integer.toBinaryString(hash & 63));
```

![image-20190131112644491](/Users/cl/Library/Application Support/typora-user-images/image-20190131112644491.png)

#### 7.remove()方法

- 删除节点的方法

```java
/**
     * Implements Map.remove and related methods
     *
     * @param hash hash for key
     * @param key the key
     * @param value the value to match if matchValue, else ignored
     * @param matchValue if true only remove if value is equal
     * @param movable if false do not move other nodes while removing
     * @return the node, or null if none
     */
    final Node<K,V> removeNode(int hash, Object key, Object value,
                               boolean matchValue, boolean movable) {
        Node<K,V>[] tab; Node<K,V> p; int n, index;
        //查找该元素
        if ((tab = table) != null && (n = tab.length) > 0 &&
            (p = tab[index = (n - 1) & hash]) != null) {
            Node<K,V> node = null, e; K k; V v;
            if (p.hash == hash &&
                ((k = p.key) == key || (key != null && key.equals(k))))
                node = p;
            else if ((e = p.next) != null) {
                if (p instanceof TreeNode)
                    node = ((TreeNode<K,V>)p).getTreeNode(hash, key);
                else {
                    do {
                        if (e.hash == hash &&
                            ((k = e.key) == key ||
                             (key != null && key.equals(k)))) {
                            node = e;
                            break;
                        }
                        p = e;
                    } while ((e = e.next) != null);
                }
            }
            //找到之后删除
            if (node != null && (!matchValue || (v = node.value) == value ||
                                 (value != null && value.equals(v)))) {
                if (node instanceof TreeNode)
                    ((TreeNode<K,V>)node).removeTreeNode(this, tab, movable);
                else if (node == p)
                    tab[index] = node.next;
                else
                    p.next = node.next;
                ++modCount;  //记录修改次数，防并发
                --size;  //并不是数组大小，而是多少个键值对
                afterNodeRemoval(node);
                return node;
            }
        }
        return null;
    }
```

#### 8. 面试题

(1) HashMap的长度为什么是2的幂次方？

- 方便扩容，直接左移一位
- len-1与Hash值取模，获取数组下标值





