class DashboardDataResponse {
  final String? status;
  final DashboardData? data;
  final String? message;

  DashboardDataResponse({
    this.status,
    this.data,
    this.message,
  });

  factory DashboardDataResponse.fromJson(Map<String, dynamic> json) {
    return DashboardDataResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] is Map<String, dynamic>
          ? DashboardData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}

class DashboardData {
  final List<BarDatum> barData;
  final List<DoughnutDatum> doughnutData;

  DashboardData({
    this.barData = const [],
    this.doughnutData = const [],
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      barData: (json['barData'] as List<dynamic>?)
              ?.whereType<Map<String, dynamic>>()
              .map((e) => BarDatum.fromJson(e))
              .toList() ??
          [],
      doughnutData: (json['doughnutData'] as List<dynamic>?)
              ?.whereType<Map<String, dynamic>>()
              .map((e) => DoughnutDatum.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'barData': barData.map((e) => e.toJson()).toList(),
        'doughnutData': doughnutData.map((e) => e.toJson()).toList(),
      };
}

class BarDatum {
  final String day;
  final int amount;

  BarDatum({
    this.day = '',
    this.amount = 0,
  });

  factory BarDatum.fromJson(Map<String, dynamic> json) => BarDatum(
        day: json['day'] as String? ?? '',
        amount: json['amount'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'amount': amount,
      };
}

class DoughnutDatum {
  final String label;
  final int value;

  DoughnutDatum({
    this.label = '',
    this.value = 0,
  });

  factory DoughnutDatum.fromJson(Map<String, dynamic> json) => DoughnutDatum(
        label: json['label'] as String? ?? '',
        value: json['value'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
      };
}
