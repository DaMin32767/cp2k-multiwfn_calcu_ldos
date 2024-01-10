#!/bin/bash
for i in 5.4907 11.45 23.29;do
for j in 24.30 12.19 0.07847;do
p="$i,$j,21.785"
q="$i,$j,95.256"
mkdir "$i-$j"
cd "$i-$j"
sed -i "8s/.*/$p/" ../ldos.in
sed -i "9s/.*/$q/" ../ldos.in
sbatch ../mfn-DM.sh 
cp LDOS.txt "ldos$i-$j.txt"
cd ..
done
done
















