#!/usr/bin/env bash
if [[ -z "$1" ]]; then
	version="latest.zip"
else
	version="$1.exe"
fi
if [[ -z "$DOCKER_TOOLBOX_INSTALL_PATH" ]]; then
	echo "error: DOCKER_TOOLBOX_INSTALL_PATH not set"
	exit 1
else
	DOCKER_TOOLBOX_INSTALL_PATH=$(cygpath -u "$DOCKER_TOOLBOX_INSTALL_PATH")
	docker="$DOCKER_TOOLBOX_INSTALL_PATH/docker.exe"
fi
url="https://get.docker.com/builds/Windows/x86_64/docker-$version" 
download="$DOCKER_TOOLBOX_INSTALL_PATH/docker-$version"
#echo "$docker"
if [[ -e "$docker" ]]; then
	echo "The old docker executable found: $docker"
	old_version=$("$docker" --version|sed s/,//g|awk '{print $3}')
	backup="${docker%.*}""-$old_version"".exe"
	echo "Backup the old docker version $old_version to $backup"
	cp "$docker" "$backup"
fi
if [[ ! -e "$download" ]]; then
	echo "Download docker form $url"
	#curl "$url" -o "$download"
	wget "$url" -O "$download"
fi
if [ $? -gt 0 ]; then
	echo "Download $url failed"
	#clean up when failed
	if [[ -e "$download" ]]; then
		rm -f "$download"
	fi
	exit 1
fi
if [ -z $1 ]; then
	# the download is latest.zip file
	unzip -oj "$download" "docker/docker.exe" -d "$DOCKER_TOOLBOX_INSTALL_PATH" 1>/dev/null
	if [[ -e "$download" ]];then
		echo "Clean up download file $download"
		rm "$download"
	fi
else 
	# the download is docker.<version>.exe 
	mv "$download" "$docker"
fi
new_version=$("$docker" --version) 
if [[ $? -gt 0 ]]; then
	echo "what's wrong"
	exit 1
fi
echo
echo "$new_version installed successfully"
