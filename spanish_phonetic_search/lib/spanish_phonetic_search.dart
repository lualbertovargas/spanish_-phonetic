/// Implementación de búsqueda fonética para español
class SpanishPhonetic {
  /// Convierte una palabra a su código fonético
  static String getPhoneticCode(String word) {
    if (word.isEmpty) return '';

    // Convertir a mayúsculas y eliminar caracteres especiales
    String normalized = _normalizeText(word.toUpperCase());

    // Si después de normalizar está vacío, retornar vacío
    if (normalized.isEmpty) return '';

    // Aplicar reglas fonéticas del español
    String phonetic = _applyPhoneticRules(normalized);

    // Eliminar vocales excepto las iniciales y caracteres duplicados
    return _cleanAndTrim(phonetic);
  }

  /// Compara si dos palabras suenan similar
  static bool areSimilar(String word1, String word2) {
    String code1 = getPhoneticCode(word1);
    String code2 = getPhoneticCode(word2);

    // Si ambos están vacíos, son similares
    if (code1.isEmpty && code2.isEmpty) return true;
    // Si solo uno está vacío, no son similares
    if (code1.isEmpty || code2.isEmpty) return false;

    return code1 == code2;
  }

  /// Calcula la similitud fonética entre dos palabras (0.0 a 1.0)
  static double similarity(String word1, String word2) {
    String code1 = getPhoneticCode(word1);
    String code2 = getPhoneticCode(word2);

    // Si ambos están vacíos, retornar 1.0
    if (code1.isEmpty && code2.isEmpty) return 1.0;
    // Si uno está vacío, retornar 0.0
    if (code1.isEmpty || code2.isEmpty) return 0.0;

    int maxLength = code1.length > code2.length ? code1.length : code2.length;
    int commonChars = 0;

    for (int i = 0; i < code1.length && i < code2.length; i++) {
      if (code1[i] == code2[i]) commonChars++;
    }

    return commonChars / maxLength;
  }

  /// Normaliza el texto eliminando tildes y caracteres especiales
  static String _normalizeText(String text) {
    const from = 'ÁÉÍÓÚÜÑ';
    const to = 'AEIOUUN';

    String normalized = text;
    for (int i = 0; i < from.length; i++) {
      normalized = normalized.replaceAll(from[i], to[i]);
    }

    return normalized.replaceAll(RegExp(r'[^A-Z]'), '');
  }

  /// Aplica las reglas fonéticas del español
  static String _applyPhoneticRules(String text) {
    if (text.isEmpty) return '';

    List<String> result = [];

    for (int i = 0; i < text.length; i++) {
      String current = text[i];
      String? next = i < text.length - 1 ? text[i + 1] : null;

      switch (current) {
        case 'B':
        case 'V':
          result.add('B');
          break;

        case 'C':
          if (next == 'E' || next == 'I') {
            result.add('S');
          } else if (next == 'H') {
            result.add('X');
            i++; // Skip next character
          } else {
            result.add('K');
          }
          break;

        case 'Z':
          result.add('S');
          break;

        case 'G':
          if (next == 'E' || next == 'I') {
            result.add('J');
          } else {
            result.add('G');
          }
          break;

        case 'H':
          // H es muda en español
          break;

        case 'Q':
          if (next == 'U') {
            i++; // Skip 'U'
            next = i < text.length - 1 ? text[i + 1] : null;
          }
          result.add('K');
          break;

        case 'W':
          result.add('U');
          break;

        case 'X':
          result.add('X');
          break;

        case 'Y':
          if (i == text.length - 1) {
            result.add('I');
          } else {
            result.add('Y');
          }
          break;

        case 'Ñ':
          result.add('N');
          break;

        case 'K':
          result.add('K');
          break;

        default:
          result.add(current);
      }
    }

    return result.join();
  }

  /// Limpia y recorta el código fonético
  static String _cleanAndTrim(String code) {
    if (code.isEmpty) return '';

    // Eliminar vocales excepto la inicial
    String withoutVowels =
        code[0] + code.substring(1).replaceAll(RegExp(r'[AEIOU]'), '');

    if (withoutVowels.isEmpty) return '';

    // Eliminar caracteres duplicados consecutivos
    List<String> result = [];
    String? lastChar;

    for (String char in withoutVowels.split('')) {
      if (char != lastChar) {
        result.add(char);
        lastChar = char;
      }
    }

    String finalResult = result.join();
    // Recortar a un máximo de 4 caracteres
    return finalResult.length <= 4 ? finalResult : finalResult.substring(0, 4);
  }
}
