[链接1](https://docs.oracle.com/javase/specs/jvms/se8/html/index.html)



纳入了相对于jdk7版本(写于2011)所有的变化。另外，做了许多矫正和澄清，以便于与Java虚拟机的流行实现保持一致。

这个版本继续采用定义抽象jvm的传统方式，作为具体实现的文档，充当着建造房屋时的那份蓝图(serving as documentation for a concrete implementation only as a blueprint documents a house.)，想要实现jvm必须包括这些特别的地方，但只是在某些地方受到限制而已。

Java SE的改变势必会带来JVM的改变，为了增大二者的兼容性，急切的在JVM中制定一个默认的方法，而不是依靠的编译器的魔力，因为编译器满足不了跨平台和版本升级的需求，并且相当不适合预先存在的class文件。在JSR-335协议中，Java语言中的lambda表达式，在Oracle， Dan Smith 询问怎样才是把默认的方法集成常量池和方法构造器中去的最好方法，方法和接口方法改革算法，以及指令集合。JSR 335还在类文件级别的接口中引入了私有和静态方法; 他们也已经仔细地与界面方法解析集成。

Java SE的主题与jvm一同演化，举一个有力的例子，在运行时间支持方法参数命名



### 1.1 历史

Java是一门一般用途，并发，面向对象的语言，其语法跟C和C++相似，但是没有C和C++的复杂和困惑、不安全。Java平台是为了解决消费设备在使用软件不能联网的问题，被设计成支持多个主架构以及允许软件组件之间的安全转送，为了实现这些需求，编译吗必须保存在传输网络中，操作任何一个客户端，确保客户安全运行。

万维网的流行是的这些属性变得有趣，网页浏览器使得上百万人能网上冲浪以及用简单的方式接受多媒体文件，你在看多媒体文件，不管有没有联网，至少声音和画面是同步的。

网络爱好者很快发现网络HTML文档格式支持的内容太有限了。HTML扩展（例如表单）只突出了这些限制，同时明确表示没有浏览器可以包含用户想要的所有功能。可扩展性就是答案。

HotJava浏览器第一次展示了Java编程语言和平台的有趣特性，就是可能让他嵌入到HTML页面中，程序与HTML被一同下载，在被浏览器接受前，程序会小心检查确保数据是安全的，与HTML页面一样，编译的程序与网络和主机无关。程序的行为方式相同，无论它们来自何处，或者它们被装入和运行的机器类型。包含Java平台的Web浏览器不再局限于预定的一组功能。包含动态内容的网页的访问者可以确保他们的机器不会被该内容损坏。程序员可以编写一次程序，它将在任何提供Java运行时环境的机器上运行。

#### 1.2 JVM

JVM是Java平台的基石， 负责其硬件和操作系统的独立性, 其编译的代码的小尺寸, 以及它的能力, 以保护用户免受恶意程序，这是该技术的组成部分。

Java虚拟机是一个电脑虚拟机。像一个真实的电脑，在运行期间，有指令集和许多内存操作的功能。使用虚拟机实现一门语言是很常见的，最出名的虚拟机是UCSD Pascal的P-Code机器。

Sun公司研发的JVM的第一个模型，模拟由类似于当代个人数字助理（PDA）的手持设备托管的软件中的Java虚拟机指令集， Oracle's current implementations emulate the Java Virtual Machine on mobile, desktop and server devices, but the Java Virtual Machine does not assume any particular implementation technology, host hardware, or host operating system. It is not inherently interpreted, but can just as well be implemented by compiling its instruction set to that of a silicon CPU. It may also be implemented in microcode or directly in silicon.

JVM不知道Java语言，仅知道特殊的二进制形式，class文件。一个class文件包括JVM指令已经一些特征和符号表，以及其他的辅助信息。

为了安全，JVM在代码风格上实行强制语法，结构限制。但是，任何具有可以用有效类文件表示的功能的语言都可以由Java虚拟机托管，由通用的，与机器无关的平台吸引，其他语言的实现者可以将Java虚拟机作为其语言的交付工具。



