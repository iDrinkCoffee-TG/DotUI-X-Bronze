#!/bin/bash

echo "#### :rocket: $DOT_RELEASE_NAME :rocket:"
commit=$(git rev-parse HEAD)
echo "Commit: [${commit:0:8}]($(git config --get remote.origin.url | sed -e 's/\/$\|\.git$//g')/commit/$commit)"
echo "Date: $(date "+%Y-%m-%d %H:%M:%S %Z")"

echo $'\n'"| Module :package: | Build :wrench: | Commit Hash :link: |"
echo "| --- | --- | --- |"

shopt -s dotglob
update() {
	for d in "$@"; do
		test -d "$d" -a \! -L "$d" || continue 
		cd "$d"
		if [ -d ".git" ] || [ -f ".git" ]; then
			commit=$(git rev-parse HEAD)
			echo "| $(basename $PWD) | Pass :heavy_check_mark: | [${commit:0:8}]($(git config --get remote.origin.url | sed -e 's/\/$\|\.git$//g')/commit/$commit)"
			update *
		fi
		cd ..
	done
}

cd ./third-party
update *

cd ./picoarch/cores
update *

echo $'\n'"<details>"
echo $'\n'"<summary>Build System :desktop_computer:</summary>"
echo $'\n'"> $(uname -srmo)  "
echo "> CROSS_COMPILE="$CROSS_COMPILE"  "
echo "> $("$CROSS_COMPILE""gcc" --version | head -1)"
echo $'\n'"</details>"
