#### 线程安全性

定义:*多个线程访问同一个类时，这个类始终能表现出正常的行为时，那么这个类就是线程安全的*

无状态：一个类不包括任何域，也不包括任何对其他类中域的引用(计算过程中的临时状态仅存在于线程中的局部变量中)

**无状态对象一定是线程安全的**

如何分析对象的状态，首先从对象的域开始，如果对象中所有的域都是基本类型的变量，那么这些域将构成对象的全部状态。如果对象的域引用了其他对象的域，那么对象的状态将包含被引用对象的域。



#### 锁

- 在java程序运行环境中，JVM需要对两类线程共享的数据进行协调(不是线程私有的两个内存区)： 

​        (1) 保存在堆中的实例变量       

​        (2) 保存在方法区中的类变量  

- 锁的状态：无锁状态，偏向锁状态，轻量级锁状态和重量级锁状态，它会随着竞争情况逐渐升级。锁可以升级但不能降级，意味着偏向锁升级成轻量级锁后不能降级成偏向锁。这种锁升级却不能降级的策略，目的是为了提高获得锁和释放锁的效率。

**重入内置锁**

重入：某个线程试图获得一个它本来就持有的锁，举例，子类实现了父类的sychronized方法，然后调用了父类的方法，这时内置锁不可重入，将导致死锁。PC Register会记录当前线程获取次数。

**误用引用**

```java
class UnsafeStates{
    private String[] states = new String[]{"AK","SL","LO"};
    
    public String[] getStates(){
        return states;
    }
}
```

*states这个这个变量可以被随意的更改，因为它是一个引用*

volatile类型修饰一个引用值时，其他线程会看到最新的引用地址(指出一种应用场景)。

#### 不变性

- 对象创建后状态不可修改
- 对象的所有域都是final类型
- 对象都是正确创建的（在创建对象时，this引用没有逸出）



#### 同步策略文档化

  *在文档中说明客户代码需要了解的线程安全保证性，以及代码维护人员需要了解的同步策略*

考虑的方面：

1. 那些变量声明为volatile类型，
2. 哪些变量用锁来保护
3. 哪些锁保护哪些变量
4. 哪些变量必须是不可变的或者封闭在线程中的
5. 哪些操作必须是原子操作的



#### BLOCKED,WAITING, and TIMED_WAITING 区别

共同点：

​	**都属于阻塞状态**

blocked：必须等到某个不受它控制，拿到当前锁住的对象的线程执行完成之后才能执行

waiting：是程序命名当前线程停下来，等到唤醒获得cpu执行权才能执行

timed_waiting:等特定的时间另外一个线程执行的状态(如果在指定的时间另外一个线程没有执行，自个继续执行)

具体见[链接](https://dzone.com/articles/difference-between-blocked-waiting-timed-waiting-e)





#### Lock锁

Java5中引入Lock接口，3个实现的类：ReentrantLock、ReetrantReadWriteLock.ReadLock和ReetrantReadWriteLock.WriteLock

```java
Lock lock = new ReentrantLock();
......
Lock.lock();
try{
     //更新对象的状态
     //捕获异常，必要时恢复到原来的不变约束
    //如果有return语句，放在这里
}finally{
  lock.unlock();
}
```

​       在JDK5中，synchronized性能低，吞吐量低，刮起线程和恢复线程的操作都需要转入内核态中完成的，一个重量级锁。但 在jdk1.6中，对synchronize加入了很多优化措施，有自适应自旋，锁消除，锁粗化，轻量级锁，偏向锁等。ReentrantLock使用了CAS操作。 

​        如果某一线程A正在执行锁中的代码，另一线程B正在等待获取该锁，对线程B进行中断，如果是忽略终端锁：则不理会该中断，线程B继续等待，如果是响应式中断锁，便会处理终端，B线程会放弃等待处理其他事情，ReentrantLock获得响应中断锁的一般形式如下 

```java
ReentrantLock lock = new ReentrantLock();
......
lock.lockInterruptibly();//获取响应中断锁
try {
      //更新对象的状态
      //捕获异常，必要时恢复到原来的不变约束
      //如果有return语句，放在这里
}finally{
    lock.unlock();        //锁必须在finally块中释放
}
```

