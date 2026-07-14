#!/usr/bin/env bash

source "./Tarefas/agendar.sh"
source "./Tarefas/atualizarProgramas.sh"
source "./Tarefas/Monitorador.sh"
source "./Tarefas/bloqueiouso.sh"
source "./Tarefas/monitora_ram.sh"


echo "=================================================="
echo "          1. Configurar Agendamento               "
echo "          2. Atualizar Aplicações                 "
echo "          3. Definir Bloqueio de Aplicações       "
echo "          4. Monitorar Uso de Memória RAM         "
echo "          5. Sair                                 "
echo "=================================================="
read -p "Escolha uma das opções: " opcao

if [[ "$opcao" -eq 1 ]]; then
    echo "Carregando..."
    agendarAtualizacao
elif [[ "$opcao" -eq 2 ]]; then
    echo "Carregando..."
    monitorador
    atualizarProgramas
elif [[ "$opcao" -eq 3 ]]; then
    echo "Carregando..."
    bloqueioUso
elif [[ "$opcao" -eq 4 ]]; then
    echo "Carregando..."
    monitorarRam
elif [[ "$opcao" -eq 5 ]]; then
    echo "Saindo..."
    sleep 5
    exit 0
else
    echo "Opção inválida!"
    exit 1
fi

