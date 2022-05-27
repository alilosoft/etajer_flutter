#!bin/bash

echo starting script...
pwd

for o in {1..10} # $(ls ../..)
do
	echo $ $o
    sleep 0.1
done
echo end script

