# spanish_-phonetic

<div align="center">
  <img src="https://i.imgur.com/LqfrHuF.png" alt="Logo del Paquete">
</div>

Este paquete proporciona una implementación del algoritmo Metaphone para el español, permitiendo la búsqueda fonética de palabras.

## Uso

A continuación se muestra un ejemplo de cómo utilizar el paquete:

```dart
import 'package:spanish_phonetic_search/spanish_phonetic_search.dart';

void main() {
  String palabra1 = 'casa';
  String palabra2 = 'kasa';

  // Obtener el código fonético de una palabra
  String codigoFonético = SpanishPhonetic.getPhoneticCode(palabra1);
  print('Código fonético de $palabra1: $codigoFonético');

  // Comparar si dos palabras suenan similar
  bool sonSimilares = SpanishPhonetic.areSimilar(palabra1, palabra2);
  print('$palabra1 y $palabra2 suenan similares: $sonSimilares');

  // Calcular la similitud fonética entre dos palabras
  double similitud = SpanishPhonetic.similarity(palabra1, palabra2);
  print('Similitud fonética entre $palabra1 y $palabra2: $similitud');
}
```

## Características

- Convierte palabras a códigos fonéticos.
- Compara si dos palabras suenan similar.
- Calcula la similitud fonética entre dos palabras.
