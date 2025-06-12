# FinOps Kestra

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Kestra](https://img.shields.io/badge/Kestra-000000?style=for-the-badge&logo=kestra&logoColor=white)](https://kestra.io/)
[![Apache Superset](https://img.shields.io/badge/Apache%20Superset-FF0000?style=for-the-badge&logo=apache&logoColor=white)](https://superset.apache.org/)
[![Apache Pivot](https://img.shields.io/badge/Apache%20Pivot-FF0000?style=for-the-badge&logo=apache&logoColor=white)](https://pivot.apache.org/)
[![NGINX](https://img.shields.io/badge/NGINX-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://www.nginx.com/)
[![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)](https://prometheus.io/)
[![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)](https://grafana.com/)
[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.linux.org/)

## Índice

- [Introdução](#introdução)
- [O que é FinOps?](#o-que-é-finops)
- [Arquitetura do Sistema](#arquitetura-do-sistema)
  - [Componentes Principais](#componentes-principais)
  - [Fluxo de Dados](#fluxo-de-dados)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Pré-requisitos](#pré-requisitos)
- [Instalação Passo a Passo](#instalação-passo-a-passo)
- [Ambiente de Desenvolvimento](#ambiente-de-desenvolvimento)
  - [Configuração do Python](#configuração-do-python)
  - [Ferramentas de Desenvolvimento](#ferramentas-de-desenvolvimento)
- [Configuração Detalhada](#configuração-detalhada)
  - [Configurando o Kestra](#configurando-o-kestra)
  - [Configurando o Superset](#configurando-o-superset)
  - [Configurando o Pivot](#configurando-o-pivot)
- [Uso do Sistema](#uso-do-sistema)
  - [Monitoramento](#monitoramento)
  - [Backup e Recuperação](#backup-e-recuperação)
- [Desenvolvimento](#desenvolvimento)
  - [Testes](#testes)
  - [Formatação de Código](#formatação-de-código)
  - [Verificação de Tipos](#verificação-de-tipos)
- [Solução de Problemas](#solução-de-problemas)
- [Glossário](#glossário)
- [Suporte](#suporte)
- [Atualizações](#atualizações)

## <a id="introdução"></a>Introdução

Este projeto implementa uma solução completa de FinOps (Financial Operations) utilizando Kestra como orquestrador principal. O sistema foi projetado para automatizar e otimizar processos financeiros, fornecendo visibilidade e controle sobre os custos de infraestrutura.

### O que é FinOps?

FinOps é uma prática que combina finanças, tecnologia e operações para gerenciar e otimizar custos de infraestrutura em nuvem. Imagine que você está gerenciando uma casa:
- Você precisa saber quanto está gastando com cada serviço (água, luz, gás)
- Precisa entender onde pode economizar
- Deve garantir que está pagando apenas pelo que realmente usa

O FinOps faz isso para infraestrutura de TI, ajudando a:
1. Reduzir custos desnecessários
2. Otimizar o uso de recursos
3. Melhorar a eficiência operacional

## <a id="arquitetura-do-sistema"></a>Arquitetura do Sistema

O sistema é composto por vários componentes que trabalham juntos:

### <a id="componentes-principais"></a>Componentes Principais

1. **Kestra** (Orquestrador)
   - O que é: Um orquestrador de workflows que automatiza tarefas
   - Função: Coordena todas as operações do sistema
   - Acesso: http://localhost/kestra/

2. **Apache Superset** (Visualização)
   - O que é: Uma ferramenta de visualização de dados
   - Função: Cria dashboards e gráficos para análise
   - Acesso: http://localhost/superset/

3. **Apache Pivot** (Interface)
   - O que é: Interface web para interação com o sistema
   - Função: Permite interagir com os dados e relatórios
   - Acesso: http://localhost/pivot/

4. **PostgreSQL** (Banco de Dados)
   - O que é: Sistema de banco de dados
   - Função: Armazena todos os dados do sistema
   - Acesso: Apenas interno

5. **Nginx** (Proxy)
   - O que é: Servidor web e proxy reverso
   - Função: Gerencia o acesso aos serviços
   - Acesso: http://localhost/

### <a id="fluxo-de-dados"></a>Fluxo de Dados

1. **Prometheus**
   - O que é: Sistema de monitoramento
   - Função: Coleta métricas do sistema
   - Acesso: http://localhost:9090/

2. **Grafana**
   - O que é: Plataforma de visualização de métricas
   - Função: Cria dashboards de monitoramento
   - Acesso: http://localhost:3000/

## <a id="estrutura-do-projeto"></a>Estrutura do Projeto

```
finops_kestra/
├── config/                    # Configurações dos serviços
│   ├── nginx/                # Configurações do Nginx
│   │   └── nginx.conf
│   └── prometheus/           # Configurações do Prometheus
│       └── prometheus.yml
│
├── docs/                     # Documentação
│   ├── api/                  # Documentação da API
│   └── guides/              # Guias de uso
│
├── Pivot/                    # Aplicação Pivot
│   ├── Dockerfile
│   └── requirements.txt
│
├── scripts/                  # Scripts de automação
│   ├── backup/              # Scripts de backup
│   │   └── backup.sh
│   ├── monitoring/          # Scripts de monitoramento
│   │   └── monitor.sh
│   └── setup/               # Scripts de configuração
│       └── setup.sh
│
├── tests/                    # Testes automatizados
│   ├── unit/                # Testes unitários
│   └── integration/         # Testes de integração
│
├── .env-example             # Exemplo de variáveis de ambiente
├── .gitignore              # Arquivos ignorados pelo Git
├── docker-compose.yml      # Configuração dos containers
└── README.md               # Este arquivo
```

### Descrição dos Diretórios

1. **config/**
   - Contém arquivos de configuração dos serviços
   - Separado por serviço para melhor organização
   - Facilita manutenção e atualizações

2. **docs/**
   - Documentação completa do projeto
   - Separada em API e guias de uso
   - Mantém a documentação organizada e acessível

3. **Pivot/**
   - Código fonte da aplicação Pivot
   - Dockerfile para containerização
   - Dependências Python

4. **scripts/**
   - Scripts de automação organizados por função
   - Backup, monitoramento e setup
   - Facilita manutenção e execução

5. **tests/**
   - Testes automatizados
   - Separados em unitários e integração
   - Garante qualidade do código

### Arquivos Principais

1. **docker-compose.yml**
   - Define todos os serviços
   - Configura redes e volumes
   - Gerencia dependências

2. **.env-example**
   - Template de variáveis de ambiente
   - Documenta configurações necessárias
   - Facilita setup inicial

3. **README.md**
   - Documentação principal
   - Guia de instalação e uso
   - Referência rápida

## <a id="pré-requisitos"></a>Pré-requisitos

Antes de começar, você precisa ter instalado:

1. **Docker** (versão 20.10 ou superior)
   - O que é: Plataforma para criar e executar aplicações em containers
   - Como instalar:
     ```bash
     # Ubuntu/Debian
     sudo apt-get update
     sudo apt-get install docker.io
     
     # Verificar instalação
     docker --version
     ```

2. **Docker Compose** (versão 2.0 ou superior)
   - O que é: Ferramenta para definir e executar aplicações Docker
   - Como instalar:
     ```bash
     # Ubuntu/Debian
     sudo apt-get install docker-compose
     
     # Verificar instalação
     docker-compose --version
     ```

3. **Requisitos de Sistema**
   - Mínimo 4GB de RAM
   - 20GB de espaço em disco
   - Sistema operacional Linux/Unix ou WSL2 (Windows)

## <a id="instalação-passo-a-passo"></a>Instalação Passo a Passo

### 1. Preparação do Ambiente

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/finops-kestra.git
   cd finops-kestra
   ```

2. Dê permissão de execução aos scripts:
   ```bash
   chmod +x scripts/setup/setup.sh
   chmod +x scripts/monitoring/monitor.sh
   chmod +x scripts/backup/backup.sh
   ```

3. Execute o script de setup:
   ```bash
   ./scripts/setup/setup.sh
   ```

## <a id="ambiente-de-desenvolvimento"></a>Ambiente de Desenvolvimento

### <a id="configuração-do-python"></a>Configuração do Python

1. Certifique-se de ter Python 3.8+ instalado:
   ```bash
   python3 --version
   ```

2. Execute o script de configuração do ambiente Python:
   ```bash
   ./scripts/setup/setup_python_env.sh
   ```

3. Ative o ambiente virtual:
   ```bash
   source venv/bin/activate
   ```

### <a id="ferramentas-de-desenvolvimento"></a>Ferramentas de Desenvolvimento

O projeto utiliza várias ferramentas para garantir a qualidade do código:

1. **Black**: Formatador de código
   ```bash
   black .
   ```

2. **Flake8**: Linter para verificar estilo do código
   ```bash
   flake8 .
   ```

3. **MyPy**: Verificador de tipos estáticos
   ```bash
   mypy .
   ```

4. **Pre-commit**: Hooks para verificação automática
   - Instalado automaticamente pelo script de setup
   - Executa verificações antes de cada commit

## <a id="configuração-detalhada"></a>Configuração Detalhada

### <a id="configurando-o-kestra"></a>Configurando o Kestra

1. Acesse http://localhost/kestra/
2. Faça login com:
   - Usuário: admin
   - Senha: admin

3. Configure seu primeiro workflow:
   - Clique em "New Flow"
   - Dê um nome ao workflow
   - Adicione tarefas usando o editor visual

### <a id="configurando-o-superset"></a>Configurando o Superset

1. Acesse http://localhost/superset/
2. Faça login com:
   - Usuário: admin
   - Senha: admin

3. Configure sua primeira visualização:
   - Clique em "Create Dashboard"
   - Adicione gráficos e métricas

### <a id="configurando-o-pivot"></a>Configurando o Pivot

1. Acesse http://localhost/pivot/
2. Faça login com:
   - Usuário: admin
   - Senha: admin

3. Configure sua primeira análise:
   - Crie uma nova visualização
   - Importe dados
   - Configure métricas

## <a id="uso-do-sistema"></a>Uso do Sistema

### <a id="monitoramento"></a>Monitoramento

1. Verifique o status dos serviços:
   ```bash
   ./scripts/monitoring/monitor.sh
   ```

2. Interprete os resultados:
   - Verde: Serviço saudável
   - Vermelho: Problema detectado
   - Amarelo: Aviso/Informação

### <a id="backup-e-recuperação"></a>Backup e Recuperação

1. Execute o backup:
   ```bash
   ./scripts/backup/backup.sh
   ```

2. Verifique os backups:
   ```bash
   ls -l backups/
   ```

### Acessando os Serviços

1. **Kestra** (http://localhost/kestra/)
   - Gerencia workflows
   - Monitora execuções
   - Configura automações

2. **Superset** (http://localhost/superset/)
   - Visualiza dados
   - Cria dashboards
   - Gera relatórios

3. **Pivot** (http://localhost/pivot/)
   - Analisa dados
   - Cria visualizações
   - Exporta relatórios

## <a id="desenvolvimento"></a>Desenvolvimento

### <a id="testes"></a>Testes

1. Execute os testes unitários:
   ```bash
   pytest tests/unit
   ```

2. Execute os testes de integração:
   ```bash
   pytest tests/integration
   ```

3. Execute todos os testes com cobertura:
   ```bash
   pytest --cov
   ```

### <a id="formatação-de-código"></a>Formatação de Código

1. Formate automaticamente:
   ```bash
   black .
   ```

2. Verifique o estilo:
   ```bash
   flake8 .
   ```

### <a id="verificação-de-tipos"></a>Verificação de Tipos

1. Verifique os tipos:
   ```bash
   mypy .
   ```

2. Ignore erros específicos:
   ```python
   # type: ignore
   ```

## <a id="solução-de-problemas"></a>Solução de Problemas

### Problemas Comuns

1. Serviços não iniciam:
   ```bash
   ./scripts/monitoring/monitor.sh
   ```

2. Erro de conexão com banco
   ```bash
   # Verifique se o PostgreSQL está rodando
   docker-compose ps postgres
   
   # Verifique os logs do PostgreSQL
   docker-compose logs postgres
   ```

3. Problemas de performance
   ```bash
   # Verifique uso de recursos
   ./scripts/monitoring/monitor.sh
   
   # Ajuste limites no docker-compose.yml
   nano docker-compose.yml
   ```

### Logs e Diagnóstico

1. **Ver todos os logs**
   ```bash
   docker-compose logs
   ```

2. **Ver logs de um serviço específico**
   ```bash
   docker-compose logs [nome_do_serviço]
   ```

3. **Ver logs em tempo real**
   ```bash
   docker-compose logs -f [nome_do_serviço]
   ```

## <a id="glossário"></a>Glossário

- **Container**: Unidade de software que empacota código e dependências
- **Docker**: Plataforma para criar e executar containers
- **Workflow**: Sequência de tarefas automatizadas
- **FinOps**: Prática de gerenciamento financeiro de operações
- **Proxy**: Servidor que gerencia requisições entre clientes e servidores
- **Métricas**: Medidas quantitativas do sistema
- **Dashboard**: Painel visual com informações do sistema
- **Backup**: Cópia de segurança dos dados
- **Log**: Registro de eventos do sistema

## <a id="suporte"></a>Suporte

Se precisar de ajuda:

1. Verifique a documentação
2. Consulte o troubleshooting
3. Abra uma issue no GitHub
4. Contate a equipe de desenvolvimento

## <a id="atualizações"></a>Atualizações

### Versão 1.0.0
- Implementação inicial
- Integração com Kestra
- Dashboard Superset
- Interface Pivot

### Próximas Atualizações
- [ ] Autenticação OAuth2
- [ ] Backup automático
- [ ] Métricas Prometheus
- [ ] CI/CD pipeline