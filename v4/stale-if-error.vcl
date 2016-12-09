sub try_stale_if_error {
	if (obj.ttl < 0s && obj.ttl + obj.grace > 0s) {
		if (req.restarts == 0) {
			set req.http.sie-enabled = true;
			return (fetch);
		} else {
			set req.http.sie-abandon = true;
			return (deliver);
		}
	}
}

sub vcl_backend_fetch {
	if (bereq.http.sie-abandon) {
		return (abandon);
	}
}

sub vcl_backend_response {
	if (beresp.status > 400 && bereq.http.sie-enabled) {
		return (abandon);
	}
}

sub vcl_backend_error {
	if (bereq.http.sie-enabled) {
		return (abandon);
	}
}

sub vcl_synth {
	if (resp.status == 503 && req.http.sie-enabled) {
		unset req.http.sie-enabled;
		return (restart);
	}
}

sub vcl_hit {
	call try_stale_if_error;
}
