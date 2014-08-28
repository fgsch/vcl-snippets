# Remove everything but the first ip address from X-Forwarded-For.
# This normally means removing the Varnish ip address.
sub vcl_recv {
	set req.http.X-Forwarded-For =
	    regsub(req.http.X-Forwarded-For, ",.*", "");
}
