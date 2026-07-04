#!usr/bin/env bash
#include lista_atualizar.txt

atualizarProgramas(){
	contador=('1' '2' '3' '4' '5' '6' '7' '8' '9' '10')
	for i in "${contador[@]}"; do
		update=$(awk -v linha="$i" 'NR==linha {print; exit}' lista_atualizar.txt)
		sudo apt install "$update"
	done
}
