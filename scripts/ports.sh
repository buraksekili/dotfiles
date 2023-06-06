# This script prints out open (listened) ports on your machine using `lsof`
#
lsof -i -P -n | grep LISTEN
