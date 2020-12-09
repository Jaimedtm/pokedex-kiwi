String capitalize(String text) => text[0].toUpperCase() + text.substring(1);
String fixedIndex(int index) {
  String result;
  if (index > 99) {
    result = '#$index';
  } else if (index > 9) {
    result = '#0$index';
  } else {
    result = '#00$index';
  }
  return result;
}
