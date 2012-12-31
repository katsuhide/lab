#!/bin/sh
#LOG_DIR=`pwd`
LOG_DIR="/Users/AirMyac/github/lab/skype_log"
SKYPE_DIR="/Users/AirMyac/Library/Application Support/Skype/katsuhide1982/"

COMMAND="sqlite3 main.db"

if [ $# -eq 1 ]; then
	FROM_DATE=$1
else
	FROM_DATE=`cat $LOG_DIR/last_executed_time`
fi

SQL="select author, datetime(datetime(timestamp, 'unixepoch'), 'localtime'), body_xml from messages where timestamp >= strftime('%s', datetime('"$FROM_DATE"','utc'));"

cd "$SKYPE_DIR";
echo $SQL | $COMMAND > $LOG_DIR/skype_log_$FROM_DATE.txt;
echo `date '+%Y-%m-%d %H:%M:%S'` > $LOG_DIR/last_executed_time
exit;
