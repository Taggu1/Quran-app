import 'dart:math';

int getRandomInt(int length) {
  Random random = new Random();
  int randomNumber = random.nextInt(length);
  return randomNumber;
}
