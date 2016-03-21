YEAR=2008
while [ $YEAR -ne 2015 ]
do
more data_source.csv | grep ,$YEAR, | cut -d',' -f1 | uniq -c | grep -v "  1" | awk '{print $2}' | while read line ;do cat .data_source.csv | grep ,$YEAR, | egrep "^$line," ;done
YEAR=`expr $YEAR + 1`
done
