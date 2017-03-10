#!/bin/sh
#
# Run every snippet through varnishd

t=$(mktemp)
trap 'rm -f $t' 0
for f in $(echo v${1%%.?}/*.vcl); do
	cat >$t <<_EOF
vcl 4.0;
backend default { .host = "127.0.0.1"; }
include "$(pwd)/$f";
_EOF
	echo -n "Snippet $f "
	varnishd -n $(pwd) -C -f $t 2>/dev/null
	if [ $? -eq 0 ]; then
		echo "passed"
	else
		echo "FAILED"
		status=2
	fi
done
exit $status
