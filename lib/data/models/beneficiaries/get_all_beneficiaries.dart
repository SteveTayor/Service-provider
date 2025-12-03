import 'dart:convert';

GetAllBeneficiariesResponse getAllBeneficiariesResponseFromJson(String str) =>
    GetAllBeneficiariesResponse.fromJson(
        json.decode(str) as Map<String, dynamic>);

String getAllBeneficiariesResponseToJson(GetAllBeneficiariesResponse data) =>
    json.encode(data.toJson());

class GetAllBeneficiariesResponse {
  final String? status;
  final List<Beneficiary>? data;
  final String? message;

  GetAllBeneficiariesResponse({
    this.status,
    this.data,
    this.message,
  });

  factory GetAllBeneficiariesResponse.fromJson(Map<String, dynamic> json) =>
      GetAllBeneficiariesResponse(
        status: json['status'] as String?,
        data: json['data'] == null
            ? <Beneficiary>[]
            : List<Beneficiary>.from((json['data'] as List<dynamic>)
                .map<Beneficiary>(
                    (x) => Beneficiary.fromJson(x as Map<String, dynamic>))),
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
      };
}

class Beneficiary {
  final int? id;
  final String? network;
  final String? phoneNumber;

  Beneficiary({
    this.id,
    this.network,
    this.phoneNumber,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
        id: json['id'] as int?,
        network: json['network'] as String?,
        phoneNumber: json['phone_number'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'network': network,
        'phone_number': phoneNumber,
      };
}
