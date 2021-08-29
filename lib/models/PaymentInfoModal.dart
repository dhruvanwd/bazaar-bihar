class PaymentInfoModal {
  final double totalMrp;
  final double totalSp;
  final List<Map> shopWiseInfo;

  PaymentInfoModal(
      {required this.shopWiseInfo,
      required this.totalMrp,
      required this.totalSp});

  factory PaymentInfoModal.fromJson(Map<String, dynamic> json) =>
      PaymentInfoModal(
          shopWiseInfo: json['shopWiseInfo'],
          totalMrp: json['totalMrp'],
          totalSp: json['totalSp']);

  toJson() {
    return Map.from(
        {shopWiseInfo: shopWiseInfo, totalMrp: totalMrp, totalSp: totalSp});
  }
}
