
#!/bin/bash  
today=`date +%Y%m%d`

startdatesecond=$(date -jf%Y%m%d $today +%s)
yesterday=$startdatesecond

for ((sdate=0;sdate<100;sdate++)) 
do 
	yesterday=$[$yesterday - 1 * 24 * 60 *60]
	if [ `date -r $yesterday +%Y%m%d` == 20191121 ]
	then
		break
	fi
        echo `date -r $yesterday +%Y%m%d` 
done