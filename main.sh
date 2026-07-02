#!/usr/bin/env bash

source "./tarefas/monitor_ram2.sh"

echo "=================================================="
echo "          1. Configurar Agendamento               "
echo "          2. Atualizar Aplicações                 "
echo "          3. Definir Bloqueio de Aplicações       "
echo "          4. Monitorar Uso de Memória RAM         "
echo "          5. Sair                                 "
read -p "Escolha uma das opções: " opcao

if [[ "$opcao" -eq 1 ]]; then
    echo "Carregando..."
elif [[ "$opcao" -eq 2 ]]; then
    echo "Carregando..."
elif [[ "$opcao" -eq 3 ]]; then
    echo "Carregando..."
elif [[ "$opcao" -eq 4 ]]; then
    echo "Carregando..."
    monitorarRam
elif [[ "$opcao" -eq 5]]; then
    echo "Saindo..."
    exit 0
else
    echo "Opção inválida!"
    exit 1
fi

