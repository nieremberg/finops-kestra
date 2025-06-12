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

# Função de cleanup em caso de erro
cleanup() {
    info_msg "Realizando cleanup..."
    docker-compose down 2>/dev/null || true
}

# Configurar trap para cleanup em caso de erro
trap cleanup ERR

# Verificar pré-requisitos
info_msg "Verificando pré-requisitos..."

# Verificar se Docker está instalado
if ! command -v docker &> /dev/null; then
    error_exit "Docker não está instalado. Por favor, instale o Docker primeiro."
fi

# Verificar se Docker Compose está instalado
if ! command -v docker-compose &> /dev/null; then
    error_exit "Docker Compose não está instalado. Por favor, instale o Docker Compose primeiro."
fi

# Verificar se o arquivo .env-example existe
if [ ! -f .env-example ]; then
    error_exit "Arquivo .env-example não encontrado!"
fi

# Criar arquivo .env
info_msg "Criando arquivo .env a partir do .env-example..."
if ! cp .env-example .env; then
    error_exit "Falha ao criar arquivo .env"
fi
success_msg "Arquivo .env criado com sucesso!"

# Construir imagem do Pivot
info_msg "Construindo imagem personalizada do Apache Pivot..."
if ! docker-compose build pivot; then
    error_exit "Falha ao construir imagem do Pivot"
fi
success_msg "Imagem do Pivot construída com sucesso!"

# Subir containers
info_msg "Subindo todos os containers com Docker Compose..."
if ! docker-compose up -d; then
    error_exit "Falha ao subir containers"
fi
success_msg "Containers iniciados com sucesso!"

# Verificar se os containers estão rodando
info_msg "Verificando status dos containers..."
if ! docker-compose ps | grep -q "Up"; then
    error_exit "Alguns containers não iniciaram corretamente"
fi

success_msg "Ambiente FinOps Kestra provisionado com sucesso!"
info_msg "Para verificar os logs dos containers, execute: docker-compose logs -f"
