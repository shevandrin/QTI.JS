#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "${script_dir}/.." && pwd)"
package_dir="${RQTI_PACKAGE_DIR:-${HOME}/q/qti}"
target_dir="${1:-${package_dir}/inst/QTIJS}"

mkdir -p "${target_dir}"

rsync -a \
  --exclude '.git/' \
  --exclude '.agents/' \
  --exclude '.codex/' \
  --exclude '.DS_Store' \
  --exclude '__MACOSX/' \
  --exclude '*.code-workspace' \
  --exclude '/scripts/' \
  "${repo_dir}/" \
  "${target_dir}/"

echo "Synced QTI.JS to ${target_dir}"

echo "Rebuilding rqti package from ${package_dir}"
R CMD INSTALL "${package_dir}"
