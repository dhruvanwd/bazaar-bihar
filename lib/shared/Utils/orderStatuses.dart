enum OrderStatus {
  INITIATED,
  ACCEPTED,
  REJECTED,
  CANCELLED,
  IN_TRANSIT,
  DELIVERED
}

extension OrderStatusExtension on OrderStatus {
  String get name {
    switch (this) {
      case OrderStatus.INITIATED:
        return "INITIATED";
      case OrderStatus.ACCEPTED:
        return 'ACCEPTED';
      case OrderStatus.REJECTED:
        return "REJECTED";
      case OrderStatus.CANCELLED:
        return "CANCELLED";
      case OrderStatus.IN_TRANSIT:
        return "IN_TRANSIT";
      case OrderStatus.DELIVERED:
        return "DELIVERED";
    }
  }
}
