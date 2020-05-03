#!/usr/bin/env bash
for file in ./receptor/*.pdb;
do
if [ -f "$file" ]; then
tmp=${file%.pdb};
name="${tmp##*/}"; 

for file2 in ./results_$name/*.pdbqt;
do
tmp2=${file2%.pdbqt};
name2="${tmp2##*/}"; 
obabel -ipdbqt ./results_$name/$name2.pdbqt -osdf -O ./results_$name/$name2.sdf -m --gen3d  -p
done;

ls ./results_$name/*_out*.sdf | grep -v out1 | xargs rm

sdflist=$(ls ./results_$name/*_out*.sdf | grep out1)
obabel -isdf $sdflist -osdf -O ./results_$name/${name}_all_ligands.sdf

ls ./results_$name/*_out*.sdf | grep out1 | xargs rm
ls ./results_$name/*1.sdf | xargs rm

else
echo "No pdb files in receptor folder"
fi;
done;



