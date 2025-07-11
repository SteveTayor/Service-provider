class DashboardDataRequest {
  final dynamic month;
  final dynamic year;

  DashboardDataRequest({
    this.month,
    this.year,
  });

  factory DashboardDataRequest.fromJson(Map<String, dynamic> json) =>
      DashboardDataRequest(
        month: json["month"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "year": year,
      };
}
