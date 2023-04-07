#!/bin/bash
SCRIPTDIR=`dirname $0`
SCRIPTNAME=`basename $0`
TASK_SHARED=$SCRIPTDIR/tasks/shared
TASK_LOCAL=$SCRIPTDIR/tasks/local
TASKNAME=$1

if test -f "$TASK_LOCAL/$TASKNAME.sh"; then
	TASKFILE="$TASK_LOCAL/$TASKNAME.sh"
elif test -f "$TASK_SHARED/$TASKNAME.sh"; then
	TASKFILE="$TASK_SHARED/$TASKNAME.sh"
else
	TASKFILE=""
fi

if [[ "$TASKFILE" = "" ]]; then
	echo "I can not find the task: $TASKNAME"
	exit 1
else
	echo "Start to run $TASKNAME - $TASKFILE"
	$TASKFILE apply
	xRC=$?
	if [[ $xRC -eq 0 ]]; then
		echo "### Finished - $SCRIPTNAME"
		exit 0
	else
		echo "### ERROR on something - $SCRIPTNAME"
		exit 1
	fi
fi
