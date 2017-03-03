#!/bin/sh
#
# Run every snippet through varnishd

for f in $(echo v${1%%.?}/*.vcl); do
	t=$(mktemp)
	cat >$t <<_EOF
vcl 4.0;
backend default { .host = "127.0.0.1"; }
include "$(pwd)/$f";
_EOF
	varnishd -n $(pwd) -C -f $t || exit 2
done
