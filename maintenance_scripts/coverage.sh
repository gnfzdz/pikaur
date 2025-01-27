#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ "${1:-}" == "--help" ]] ; then
	echo "Usage: $0 SUBMIT_COVERAGE WRITE_DB"
	exit 0
fi

if [[ "${2:-}" == "--write-db" ]] ; then
	export WRITE_DB=True
	export PATH="${PATH}:/usr/bin/core_perl"
	echo "PKGEXT='.pkg.tar'" >> ~/.makepkg.conf
fi

coverage run --source=pikaur -m unittest -v

if [[ "${1:-}" == "--coveralls" ]] ; then
	coveralls --service=github
else
	coverage report
	coverage html
fi
