#!/bin/sh
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOCAL_MVN="$PROJECT_DIR/.tools/apache-maven-3.9.9/bin/mvn"

if [ -f "$LOCAL_MVN" ]; then
    chmod +x "$LOCAL_MVN"
    exec "$LOCAL_MVN" "$@"
else
    exec mvn "$@"
fi
