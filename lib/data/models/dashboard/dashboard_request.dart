class DashboardDataRequest {
  final int? month;
  final int? year;

  DashboardDataRequest({
    this.month,
    this.year,
  });

  factory DashboardDataRequest.fromJson(Map<String, dynamic> json) =>
      DashboardDataRequest(
        month: json["month"] as int?,
        year: json["year"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "year": year,
      };
}
