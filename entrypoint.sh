#!/bin/bash
set -e
rm -f /test_recruitment/tmp/pids/server.pid
exec "$@"