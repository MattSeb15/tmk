import 'dart:math';

import 'package:tmk/core/static/addition_class.dart';

class AppMath {
  static int getRandomNumberWithC(int cifras) {
    if (cifras == 0) {
      return 0;
    } else if (cifras < 0) {
      final min = -pow(10, -cifras).toInt();
      const max = -1;
      final random = Random();
      return min + random.nextInt(max - min + 1);
    } else {
      final min = pow(10, cifras - 1).toInt();
      final max = pow(10, cifras).toInt() - 1;
      final random = Random();
      return min + random.nextInt(max - min + 1);
    }
  }

  static bool getRandomBool() {
    final random = Random();
    return random.nextBool();
  }

  static int getRandomNumberMinMax(int min, int max) {
    final random = Random();    
    return min + random.nextInt(max - min + 1);

    
  }

  static int getMaxWithNumber(int number) {
    final cifras = number.toString().length;
    if(cifras <= 1){
      return 1;
    }
    String unidades = '1';

    for (int i = 0; i < cifras-1; i++) {
      unidades += '0';            
    }
    return int.parse(unidades);
  }
}
