#!/bin/sh

# active_net_service_name
# This script echos the name of the currently active network service
# (e.g. "Airport" or "Built-in Ethernet")
# This is the "human-readable" counterpart to the network interface name
# that can be obtained via the 'active_net_iface' script.
#
# This script also serves as an illustration of using the 'scutil' command.
# Based on a script in the following macosxhints article:
# http://www.macosxhints.com/article.php?story=20050214200529336
#
# Cameron Hayne (macdev@hayne.net)  Feb 2005

scutil_query()
{
    key=$1

    scutil<<EOT
    open
    get $key
    d.show
    close
EOT
}

SERVICE_GUID=`scutil_query State:/Network/Global/IPv4 | grep "PrimaryService" | awk '{print $3}'`

SERVICE_NAME=`scutil_query Setup:/Network/Service/$SERVICE_GUID | grep "UserDefinedName" | awk -F': ' '{print $2}'`

echo $SERVICE_NAME
