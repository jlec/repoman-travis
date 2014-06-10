#!/bin/bash
# Small spinner script, that returns exit code of CMD and keeps colored output
# Usage: ./spinner CMD

spinner() {
	local PID=$1
	local SPIN="/-\|"
	local i=0
	while kill -0 $PID >/dev/null 2>&1; do
		printf "\r%s" "${SPIN:$i:1}"
		i=$(($i+1))
		[[ $i -eq 4 ]] && i=0
		sleep 0.25;
	done
}

$(script -q -e /dev/null -c "${@} 2>&1" >/tmp/output) &
PID=$!
spinner "${PID}" &
wait ${PID}
RC=$?
sleep 0.5
printf "\r"
cat /tmp/output
exit $RC