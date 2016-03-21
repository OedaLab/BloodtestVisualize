#!/bin/sh
#下から15行は不要
#体重532kgは53.2kgのうち間違えかも

more data_source.csv | head -`expr 69627 - 15` | sed -e "s@532\.8@53.2@g" > .data_temp.csv

uniqw .data_temp.csv 10 > data.csv
rm .data_temp.csv