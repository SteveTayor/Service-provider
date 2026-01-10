class AddBankResponse {
  final String? status;
  final Data? data;
  final String? message;

  AddBankResponse({
    required this.status,
    this.data,
    required this.message,
  });

  // factory AddBankResponse.fromJson(Map<String, dynamic> json) =>
  //     AddBankResponse(
  //       status: json["status"] as String?,
  //       data: json["data"] == null
  //           ? null
  //           : Data.fromJson(json["data"] as Map<String, dynamic>),
  //       message: json["message"] as String?,
  //     );
  factory AddBankResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    return AddBankResponse(
      status: json['status']?.toString(),
      data: rawData is Map<String, dynamic> ? Data.fromJson(rawData) : null,
      message: json['message']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  final Attributes? attributes;
  final Attributes? request;
  final Attributes? query;
  final Attributes? server;
  final Attributes? files;
  final Attributes? cookies;
  final Attributes? headers;

  Data({
    this.attributes,
    this.request,
    this.query,
    this.server,
    this.files,
    this.cookies,
    this.headers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attributes: json["attributes"] == null
            ? null
            : Attributes.fromJson(json["attributes"] as Map<String, dynamic>),
        request: json["request"] == null
            ? null
            : Attributes.fromJson(json["request"] as Map<String, dynamic>),
        query: json["query"] == null
            ? null
            : Attributes.fromJson(json["query"] as Map<String, dynamic>),
        server: json["server"] == null
            ? null
            : Attributes.fromJson(json["server"] as Map<String, dynamic>),
        files: json["files"] == null
            ? null
            : Attributes.fromJson(json["files"] as Map<String, dynamic>),
        cookies: json["cookies"] == null
            ? null
            : Attributes.fromJson(json["cookies"] as Map<String, dynamic>),
        headers: json["headers"] == null
            ? null
            : Attributes.fromJson(json["headers"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes?.toJson(),
        "request": request?.toJson(),
        "query": query?.toJson(),
        "server": server?.toJson(),
        "files": files?.toJson(),
        "cookies": cookies?.toJson(),
        "headers": headers?.toJson(),
      };
}

class Attributes {
  Attributes();

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes();

  Map<String, dynamic> toJson() => {};
}
