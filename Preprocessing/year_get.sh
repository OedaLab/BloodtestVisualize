#!/bin/sh

if [ $# -ne 1 ];then
    exit 1
fi

if [ -f .data2.csv ];then
rm .data2.csv
touch .data2.csv
fi

DATA_SET="data.om.csv"
MAX=7
COU=$1
PRIN=`expr $COU - 1`

while [ $COU -le $MAX ]
do
echo `expr $MAX - $COU`
cat $DATA_SET | grep -v 判定不能 | gsed -e "s@,@ @g" | awk '{print $1}' | uniq -c | egrep "  $COU" | gsed -e "s@^  @@g" | awk '{print $2}'\
| while read line; do cat $DATA_SET | grep -v 判定不能 | egrep "^$line," ;done\
| gsed -n 1~$COU,+`expr $PRIN + 0`p >> .data2.csv
COU=`expr $COU + 1`
done

cat $DATA_SET | head -1 > .header.csv
cat .header.csv .data2.csv > .data.csv

#echo "training_test step"
cat .data2.csv | gsed -n 1~$1,+`expr $1 - 2`p  > .training_data2.csv
cat .data2.csv | gsed -n 1~$1,+`expr $1 - 2`!p > .test_data2.csv

cat .header.csv .training_data2.csv > .training_data.csv
cat .header.csv .test_data2.csv > .test_data.csv

#rm .data2.csv .training_data2.csv .test_data2.csv

echo "finish"
