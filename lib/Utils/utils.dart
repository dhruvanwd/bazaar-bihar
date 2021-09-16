isUserjson(var profile) {
  print("---------isUserjson----------");
  print(profile);
  return profile['fullName'] != null && profile['role'] != null;
}

final rupeeSymbol = "₹";
muliPrint(List<dynamic> arguments) {
  arguments.forEach((element) => print(element));
}

calculateDiscount(mrp, sp) {
  final a = mrp is String ? double.parse(mrp) : mrp;
  final b = sp is String ? double.parse(sp) : sp;
  assert(a > b);
  return ((((a - b) / (a + b))) * 100).toStringAsFixed(2);
}
