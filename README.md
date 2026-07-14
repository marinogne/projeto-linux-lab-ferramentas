9# Pensamento de Software:
>  Um Sistema de Agendamento, Gerenciamento e Monitoramento de Software.

## Descrição
O nosso Projeto automatiza o funcionamento de atualizações, monitoramento de memória RAM e o bloqueio de uso de Aplicações com um Menu Interativo.

1. **Agendamentos de Atualizações**: configura a data e horário via "crontab" agendando a atualização dos 10 Softwares mais utilizados pelo usuário, na data determinada..

2. **Atualização de Aplicações:** Através do comando "sa", identifica quais os programas mais utilizados pelo usuário, executando um "apt install" neles.

3. **Bloqueio de Uso por Tempo Determinado:** permite bloquear o uso de um programa específico em um horário definido pelo usuário, encerrando o processo automaticamente caso ele seja executado no período em que foi bloqueado.

4. **Monitoramento de Memória RAM:** monitora o uso de memória Ram do Sistema como um todo e de cada aplicação, caso a memória exceda o limite de 80% de uso total ou 20% do uso individual gera alertas no terminal, log e utilizando o notify-send.

## Objetivo
O objetivo do nosso Projeto é aplicar na prática conceitos de Shell Script, construindo uma automação para facilitar e simplificar tarefas do dia a dia.

## Estrutura do Projeto

projeto-linux/
|-- main.sh                     # Menu principal (ponto de entrada do sistema)
|-- Tarefas/
    |-- agendar.sh               # Agendamento via crontab
    |-- Monitorador.sh           # Identifica os programas mais usados
    |-- atualizarProgramas.sh    # Atualiza os programas identificados
    |-- bloqueiouso.sh           # Bloqueio de aplicações por horário
    |-- monitora_ram.sh          # Monitoramento de uso de RAM


## Instruções de Uso/Execução

### Pré-requisitos

- Sistema operacional Linux;
- (**Opcional**) Pacote **libnotify-bin**, para que os alertas de RAM apareçam como notificações do sistema. Sem ele, os alertas continuam sendo exibidos no terminal e salvos em log.

### Passo a passo

1. Baixe e extraia o projeto:
   ```
   unzip projeto-linux.zip
   cd projeto-linux
   ```

2. Dê permissão de execução ao script principal:
   ```
   chmod +x main.sh
   ```

3. Execute o sistema:
   ```
   ./main.sh
   ```

4. Escolha uma das opções do menu exibido:
   ```
   ==================================================
                1. Configurar Agendamento
                2. Atualizar Aplicações
                3. Definir Bloqueio de Aplicações
                4. Monitorar Uso de Memória RAM
                5. Sair
   ==================================================
   ```

> **Observação:** as opções 1 e 2 utilizam `sudo apt install`, então pode ser solicitada a senha do usuário durante a execução.

## Divisão de Tarefas (Equipe)

| Membro | Tarefa | Responsabilidade |
|---|---|---|
| Julia | Tempo e Checagem | Agendamento via cron e busca da lista de softwares a atualizar, vídeo de funcionamento do projeto|
| Felipe | Inteligência de Atualização e Testes | Identificação dos programas mais usados e execução das atualizações |
| Luana | Restrição de Uso | Bloqueio de softwares por horário e encerramento de processos |
| Mariana | Recursos, Alertas e Documentação | Monitoramento de RAM, alertas e organização do repositório |


## Utilização de IA e Bibliografia
| Bibliografia |
| --- |
| https://www.hostgator.com.br/blog/cron-job-guia-completo-para-automatizar-tarefas/ |
| https://pt.stackoverflow.com/questions/369953/agendar-tarefa-no-crontab-pelo-script-sh |
|https://www.locaweb.com.br/ajuda/wiki/sed-linux/|
|https://www.reddit.com/r/linuxadmin/comments/edvhvi/how_to_tell_if_there_are_updates_available/?tl=pt-br|
|https://www.locaweb.com.br/ajuda/wiki/apt-update/|
|https://www.vivaolinux.com.br/dica/Desvendando-o-comando-DATE/|
|https://www.reddit.com/r/linuxquestions/comments/11yk60h/how_to_pass_a_variable_to_the_date_command/|
| https://www.monolitonimbus.com.br/matematica-com-shell-script/ |
 |https://www.shellscriptx.com/2016/12/trabalhando-com-funcoes.html |
 |https://www.maiconschmitz.com.br/blog/2016/03/30/exibindo-notificacoes-desktop-via-shell-script/ |
 |https://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/ |
 |https://man7.org/linux/man-pages/man1/ps.1.html |


#### A Inteligência Artificial foi utilizado para verificar e corrigir a sintaxe de trechos do script. Principais correções aplicadas com o auxílio da IA:

- Correção na leitura de variáveis: Ajuste de read -p "..." $variavel para a sintaxe correta read -p "..." variavel.

- Correção de Shebang: Ajuste de #!usr/bin/env bash para o caminho absoluto padrão #!/usr/bin/env bash.

- Correção de Estruturas Condicionais: Inclusão da palavra-chave obrigatória then.

- Ajuste na Sintaxe do Cron: Correção da formatação dos comandos enviados ao crontab com base nas referências estudadas.

- Manipulação de String e Data: Substituição da sintaxe inválida %date por command substitution $(date), isolamento da variável "$horario" com aspas duplas e escape correto de caracteres (\\) no comando echo para manter a string horarioFormatado válida.

- Tratamento de Dados com AWK: Auxílio na estruturação do pipeline do awk para capturar a linha de memória do comando free, realizar o cálculo percentual de uso e formatar a saída sem casas decimais: ```porcent_total=$(free | awk '/^Mem:/ {printf "%.0f", $3/$2 * 100}')```
