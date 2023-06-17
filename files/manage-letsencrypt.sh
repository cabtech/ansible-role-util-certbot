#!/bin/bash
# MANAGED_BY_ANSIBLE
#
# config file format:
#   one line per domain
#   comment symbol is #

prog=$(basename $0)

ss_action=''
ss_contact=''
ss_domain=''
ss_dry_run=''
ss_expand=''
ss_filename=''
while getopts a:c:d:ef:t arg; do
	case $arg in
		a) ss_action="${OPTARG}";;
		c) ss_contact="${OPTARG}";;
		d) ss_domain="${OPTARG}";;
		e) ss_expand="--expand";;  # use if adding new domain to a cert
		f) ss_filename="${OPTARG}";;
		t) ss_dry_run='--dry-run';;
		*) echo "ERROR :: $prog :: bad arg - bye"; exit 42
	esac
done

if [[ -z "$ss_action" ]]; then
	echo "ERROR :: $prog :: need an action (-a)"
	exit 43
fi

# --------------------------------

if [[ "$ss_action" == "create" ]]; then
	# if no domains on the command line, see if using a config file
	if [[ -z "$ss_domain" ]]; then
		if [[ -n "$ss_filename" ]]; then
			# remove comments
			# remove blank lines
			# convert to CSV
			# remove spaces
			# remove trailing comma
			ss_domain=$(cat $ss_filename | grep -v '#' | sed '/^ *$/d' | tr '\n' ',' | tr -d ' ' | sed 's/,$//')
		fi
	fi

	if [[ -z "$ss_contact" ]]; then
		echo "ERROR :: $prog :: need a contact (-c) if creating a certificate"
		exit 43
	elif [[ -z "$ss_domain" ]]; then
		echo "ERROR :: $prog :: need a domain (-d) if creating a certificate"
		exit 44
	fi

	/usr/bin/certbot certonly -n --standalone --agree-tos -m "$ss_contact" -d "$ss_domain" ${ss_dry_run} ${ss_expand}
	exit $?
elif [[ "$ss_action" == "renew" ]]; then
	/usr/bin/certbot renew ${ss_dry_run}
	exit $?
else
	echo "ERROR :: $prog :: unexpected action ($ss_action)"
	exit 45
fi

# --------------------------------
# should not get here

exit 46
