#!/bin/sh -x

# 얻어 오는 형식을  영문 형식으로 통일
LANG=C;export LANG
LC_CTYPE=C;export LC_CTYPE
LC_NUMERIC=C;export LC_NUMERIC
LC_TIME=C;export LC_TIME
LC_COLLATE=C;export LC_COLLATE
LC_MONETARY=C;export LC_MONETARY
LC_MESSAGES=C;export LC_MESSAGES
LC_ALL=C;export LC_ALL

# 현재 OS 형식을 얻어냄
COS=`uname -s`

OS=`echo "${COS}" | awk '{
        os = tolower($0);
        if (os ~ /linux/) {
                printf("linux\n");
        }
        else if (os ~ /[Ss]un[Oo][Ss]/) {
                printf("solaris\n");
        }
        else if (os ~ /solaris/) {
                printf("solaris\n");
        }
        else if (os ~ /hp-ux/) {
                printf("hp-ux\n");
        }
        else if (os ~ /aix/) {
                printf("aix\n");
        }
}'`


case "$1" in
uptime)
        # 서버 가동 시간
        uptime | sed 's/,//g' | awk '{
        if (NF == 12 || NF == 13) {
                printf "%s %s\n", $3, $5;
        }
        else if (NF == 10) {
                printf "0 %s\n", $3;
        }
}'
;;
load)
        # 서버 부하
#w | awk '{ if (NR == 1) print $11 $12 $13 }'
uptime | awk '{print $(NF-2),$(NF-1),$NF }'
;;

df)
        # os별 서버 파티션의 정보 출력
#FILESYSTEM,1k-blocks,Used,Available,Use%,MountPoint
        case "${OS}" in
        linux|solaris)
                df -kP |\
                awk '{
                        if (NR != 1) {
                                print $1 "," $2 "," $3 "," $4 "," $5 "," $6
                        }
                }'
        ;;
        hp-ux)
                df -k |\
                awk '{
                        if ((NR % 4) == 1) {
                                mount = $1;
                                device = $2;
                                sub(/^\(/, "", device);
                                total = $5;
                        }
                        else if ((NR % 4) == 2) {
                                free = $1;
                        }
                        else if ((NR % 4) == 3) {
                                used = $1;
                        }
                        else if ((NR % 4) == 0) {
                                percent = $1;
                                printf("%s,%s,%s,%s,%s,%s\n", device, total, used, free, percent, mount);
                        }
}'
        ;;
        aix)
                df -k |\
                awk '{
                        if (NR != 1) {
                                device = $1;
                                total = $2;
                                free = $3;
                                used = "-";
                                percent = $4;
                                mount = $7;

                                if (free > 0) {
                                        used = total - free;
                                }

                                printf("%s,%s,%s,%s,%s,%s\n", device, total, used, free, percent, mount);
                        }
}'
        ;;
        esac
;;

esac


