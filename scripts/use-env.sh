#!/usr/bin/env bash

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  echo "Use: source scripts/use-env.sh [path-to-env-file]" >&2
  exit 1
fi

_use_env() {
  local env_file="${1:-.env}"
  local helper_dir="${BASH_SOURCE[0]%/*}/helpers"
  local had_allexport="$-"

  if (( $# > 1 )); then
    bash "$helper_dir/warningLog.sh" "Use: source scripts/use-env.sh [path-to-env-file]" >&2
    return 1
  fi

  if [[ ! -f "$env_file" || ! -r "$env_file" ]]; then
    bash "$helper_dir/warningLog.sh" "Cannot read environment file: $env_file" >&2
    return 1
  fi

  [[ "$env_file" == */* ]] || env_file="./$env_file"
  bash "$helper_dir/runLog.sh" "Loading environment variables"
  set -a
  if source "$env_file"; then
    [[ "$had_allexport" == *a* ]] || set +a
    bash "$helper_dir/successLog.sh" "Environment variables loaded"
  else
    [[ "$had_allexport" == *a* ]] || set +a
    bash "$helper_dir/warningLog.sh" "Failed to load environment file: $env_file" >&2
    return 1
  fi
}

if _use_env "$@"; then
  unset -f _use_env
else
  unset -f _use_env
  return 1
fi
