#!/bin/bash
#include Ola_mundo.txt

#listanto o registro dos processo encerrados, classificando por tempo, e usando awk para exibir a ultima cóluna ($NF)
#de todas as linhas que contem um número de colunas maior que 6, não tem ***other* na setima coluna, e não tem * como
#último caractere. Por fim são enviados os top 10 para um arquivo de texto
monitorador(){
    sa -t | awk '{ if ( (NF > 6 && $7 != "***other*") && ! /\*$/) print $NF}' | head > lista_atualizar.txt
}
