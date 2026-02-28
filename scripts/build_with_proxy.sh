#!/usr/bin/env bash
set -euo pipefail

# Usage examples:
#   HTTP_PROXY_HOST=proxy.mycorp.local HTTP_PROXY_PORT=8080 ./scripts/build_with_proxy.sh
#   HTTPS_PROXY_HOST=proxy.mycorp.local HTTPS_PROXY_PORT=8080 ./scripts/build_with_proxy.sh :app:assembleRelease
#   GRADLE_ZIP_FILE=/absolute/path/gradle-8.13-bin.zip ./scripts/build_with_proxy.sh

TASK="${1:-:app:assembleDebug}"

if [[ -n "${GRADLE_ZIP_FILE:-}" ]]; then
  if [[ ! -f "$GRADLE_ZIP_FILE" ]]; then
    echo "[ERROR] GRADLE_ZIP_FILE not found: $GRADLE_ZIP_FILE" >&2
    exit 1
  fi
  esc_path=$(python - <<'PY'
import os,sys
p=os.path.abspath(os.environ['GRADLE_ZIP_FILE']).replace('\\','/')
print(f"file://{p}")
PY
)
  sed -i "s#^distributionUrl=.*#distributionUrl=${esc_path}#" gradle/wrapper/gradle-wrapper.properties
  echo "[INFO] Using offline Gradle distribution: ${esc_path}"
fi

GRADLE_FLAGS=()

if [[ -n "${HTTP_PROXY_HOST:-}" ]]; then
  GRADLE_FLAGS+=("-Dhttp.proxyHost=${HTTP_PROXY_HOST}")
fi
if [[ -n "${HTTP_PROXY_PORT:-}" ]]; then
  GRADLE_FLAGS+=("-Dhttp.proxyPort=${HTTP_PROXY_PORT}")
fi
if [[ -n "${HTTPS_PROXY_HOST:-}" ]]; then
  GRADLE_FLAGS+=("-Dhttps.proxyHost=${HTTPS_PROXY_HOST}")
fi
if [[ -n "${HTTPS_PROXY_PORT:-}" ]]; then
  GRADLE_FLAGS+=("-Dhttps.proxyPort=${HTTPS_PROXY_PORT}")
fi
if [[ -n "${PROXY_USER:-}" ]]; then
  GRADLE_FLAGS+=("-Dhttp.proxyUser=${PROXY_USER}" "-Dhttps.proxyUser=${PROXY_USER}")
fi
if [[ -n "${PROXY_PASSWORD:-}" ]]; then
  GRADLE_FLAGS+=("-Dhttp.proxyPassword=${PROXY_PASSWORD}" "-Dhttps.proxyPassword=${PROXY_PASSWORD}")
fi
if [[ -n "${NON_PROXY_HOSTS:-}" ]]; then
  GRADLE_FLAGS+=("-Dhttp.nonProxyHosts=${NON_PROXY_HOSTS}")
fi

echo "[INFO] Running task: ${TASK}"
./gradlew "${TASK}" --stacktrace "${GRADLE_FLAGS[@]}"
