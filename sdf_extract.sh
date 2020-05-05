#!/usr/bin/env bash
for file in ./receptor/*.pdb;
do
if [ -f "$file" ]; then
tmp=${file%.pdb};
name="${tmp##*/}"; 

chosen_ligands=$(ls ./results_$name/*.pdbqt | grep _out)
for file2 in $chosen_ligands;
do
tmp2=${file2%.pdbqt};
name2="${tmp2##*/}"; 
#obabel -ipdbqt ./results_$name/$name2.pdbqt -osdf -O ./results_$name/$name2.sdf -m --gen3d  -p
obabel -ipdbqt ./results_$name/$name2.pdbqt -osdf -O ./results_$name/$name2.sdf -m --gen2d
done;

ls ./results_$name/*_out*.sdf | grep -v out1 | xargs rm

sdflist=$(ls ./results_$name/*_out*.sdf | grep out1)
obabel -isdf $sdflist -osdf -O ./results_$name/${name}_all_ligands.sdf

ls ./results_$name/*_out*.sdf | grep out1 | xargs rm
#ls ./results_$name/*1.sdf | xargs rm

obabel -isdf ./results_$name/${name}_all_ligands.sdf -osmi -O ./results_$name/${name}_all_ligands.smi

else
echo "No pdb files in receptor folder"
fi;
done;



