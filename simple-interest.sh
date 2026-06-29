#!/bin/bash

# Calculadora de Interés Simple
# Este script calcula el interés simple basado en la entrada del usuario

# Función para mostrar el uso del script
mostrar_uso() {
    echo "Uso: $0 [capital] [tasa_interes] [tiempo]"
    echo "  capital:      Monto principal (número positivo)"
    echo "  tasa_interes: Tasa de interés anual en porcentaje (número positivo)"
    echo "  tiempo:       Período de tiempo en años (número positivo)"
    echo ""
    echo "Ejemplo: $0 1000 5 2"
    echo "  Esto calculará el interés simple para $1000 al 5% anual durante 2 años"
    exit 1
}

# Función para calcular el interés simple
calcular_interes() {
    local capital=$1
    local tasa=$2
    local tiempo=$3
    
    # Fórmula: Interés = (Capital × Tasa × Tiempo) / 100
    # Dividimos entre 100 porque la tasa está en porcentaje
    echo "scale=2; ($capital * $tasa * $tiempo) / 100" | bc
}

# Función para calcular el monto total
calcular_total() {
    local capital=$1
    local interes=$2
    
    # Total = Capital + Interés
    echo "scale=2; $capital + $interes" | bc
}

# Verificar si se proporcionaron argumentos
if [ $# -eq 0 ]; then
    echo "=== CALCULADORA DE INTERÉS SIMPLE ==="
    echo ""
    
    # Solicitar datos al usuario
    read -p "Ingresa el capital (monto principal): " capital
    read -p "Ingresa la tasa de interés anual (%): " tasa
    read -p "Ingresa el período de tiempo (años): " tiempo
    
    # Validar que los datos sean números positivos
    if ! [[ $capital =~ ^[0-9]+([.][0-9]+)?$ ]] || ! [[ $tasa =~ ^[0-9]+([.][0-9]+)?$ ]] || ! [[ $tiempo =~ ^[0-9]+([.][0-9]+)?$ ]]; then
        echo "❌ Error: Todos los valores deben ser números positivos."
        exit 1
    fi
    
elif [ $# -eq 3 ]; then
    # Usar argumentos de línea de comandos
    capital=$1
    tasa=$2
    tiempo=$3
    
    # Validar que los argumentos sean números positivos
    if ! [[ $capital =~ ^[0-9]+([.][0-9]+)?$ ]] || ! [[ $tasa =~ ^[0-9]+([.][0-9]+)?$ ]] || ! [[ $tiempo =~ ^[0-9]+([.][0-9]+)?$ ]]; then
        echo "❌ Error: Todos los valores deben ser números positivos."
        mostrar_uso
    fi
    
else
    echo "❌ Error: Número incorrecto de argumentos."
    mostrar_uso
fi

# Calcular el interés simple
interes=$(calcular_interes $capital $tasa $tiempo)

# Calcular el monto total
total=$(calcular_total $capital $interes)

# Mostrar resultados
echo ""
echo "=== RESULTADOS ==="
echo "📊 Capital:            $capital"
echo "📈 Tasa de interés:    $tasa%"
echo "⏱️  Período de tiempo:  $tiempo años"
echo "─────────────────────────"
echo "💰 Interés simple:     $interes"
echo "💵 Monto total:        $total"
echo ""

# Mostrar la fórmula utilizada
echo "📝 Fórmula: Interés = Capital × Tasa × Tiempo / 100"
echo "   Interés = $capital × $tasa × $tiempo / 100 = $interes"
