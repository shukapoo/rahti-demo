#!/bin/bash
for i in {1..5000}
do
   echo "Curled $i times"
   curl $1
done
