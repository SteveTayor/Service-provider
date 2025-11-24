class PromoModel {
  final String id;
  final String code;
  final String title;
  final String description;
  final double amount;
  final bool? isClaimed;
  final String? backgroundColor;
  final String? textColor;

  const PromoModel({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.amount,
    this.isClaimed,
    this.backgroundColor,
    this.textColor,
  });

  PromoModel copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    double? amount,
    bool? isClaimed,
    String? backgroundColor,
    String? textColor,
  }) {
    return PromoModel(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      isClaimed: isClaimed ?? this.isClaimed,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }
}
