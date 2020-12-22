class Sex {
  static int Man = 0;
  static int Girl = 1;
  static int Other = 2;

  static String getDescription(int sex) {
    if (sex == Man) {
      return "Парень";
    } else if (sex == Girl) {
      return "Девушка";
    } else {
      return "Другое";
    }
  }
}
