extension DoubeExtensions on double {
  String clean() {
    if (this % 1 == 0) {
      return toInt().toString();
    }
    return toString();
  }
}
