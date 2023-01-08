#!/bin/bash -u
#
#SBATCH -p hpc-bio-pacioli
#SBATCH --chdir=/home/alumno36/lab5
#SBATCH -J lab5-pacioli
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --output=lab5.out
#SBATCH --error=lab5.err
#SBATCH --mail-type=END # END/START/NONE
#SBATCH --mail-user=pablo.guillen1@um.es


# Seleccionamos el directorio donde se encuentran los ficheros fasta
fastawd="./" # "./HPC-Bio/fastq/"
# Guardamos los ficheros leidos en un array
fasta_files=($(ls -d ${fastawd}*.fastq))

# Especificamos el alumno
alumno=36

# Recorremos la lista de ficheros
for i in ${fasta_files[@]}
do
	echo "Cortamos el fichero" $i ":" $'\n'
	./file-cut.sh $i $alumno &
done
echo

