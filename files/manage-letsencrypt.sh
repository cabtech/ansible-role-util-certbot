#!/bin/bash
# MANAGED_BY_ANSIBLE

ss_action=''
ss_contact=''
ss_domain=''
ss_dry_run=''
while getopts a:c:d:t arg; do
	case
		a) ss_action="${OPTARG}";;
		c) ss_contact="${OPTARG}";;
		d) ss_domain="${OPTARG}";;
		t) ss_dry_run='--dry-run';;
		*) echo 'bad arg - bye'; exit 42
	esac
done

if [[ -z "$action" ]]; then
	echo "ERROR :: $prog :: need an action (-a)"
	exit 43
fi

# --------------------------------

if [[ "$ss_action" == "create" ]]; then
	if [[ -z "$contact" ]]; then
		echo "ERROR :: $prog :: need a contact (-c) if creating a certificate"
		exit 43
	elif [[ -z "$domain" ]]; then
		echo "ERROR :: $prog :: need a domain (-d) if creating a certificate"
		exit 43
	else
		/usr/bin/letsencrypt certonly --standalone --agree-tos -m "$ss_contact" -d "$ss_domain" ${ss_dry_run}
		exit $?
	fi
elif [[ "$ss_action" == "renew" ]]; then
	/usr/bin/letsencrypt renew ${ss_dry_run}
	exit $?
else
	echo "ERROR :: $prog :: unexpected action"
	exit 43
fi

# --------------------------------
# should not get here

exit 44
