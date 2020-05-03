for file in ./receptor/*.pdb;
do
if [ -f "$file" ]; then
tmp=${file%.pdb};
name="${tmp##*/}"; 

for file2 in ./results_$name/*.pdbqt;
do
tmp2=${file2%.pdbqt};
name2="${tmp2##*/}"; 
obabel ./results_$name/$name2.pdbqt -O ./results_$name/$name2.sdf -m
done;

ls ./results_$name/*_out*.sdf | grep -v out1 | xargs rm
obabel ./results_$name/*.pdbqt -O ./results_$name/${name}_all_ligands.sdf
ls ./results_$name/*_out*.sdf | grep out1 | xargs rm
else
echo "No pdb files in receptor folder"
fi;
done;



