#!/bin/bash

#
# start up virtual machine by name using virtual
#

vm_name="win7_32"
virtualbox --startvm $vm_name & &>/dev/null

exit 0
