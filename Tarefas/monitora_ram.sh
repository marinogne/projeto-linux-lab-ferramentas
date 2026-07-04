#!/usr/bin/env bash
#
# verifiva o uso da memoria ram total e de cada aplicativo em processo
# se passar do limite de ram, vai gerar um arquivo de log com alerta, e um balao de alerta

LIMITE_RAM_TOTAL=80     
LIMITE_RAM_PROCESSO=20   
INTERVALO=5               
LOG_FILE="$HOME/monitor_ram.log"

# funcao para a mensagem de alerta, é salvo no arquivo de log, e verifica se o notify send existe para que a mensagem seja exibida em notificacao
alerta() {
	local mensagem="$1"
	local data_hora
	data_hora=$(date '+%Y-%m-%d %H:%M:%S')

	echo "[$data_hora] ALERTA: $mensagem"
	echo "[$data_hora] ALERTA: $mensagem" >> "$LOG_FILE"


	if command -v notify-send &> /dev/null
	then
        	notify-send "Monitor de RAM" "$mensagem"
	fi
}

#coloquei a parte "principal" dentro de uma funcao pra poder chamar direto no main.sh que é o arquivo que chamara tudo de uma vez.
monitorarRam(){
	echo "Limite do sistema: ${LIMITE_RAM_TOTAL}% | Limite por processo: ${LIMITE_RAM_PROCESSO}%"
	echo "Log sendo salvo em: $LOG_FILE"
	echo "Ctrl+C para parar."

	while true
	do
		# procura o uso da memoria e a linha que comeca com "mem", e calcula pra porcentagem
		# esse awk vai permitir pegar o valor e ja calcular a porcentagem
			porcent_total=$(free | awk '/^Mem:/ {printf "%.0f", $3/$2 * 100}')

			if [[ $porcent_total -ge $LIMITE_RAM_TOTAL ]]
			then
				alerta "ALERTA: Uso geral de RAM do sistema está em ${porcent_total}%"
			fi

		# lista o que esta em processo, mostrando o id, a % de memoria e o nome do maior pro menor em uso de memoria
			ps -eo pid,%mem,comm --sort=-%mem | tail -n +2 | while read -r pid mem comm
			do
				
			mem_inteiro=$(echo "$mem" | sed 's/\..*//')
			
				: "${mem_inteiro:=0}"

				if [[ $mem_inteiro -ge $LIMITE_RAM_PROCESSO ]]
				then
				
						alerta "ALERTA: '$comm' (PID $pid) está usando ${mem}% de RAM"
				fi
			done

			sleep "$INTERVALO"
	done
}
