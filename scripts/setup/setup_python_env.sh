#!/bin/bash

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para exibir mensagens de erro e sair
error_exit() {
    echo -e "${RED}❌ Erro: $1${NC}" >&2
    exit 1
}

# Função para exibir mensagens de sucesso
success_msg() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Função para exibir mensagens informativas
info_msg() {
    echo -e "${YELLOW}ℹ️  $1${NC}"
}

# Verificar se Python 3 está instalado
if ! command -v python3 &> /dev/null; then
    error_exit "Python 3 não está instalado. Por favor, instale o Python 3 primeiro."
fi

# Verificar se pip está instalado
if ! command -v pip3 &> /dev/null; then
    error_exit "pip3 não está instalado. Por favor, instale o pip3 primeiro."
fi

# Criar diretório para ambiente virtual se não existir
if [ ! -d "venv" ]; then
    info_msg "Criando ambiente virtual Python..."
    python3 -m venv venv || error_exit "Falha ao criar ambiente virtual"
    success_msg "Ambiente virtual criado com sucesso!"
fi

# Ativar ambiente virtual
info_msg "Ativando ambiente virtual..."
source venv/bin/activate || error_exit "Falha ao ativar ambiente virtual"
success_msg "Ambiente virtual ativado!"

# Atualizar pip
info_msg "Atualizando pip..."
pip install --upgrade pip || error_exit "Falha ao atualizar pip"
success_msg "pip atualizado!"

# Instalar dependências
info_msg "Instalando dependências do projeto..."
pip install -r requirements.txt || error_exit "Falha ao instalar dependências"
success_msg "Dependências instaladas com sucesso!"

# Configurar pre-commit hooks
info_msg "Configurando pre-commit hooks..."
pip install pre-commit || error_exit "Falha ao instalar pre-commit"
pre-commit install || error_exit "Falha ao configurar pre-commit hooks"
success_msg "pre-commit hooks configurados!"

# Criar arquivo .env se não existir
if [ ! -f ".env" ]; then
    info_msg "Criando arquivo .env..."
    cp .env-example .env || error_exit "Falha ao criar arquivo .env"
    success_msg "Arquivo .env criado!"
fi

success_msg "Ambiente Python configurado com sucesso!"
info_msg "Para ativar o ambiente virtual, execute: source venv/bin/activate"
info_msg "Para executar os testes, execute: pytest"
info_msg "Para formatar o código, execute: black ."
info_msg "Para verificar tipos, execute: mypy ." 