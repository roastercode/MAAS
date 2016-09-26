#!/bin/bash

echo "
######################################################################
# TEST: hostfile
# $Id: 11_hostfile.sh,v 1.2 2005-09-12 22:22:15 doughnut Exp $
######################################################################
"

CMD="mussh -U -t 10 -d -H $(dirname $0)/testhosts.list -c 'date'"

echo "COMMAND: $CMD"
$CMD

RETVAL=$?
if [ "$RETVAL" -eq 0 ] ; then
	echo "PASSED"
else
	echo "FAILED (returned $RETVAL)"
	echo "Hit any key to continue"
	read
fi
exit $RETVAL
