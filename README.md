# Laboratorio: Aritmética de Precisión Múltiple y BCD (Unidad 8 - Post 2)[cite: 4]
**Estudiante:** [Tu Apellido] - Ingeniería de Sistemas (UFPS)[cite: 4]

## 1. Descripción
Este laboratorio implementa operaciones que superan la capacidad nativa de 16 bits y maneja aritmética decimal corregida (BCD)[cite: 4].

## 2. Checkpoints Implementados
* **Aritmética 32 bits:** Uso de `ADC` y `SBB` para propagar acarreos y préstamos entre registros[cite: 4].
* **Ajuste BCD:** Implementación de `DAA` y `DAS` para mantener la validez de los dígitos decimales (0-9) en cada nibble[cite: 4].
* **Calculadora:** Conversión de caracteres ASCII a binario para realizar `MUL` y `DIV`, con una subrutina para imprimir resultados de varios dígitos[cite: 4].

## 3. Evidencias
| Operación | Resultado Esperado | Captura |
| :--- | :--- | :--- |
| Suma 32 bits | 0003:0000h | `capturas/32bits.png` |
| Suma BCD | 85 | `capturas/bcd.png` |
| Multiplicación | 7 * 8 = 56 | `capturas/calc.png` |

## 4. Conclusiones
El uso de `ADC` y `SBB` es fundamental para el software que requiere alta precisión en arquitecturas de bits limitados. El ajuste BCD facilita la interacción humana al procesar datos financieros o contables directamente en base 10[cite: 4].
