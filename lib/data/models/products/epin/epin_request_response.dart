// To parse this JSON data, do
//
//     final epinRequestResponse = epinRequestResponseFromJson(jsonString);

import 'dart:convert';

EpinRequestResponse epinRequestResponseFromJson(String str) =>
    EpinRequestResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String epinRequestResponseToJson(EpinRequestResponse data) =>
    json.encode(data.toJson());

class EpinRequestResponse {
  final String? name;
  final String? agentEmail;
  final String? agentName;
  final String? agentPhone;
  final String? businessName;
  final String? network;
  final String? amount;
  final String? quantity;
  final String? email;

  EpinRequestResponse({
    this.name,
    this.agentEmail,
    this.agentName,
    this.agentPhone,
    this.businessName,
    this.network,
    this.amount,
    this.quantity,
    this.email,
  });

  factory EpinRequestResponse.fromJson(Map<String, dynamic> json) =>
      EpinRequestResponse(
        name: json["name"] as String?,
        agentEmail: json["agent_email"] as String?,
        agentName: json["agent_name"] as String?,
        agentPhone: json["agent_phone"] as String?,
        businessName: json["business_name"] as String?,
        network: json["network"] as String?,
        amount: json["amount"] as String?,
        quantity: json["quantity"] as String?,
        email: json["email"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "agent_email": agentEmail,
        "agent_name": agentName,
        "agent_phone": agentPhone,
        "business_name": businessName,
        "network": network,
        "amount": amount,
        "quantity": quantity,
        "email": email,
      };
}
