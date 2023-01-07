#!/bin/bash -u

# Leemos el fichero que queremos cortar
if [[ ! -z "$1" ]]; then
	files=$1
else
	# Leemos los ficheros fastq
	files=$(ls *.fastq)
fi

# Declaramos el tamaño proporcional del fichero que necesitamos (1/alumno)
if [[ -z "$2" ]]; then
	alumno=36
else
	alumno=$2
fi

# Recorremos la lista de ficheros ".fastq"
for i in $files
do
	# Calculamos el tamaño del fichero en bytes
	size=$(ls -s $i | cut -d" " -f1)
	echo "El fichero $i ocupa $size bytes" 
	let "cutsize=$size/$alumno"
	echo "Dividiendo el tamaño por $alumno tenemos $cutsize bytes"
	# Creamos el fichero de salida y volcamos el contenido dentro
	salida=$(echo $i | sed -e 's/\.fastq/-cut\.fastq/')
	echo "Por tanto leemos los primero $cutsize bytes del fichero $i"
	echo "Y guardamos los bytes anteriores en un nuevo fichero $salida"
	cat $i | head -c $cutsize > $salida
	echo
done

# Copiamos los archivos generados 
# TODO

# Eliminamos del directorio de trabajo los archivos generados
#wd="."
#ls $wd | grep -Ei "\-cut.fastq" | xargs -d"\n" rm
