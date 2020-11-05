#!/bin/sh

ZIPCODE=zipcode.txt
TMP_ZIPCODE="/tmp/${ZIPCODE}"

trap "/bin/rm -f ${TMP_ZIPCODE}; exit 1" 2 3 15

cp ./${ZIPCODE} ${TMP_ZIPCODE}

#LOAD DATA INFILE '/usr/local/kebi/orion/nara/properties/database/mysql/zipcode.txt' INTO TABLE ZIPCODE FIELDS TERMINATED BY '\t';
mysql -uroot -pkebi -e "LOAD DATA INFILE '${TMP_ZIPCODE}' INTO TABLE ZIPCODE FIELDS TERMINATED BY '\t'" mail

[ -f ${TMP_ZIPCODE} ] && /bin/rm -f ${TMP_ZIPCODE}
