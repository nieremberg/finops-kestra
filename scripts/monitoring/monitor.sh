#!/bin/bash

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para exibir mensagens de erro
error_msg() {
    echo -e "${RED}❌ $1${NC}"
}

# Função para exibir mensagens de sucesso
success_msg() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Função para exibir mensagens informativas
info_msg() {
    echo -e "${YELLOW}ℹ️  $1${NC}"
}

# Função para verificar o status de um serviço
check_service() {
    local service=$1
    local status=$(docker-compose ps -q $service)
    
    if [ -z "$status" ]; then
        error_msg "Serviço $service não está rodando"
        return 1
    fi
    
    local health=$(docker inspect --format='{{.State.Health.Status}}' $status 2>/dev/null)
    if [ "$health" = "healthy" ]; then
        success_msg "Serviço $service está saudável"
        return 0
    else
        error_msg "Serviço $service não está saudável (Status: $health)"
        return 1
    fi
}

# Função para verificar uso de recursos
check_resources() {
    local service=$1
    local container_id=$(docker-compose ps -q $service)
    
    if [ -z "$container_id" ]; then
        return 1
    fi
    
    local stats=$(docker stats --no-stream $container_id)
    echo "$stats"
}

# Função para verificar logs de erro
check_error_logs() {
    local service=$1
    local lines=50
    
    info_msg "Últimas $lines linhas de erro do serviço $service:"
    docker-compose logs --tail=$lines $service 2>&1 | grep -i "error\|exception\|fail" || true
}

# Verificar status dos serviços
echo "=== Verificando Status dos Serviços ==="
check_service postgres
check_service kestra
check_service superset
check_service pivot
check_service nginx

# Verificar uso de recursos
echo -e "\n=== Uso de Recursos ==="
for service in postgres kestra superset pivot nginx; do
    echo -e "\nRecursos do serviço $service:"
    check_resources $service
done

# Verificar logs de erro
echo -e "\n=== Logs de Erro ==="
for service in postgres kestra superset pivot nginx; do
    check_error_logs $service
done

# Verificar espaço em disco
echo -e "\n=== Espaço em Disco ==="
df -h

# Verificar uso de memória
echo -e "\n=== Uso de Memória ==="
free -h

# Verificar carga do sistema
echo -e "\n=== Carga do Sistema ==="
uptime

# Verificar conexões de rede
echo -e "\n=== Conexões de Rede ==="
netstat -tuln | grep LISTEN 