// /**
//  * Expected print result:
//  * b
//  * be
//  * bee
//  * beev
//  * beeve
//  */

// ignore_for_file: avoid_print

class Asterix {
  String word = "beever";

  static void run() {
    Asterix asterix = Asterix();
    for (int i = 0; i < asterix.word.length - 1; i++) {
      print(asterix.word.substring(0, i + 1));
    }
  }
}

void main() {
  Asterix.run();
}
