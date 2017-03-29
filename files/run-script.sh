if [[ -z "${SERVER_TYPE}" ]]; then
  SCRIPT_SERVER_TYPE="CACHING" # caching is default dns server configuration
else
  SCRIPT_SERVER_TYPE="${SERVER_TYPE}"
fi

if [ "$SCRIPT_SERVER_TYPE" = "AUTHORITATIVE" ]; then
  /files/authoritative-dns/bind-run.py
else
  /files/caching-dns/bind-run.py
fi
