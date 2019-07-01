公用的方法

```java
//交换数组两个位置的值
private void exch(Comparable[] a,int i,int j){
  Comparable temp = a[i];
  a[i] = a[j];
  a[j] = temp;
}
```



```java
private boolean less(Comparable a,Comparable b){
  return a.compareTo(b)<0;
}
```



# 选择排序(Selection Sort)

算法4 [2.1节](https://algs4.cs.princeton.edu/21elementary/)最简单的排序法，运行时间与输入无关，意思就是就算是一个已经排好序的数组和随机数组花的时间是一样的

```java
public class Selection{
   public static void sort(int[] array){
        int N=array.length;
        for(int i=0;i<N-1;i++){
            //最小值
            int min = i;
            for(int j=i+1;j<N;j++){
                if(array[i]>array[j]) min=j;
                //交换
                change(array,i,min);
            }
        }
    }

    /**
     * 交换
     * @param arr
     * @param i
     * @param j
     */
    private static void exch(int[] arr,int i,int j){
        int temp = arr[j];
        arr[j] = arr[i];
        arr[i] = temp;
    }
}
```



# 插入排序(Insertion sort)

选择排序对非随机数组和随机数组所用时间是一样的，而插入排序解决就是这个问题，以下是其实现，可以看到如果索引左边都是有序的，那么排序时间将比选择排序快，那么运行时间将可能是线性的。

```java
public class Insertion
  {
     public static void sort(Comparable[] a)
     {  
        int N = a.length;
        for (int i = 1; i < N; i++)
        {  // Insert a[i] among a[i-1], a[i-2], a[i-3]... ..
           for (int j = i; j > 0 && a[j]<a[j-1]; j--)
              exch(a, j, j-1); //方法见上面
        } 
     } 
}
```



# 希尔排序(Shell Sort)

希尔排序使数组中任意间隔为h的元素都是有序的，是为了加速度的简单滴改进了插入排序(如果最小的元素正好在数组的尽头，用插入排序就需要N-1次移动)，交换不相邻的元素以对数组的局部进行排序。

```java
 public class Shell
  {
     public static void sort(Comparable[] a)
     {  // Sort a[] into increasing order.
        int N = a.length;
        int h = 1;
        while (h < N/3) h = 3*h + 1; // 1, 4, 13, 40, 121, 364, 1093, ...
        while (h >= 1)
        {  // h-sort the array.
           for (int i = h; i < N; i++)
           {  // Insert a[i] among a[i-h], a[i-2*h], a[i-3*h]... .
              for (int j = i; j >= h && less(a[j], a[j-h]); j -= h)
                 exch(a, j, j-h);
						}
						h = h/3; }
				}
}

```

# 归并排序

**原地归并的抽象方法**

```java
public class Merge{
  private static Comparable[] aux;
  
  public static void sort(Comparable[] a){
    aux = new Comparable[a.length];
    sort(a,0,a.length-1);
  }
  
  private static void sort(Comparable[] a,int lo,int hi){
    if(l0<=hi)return;
    int mid= lo +(hi-lo)/2;
    //分成两半排序
    sort(a,lo,mid);
    sort(a,mid,hi);
    //归并
    merge(a,lo,mid,hi);
  }
  
  private static void merge(Comparable[] a,int lo,int mid, int hi){
    int i=lo,j=mid+1;
    
    for(int k=lo;k<hi;k++){
      aux[k] = a[k];
    }
    
    for(int k=lo;k<hi;k++){
      if(i>mid) a[k]=aux[j++];
      else if(j>hi) a[k]=aux[i++];
      else if(less(aux[i],aux[j])) a[k] = aux[i++];
      else a[k]=aux[j++];
    }
    
  }
}

```



# 快速排序(Quick Sort)



```java
public class Quick{
  public static void sort(Comparable[] a){
        sort(a, 0, a.length - 1);
  }
    
  private static void sort(Comparable[] a, int lo, int hi){
    if (hi <= lo) return;
    int j = partition(a, lo, hi);  
    sort(a, lo, j-1);              // 左边排序
    sort(a, j+1, hi);              // 右边排序
	 }
  
  private static int partition(Comparable[] a, int lo, int hi){  
    
    int i = lo, j = hi+1;           
    Comparable v = a[lo];            
    while (true)
    {  //找到左边大于指定的值和右边小于指定的值，进行交换
      while (less(a[++i], v)) if (i == hi) break;
      while (less(v, a[--j])) if (j == lo) break;
      if (i >= j) break;
      exch(a, i, j);
    }
  }
  exch(a, lo, j);
  return j;
}
}
```





# 堆排序

[链接](https://algs4.cs.princeton.edu/24pq/)