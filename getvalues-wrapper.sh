#!/bin/bash

# wrapper script for easy handling of getvalues.sh inside init.d.
# in comparison to "drawdays.sh", this is not a cronjob
# because it runs every ten seconds, so cron is too slow.

echo $$ > /var/lock/getvalues
while :; do
	./getvalues.sh
	sleep 10
done
