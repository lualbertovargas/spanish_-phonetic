import 'package:flutter_test/flutter_test.dart';
import 'package:spanish_phonetic_search/spanish_phonetic_search.dart';

void main() {
  group('SpanishPhonetic', () {
    group('getPhoneticCode', () {
      test('debería manejar correctamente palabras básicas', () {
        expect(SpanishPhonetic.getPhoneticCode('casa'), 'KS');
        expect(SpanishPhonetic.getPhoneticCode('gato'), 'GT');
        expect(SpanishPhonetic.getPhoneticCode('zapato'), 'SPT');
        expect(SpanishPhonetic.getPhoneticCode('queso'), 'KS');
        expect(SpanishPhonetic.getPhoneticCode('chico'), 'XK');
      });

      test('debería manejar consonantes especiales', () {
        expect(SpanishPhonetic.getPhoneticCode('valencia'), 'BLNS');
        expect(SpanishPhonetic.getPhoneticCode('balencia'), 'BLNS');
        expect(SpanishPhonetic.getPhoneticCode('guitarra'), 'GTR');
        expect(SpanishPhonetic.getPhoneticCode('guerra'), 'GR');
      });
    });

    group('areSimilar', () {
      test('debería identificar palabras similares', () {
        expect(SpanishPhonetic.areSimilar('casa', 'kasa'), true);
        expect(SpanishPhonetic.areSimilar('valencia', 'balensia'), true);
        expect(SpanishPhonetic.areSimilar('zapato', 'sapato'), true);
        expect(SpanishPhonetic.areSimilar('queso', 'keso'), true);
        expect(SpanishPhonetic.areSimilar('chico', 'xiko'), true);
      });

      test('debería identificar palabras diferentes', () {
        expect(SpanishPhonetic.areSimilar('gato', 'pato'), false);
        expect(SpanishPhonetic.areSimilar('mesa', 'pesa'), false);
        expect(SpanishPhonetic.areSimilar('taza', 'casa'), false);
      });

      test('debería manejar casos extremos en comparación', () {
        expect(SpanishPhonetic.areSimilar('', ''), true);
        expect(SpanishPhonetic.areSimilar('a', ''), false);
        expect(SpanishPhonetic.areSimilar('', 'a'), false);
        expect(SpanishPhonetic.areSimilar(' ', ' '), true);
      });
    });

    group('similarity', () {
      test('debería calcular similitud correctamente', () {
        expect(SpanishPhonetic.similarity('casa', 'kasa'), 1.0);
        expect(SpanishPhonetic.similarity('valencia', 'balensia'), 1.0);
        expect(SpanishPhonetic.similarity('zapato', 'sapato'), 1.0);
        expect(SpanishPhonetic.similarity('chico', 'xiko'), 1.0);
      });

      test('debería manejar palabras parcialmente similares', () {
        expect(SpanishPhonetic.similarity('gato', 'gata'), greaterThan(0.5));
        expect(SpanishPhonetic.similarity('perro', 'pero'), greaterThan(0.5));
        expect(SpanishPhonetic.similarity('mesa', 'misa'), greaterThan(0.5));
      });

      test('debería manejar palabras diferentes', () {
        expect(SpanishPhonetic.similarity('gato', 'pato'), lessThan(1.0));
        expect(SpanishPhonetic.similarity('mesa', 'casa'), lessThan(1.0));
        expect(SpanishPhonetic.similarity('taza', 'plaza'), lessThan(1.0));
      });

      test('debería manejar casos extremos en similitud', () {
        expect(SpanishPhonetic.similarity('', ''), 0.0);
        expect(SpanishPhonetic.similarity('a', ''), 0.0);
        expect(SpanishPhonetic.similarity('', 'a'), 0.0);
        expect(SpanishPhonetic.similarity(' ', ' '), 0.0);
      });
    });

    group('casos especiales', () {
      test('debería manejar la h muda', () {
        expect(SpanishPhonetic.getPhoneticCode('huevo'),
            equals(SpanishPhonetic.getPhoneticCode('uevo')));
        expect(SpanishPhonetic.getPhoneticCode('hola'),
            equals(SpanishPhonetic.getPhoneticCode('ola')));
        expect(SpanishPhonetic.getPhoneticCode('ahora'),
            equals(SpanishPhonetic.getPhoneticCode('aora')));
      });

      test('debería manejar la q seguida de ue/ui', () {
        expect(SpanishPhonetic.getPhoneticCode('queso'),
            equals(SpanishPhonetic.getPhoneticCode('keso')));
        expect(SpanishPhonetic.getPhoneticCode('quiero'),
            equals(SpanishPhonetic.getPhoneticCode('kiero')));
        expect(SpanishPhonetic.getPhoneticCode('pequeño'),
            equals(SpanishPhonetic.getPhoneticCode('pekeño')));
      });

      test('debería manejar la g seguida de e/i', () {
        expect(SpanishPhonetic.getPhoneticCode('gente'),
            equals(SpanishPhonetic.getPhoneticCode('jente')));
        expect(SpanishPhonetic.getPhoneticCode('girar'),
            equals(SpanishPhonetic.getPhoneticCode('jirar')));
      });

      test('debería manejar la y como vocal', () {
        expect(SpanishPhonetic.getPhoneticCode('rey'),
            equals(SpanishPhonetic.getPhoneticCode('rei')));
        expect(SpanishPhonetic.getPhoneticCode('muy'),
            equals(SpanishPhonetic.getPhoneticCode('mui')));
      });
    });

    group('rendimiento', () {
      test('debería manejar textos largos eficientemente', () {
        final longText = 'electroencefalografista' * 100;
        final stopwatch = Stopwatch()..start();
        SpanishPhonetic.getPhoneticCode(longText);
        stopwatch.stop();
        expect(stopwatch.elapsedMilliseconds, lessThan(100));
      });
    });
  });
}
