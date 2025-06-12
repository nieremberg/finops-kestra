#!/bin/bash

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configurações
BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)
RETENTION_DAYS=7

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

# Verificar se o arquivo .env existe
if [ ! -f .env ]; then
    error_exit "Arquivo .env não encontrado!"
fi

# Carregar variáveis de ambiente
source .env

# Criar diretório de backup se não existir
mkdir -p "$BACKUP_DIR"

# Nome do arquivo de backup
BACKUP_FILE="$BACKUP_DIR/backup_${DATE}.sql"

# Realizar backup
info_msg "Iniciando backup do banco de dados..."
if docker-compose exec -T postgres pg_dump -U "$POSTGRES_USER" "$POSTGRES_DB" > "$BACKUP_FILE"; then
    success_msg "Backup realizado com sucesso: $BACKUP_FILE"
else
    error_exit "Falha ao realizar backup"
fi

# Comprimir backup
info_msg "Comprimindo arquivo de backup..."
if gzip "$BACKUP_FILE"; then
    success_msg "Arquivo comprimido com sucesso: ${BACKUP_FILE}.gz"
else
    error_exit "Falha ao comprimir arquivo de backup"
fi

# Remover backups antigos
info_msg "Removendo backups mais antigos que $RETENTION_DAYS dias..."
find "$BACKUP_DIR" -name "backup_*.sql.gz" -type f -mtime +$RETENTION_DAYS -delete
success_msg "Limpeza de backups antigos concluída"

# Verificar espaço em disco
info_msg "Verificando espaço em disco..."
df -h "$BACKUP_DIR"

success_msg "Processo de backup concluído com sucesso!" 