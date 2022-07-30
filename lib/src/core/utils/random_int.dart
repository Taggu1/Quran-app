import 'dart:math';

int getRandomInt(int length) {
  Random random = Random();
  int randomNumber = random.nextInt(length);
  return randomNumber;
}
