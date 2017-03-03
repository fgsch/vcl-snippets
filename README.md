vcl-snippets
============

[![Build Status](https://travis-ci.org/fgsch/vcl-snippets.svg?branch=master)](https://travis-ci.org/fgsch/vcl-snippets)

A series of snippets for Varnish Cache divided by major version.

How to use
----------

Download the file with the required functionality and include it in the configuration using:

```
include "<path/to/file>";
```

Alternatively copy and paste the code into the configuration.

Please note that Varnish will concatenate the subroutines as they appear in the file so the order *does* matter.
