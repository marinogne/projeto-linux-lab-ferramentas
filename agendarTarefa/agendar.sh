#!/usr/bin/env bash

#Separando o script de agendamento e adição no crontab do script que realiza a tarefa
#Para automatizar só a tarefa, e não ficar perguntando data e horário sempre que rodar o script

read -p "Informe o dia da atualização mensal: " dia;
read -p "Informe o horário da atualização (apenas horas, sem minutos):" hora;
read -p "Informe os minutos" minutos;

segundos=00;
horario="$dia $hora:$minutos:$segundos";
horarioFormatado=$(date -d "$horario" "+%d %H:%M:%S");

#Verifica no crontab se já existe um agendamento anterior dessa tarefa
#Se existe, exclui e adiciona o novo agendamento
if [[ grep -q ~/agendarTarefa/atualizarProgramas.sh /etc/crontab ]]
then
	grep -q atualizarProgramas.sh /etc/crontab | sed /etc/crontab;
	
	echo "$minutos $hora $dia * * ~/agendarTarefa/atualizarProgramas.sh \"$horarioFormatado\"" >> /etc/crontab;
else
	#Se não existe, só adiciona o novo agendamento
	echo "$minutos $hora $dia * * ~/agendarTarefa/atualizarProgramas.sh \"$horarioFormatado\"" >> /etc/crontab;
	#Esse arquivo tem a função que consulta o sistema e recebe uma lista de software para atualizar e os atualiza
fi
