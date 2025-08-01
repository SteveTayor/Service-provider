class TransactionSuccessArgs {
  final String title;
  final String subTitle;
  final bool isBasicInfo;

  const TransactionSuccessArgs({
    required this.title,
    required this.subTitle,
    this.isBasicInfo = false,
  });
}
