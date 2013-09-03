// No deep compare of 2 lists in Dart, so we implement it ...
bool listsAreEqual(final List one, final List two) {
  var i = -1;
  return one.every((element) {
    i++;

    return two[i] == element;
  });
}