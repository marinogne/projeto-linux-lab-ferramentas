#!/usr/bin/env bash

#Separando o script de agendamento e adição no crontab do script que realiza a tarefa
#Para automatizar só a tarefa, e não ficar perguntando data e horário sempre que rodar o script


agendarAtualizacao(){
	read -p "Informe o dia da atualização mensal: " dia;
	read -p "Informe o horário da atualização 0-23 (apenas horas, sem minutos): " hora;
	read -p "Informe os minutos 0-59: " minutos;

	segundos=00;
	horario="$(date +%Y)-$(date +%m)-$dia $hora:$minutos:$segundos";
	horarioFormatado=$(date -d "$horario" "+%d %H:%M:%S");

	#Verifica no crontab se já existe um agendamento anterior dessa tarefa
	#Se existe, exclui e adiciona o novo agendamento
	if grep -q "atualizarProgramas.sh" /etc/crontab
	then
		grep -q atualizarProgramas.sh /etc/crontab | sed /etc/crontab;
	
		echo "$minutos $hora $dia * * ~/atualizarProgramas.sh \"$horarioFormatado\"" >> /etc/crontab;
	else
		#Se não existe, só adiciona o novo agendamento
		echo "$minutos $hora $dia * * ~/atualizarProgramas.sh \"$horarioFormatado\"" >> /etc/crontab;
		#Esse arquivo tem a função que consulta o sistema e recebe uma lista de software para atualizar e os atualiza
	fi

	#verificando se o comando de monitoramento está instalado
	command -v accton
	if [ $? -ne 0 ]
	then
			#instala o monitarador, ativa ele e intala o logrotate semanal
		echo "Digite sua senha para ativar o monitorador:"
			sudo apt install acct
			accton on
		echo "Digite sua senha para ativar o rotacionamento de logs semanal:"
			sudo apt install logrotate

			#definindo uma atualização diária dos programas mais usados às 20:00
		echo "Digite sua senha para configurar o monitoramento diário"
			sudo sh -c 'echo "0 20 * * * ./Monitorador.sh" >> /etc/crontab'
	fi
}
