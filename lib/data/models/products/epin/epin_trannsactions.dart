import 'dart:convert';

String epinTransactionRequestsResponseToJson(
        EpinTransactionRequestsResponse data) =>
    json.encode(data.toJson());

class EpinTransactionRequestsResponse {
  final String? status;
  final Data? data;

  EpinTransactionRequestsResponse({
    this.status,
    this.data,
  });

  factory EpinTransactionRequestsResponse.fromJson(Map<String, dynamic> json) =>
      EpinTransactionRequestsResponse(
        status: json['status'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  final int? currentPage;
  final List<Datum>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] as int?,
        data: json["data"] == null
            ? []
            : List<Datum>.from((json["data"] as List<dynamic>)
                .map((x) => Datum.fromJson(x as Map<String, dynamic>))),
        firstPageUrl: json["first_page_url"] as String?,
        from: json["from"] as int?,
        lastPage: json["last_page"] as int?,
        lastPageUrl: json["last_page_url"] as String?,
        links: json["links"] == null
            ? []
            : List<Link>.from((json["links"] as List<dynamic>)
                .map((x) => Link.fromJson(x as Map<String, dynamic>))),
        nextPageUrl: json["next_page_url"] as String?,
        path: json["path"] as String?,
        perPage: json["per_page"] as int?,
        prevPageUrl: json["prev_page_url"] as String?,
        to: json["to"] as int?,
        total: json["total"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  final int? id;
  final int? userId;
  final dynamic reference;
  final String? agentName;
  final String? agentEmail;
  final String? agentPhone;
  final String? businessName;
  final String? network;
  final String? amount;
  final int? quantity;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.reference,
    this.agentName,
    this.agentEmail,
    this.agentPhone,
    this.businessName,
    this.network,
    this.amount,
    this.quantity,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        reference: json['reference'],
        agentName: json['agent_name'] as String?,
        agentEmail: json['agent_email'] as String?,
        agentPhone: json['agent_phone'] as String?,
        businessName: json['business_name'] as String?,
        network: json['network'] as String?,
        amount: json['amount'] as String?,
        quantity: json['quantity'] as int?,
        status: json['status'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "reference": reference,
        "agent_name": agentName,
        "agent_email": agentEmail,
        "agent_phone": agentPhone,
        "business_name": businessName,
        "network": network,
        "amount": amount,
        "quantity": quantity,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] as String?,
        label: json["label"] as String?,
        active: json["active"] as bool?,
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
