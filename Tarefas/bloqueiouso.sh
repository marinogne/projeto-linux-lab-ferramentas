#!/usr/bin/env bash

# Funcionalidade para definir os softwares e horários de bloqueio
bloqueioUso(){
    echo "=== bloqueio de uso ==="
    read -p "Digite o nome do programa a ser bloqueado (ex: firefox): " programa
    read -p "Digite a hora de INÍCIO do bloqueio (0-23): " hora_inicio
    read -p "Digite a hora de FIM do bloqueio (0-23): " hora_fim

    # remove o 0 a esquerda dos numeros, pois caso seja digitado com 0 antes do numero, o shell vai entender como se fosse octal
    hora_inicio=${hora_inicio#0}
    hora_fim=${hora_fim#0}
    hora_inicio=${hora_inicio:-0}
    hora_fim=${hora_fim:-0}

    echo "Iniciando o monitoramento do programa '$programa'..."

    # script que verifica o horário atual e monitora o programa
    while [[ 1 -eq 1 ]]; do
        
        # Captura a hora atual do sistema (também sem zero à esquerda)
        hora_atual=$(date +%H)
        hora_atual=${hora_atual#0}
        hora_atual=${hora_atual:-0}

    # Verifica se a hora atual está dentro do período de bloqueio
    if [[ "$hora_inicio" -lt "$hora_fim" ]]; then

        # Ex.: 08 às 18
        if [[ "$hora_atual" -ge "$hora_inicio" ]] && [[ "$hora_atual" -lt "$hora_fim" ]]; then

            if ps -e | grep -v "grep" | grep "$programa" > /dev/null; then
                echo "ALERTA: O programa $programa está rodando em horário bloqueado!"
                pkill -f "$programa"
                echo "Processo encerrado com sucesso."
            fi

        fi

    else

        # Ex.: 22 às 06
        if [[ "$hora_atual" -ge "$hora_inicio" ]] || [[ "$hora_atual" -lt "$hora_fim" ]]; then

            if ps -e | grep -v "grep" | grep "$programa" > /dev/null; then
                echo "ALERTA: O programa $programa está rodando em horário bloqueado!"
                pkill -f "$programa"
                echo "Processo encerrado com sucesso."
            fi

        fi

    fi
        # Aguarda 60 segundos antes de verificar novamente 
        sleep 60
    done
}