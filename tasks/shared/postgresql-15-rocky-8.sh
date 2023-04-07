#!/bin/bash
SCRIPTDIR=`dirname $0`
SCRIPTNAME=`basename $0`

function usage() {
	echo "### Install PostgreSQL 15"
}

function check() {
	echo "### Check PostgreSQL 15 - $SCRIPTNAME"
	sudo systemctl status postgresql-15.service
	xRC=$?
	if [[ $xRC -eq 4 ]]; then
		echo "### There is no postgresql-15.service. - $SCRIPTNAME"
		return 0
	else
		echo "### postgresql-15.service exists. - $SCRIPTNAME"
		sudo dnf check-update postgresql15-server
		xRC=$?
		if [[ $xRC -eq 0 ]]; then
			echo "### Your postgresql-15 is the latest - $SCRIPTNAME"
			return 1
		else
			echo "### Your postgresql-15 is not the latest - $SCRIPTNAME"
			return 0
		fi
		return 1
	fi
	return 4
}

function apply() {
	check
	xRC=$?
	if [[ $xRC -eq 0 ]]; then
		read -p "Are you sure to Install/Update PostgreSQL 15? " -n 1 -r
		echo
		if [[ ! $REPLY =~ ^[Yy]$ ]]; then
			echo "### Install/Update PostgreSQL 15 - $SCRIPTNAME"
			sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
			sudo dnf -qy module disable postgresql
			sudo dnf install -y postgresql15-server
			return 0
		else
			echo "### Do it next time - $SCRIPTNAME"
			return 0
		fi
	else
		echo "### Skip installing PostgreSQL 15 - $SCRIPTNAME"
		return 0
	fi
}

if [[ $(type -t $1) == function ]]; then
	$1
	xRC=$?
	exit $?
fi
exit 4
