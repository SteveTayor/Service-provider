import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

final squadPaymentProvider = StateNotifierProvider<SquadPaymentNotifier,
    AsyncValue<SquadPaymentResponse?>>((ref) => SquadPaymentNotifier(ref));

class SquadPaymentNotifier
    extends StateNotifier<AsyncValue<SquadPaymentResponse?>> {
  final Ref ref;
  SquadPaymentNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<SquadPaymentResponse?> initializeCardPayment({
    required int amount,
    required String email,
  }) async {
    state = const AsyncValue.loading();
    try {
      final transactionRef = 'BNG-${DateTime.now().millisecondsSinceEpoch}';
      final secretKey = dotenv.env['SQUAD_SECRET_KEY'] ?? '';

      final response = await http.post(
        Uri.parse('https://api-d.squadco.com/transaction/initiate'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${secretKey}',
        },
        body: jsonEncode({
          'amount': amount,
          'email': email,
          'currency': 'NGN',
          'transaction_ref': transactionRef,
          'callback_url': 'https://www.google.com',
          'initiate_type': 'inline',
        }),
      );

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      print('🔍 Squad init response: $decoded');

      if (response.statusCode == 200) {
        final squadResponse = SquadPaymentResponse.fromJson(decoded);
        print('✅ squadResponse after fromJson: $squadResponse');
        final checkoutUrl = squadResponse.data?.checkoutUrl;
        print("checkouturl is: $checkoutUrl");
        // await launchUrl(
        //   Uri.parse(checkoutUrl!),
        //   mode: LaunchMode.externalApplication,
        // );
        state = AsyncValue.data(squadResponse);
        // context.pop();
        // context.showErrorSnackBar("Failed to initialize payment.");
        // }

        return squadResponse;
      } else {
        state = AsyncValue.error(
          decoded['message']?.toString() ?? 'Failed to initialize payment',
          StackTrace.current,
        );
        return null;
      }
    } catch (e, st) {
      state = AsyncValue.error('Exception: $e', st);
      return null;
    }
  }
}

class SquadPaymentResponse {
  int? status;
  bool? success;
  String? message;
  Data? data;

  SquadPaymentResponse({this.status, this.success, this.message, this.data});

  factory SquadPaymentResponse.fromJson(Map<String, dynamic> json) =>
      SquadPaymentResponse(
        status: json['status'] as int,
        success: json['success'] as bool,
        message: json['message'] as String,
        data: json['data'] != null
            ? Data.fromJson(json['data'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'status': status ?? 0,
        'success': success ?? false,
        'message': message ?? '',
        'data': data?.toJson(),
      };
}

class Data {
  MerchantInfo? merchantInfo;
  String? currency;
  Recurring? recurring;
  bool? isRecurring;
  String? callbackUrl;
  String? transactionRef;
  int? transactionAmount;
  List<String>? authorizedChannels;
  String? checkoutUrl;
  bool? allowRecurring;
  List<BankList>? bankList;

  Data({
    this.merchantInfo,
    this.currency,
    this.recurring,
    this.isRecurring,
    this.callbackUrl,
    this.transactionRef,
    this.transactionAmount,
    this.authorizedChannels,
    this.checkoutUrl,
    this.allowRecurring,
    this.bankList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        merchantInfo: json['merchant_info'] == null
            ? null
            : MerchantInfo.fromJson(
                json['merchant_info'] as Map<String, dynamic>),
        currency: json['currency'] as String?,
        recurring: json['recurring'] == null
            ? null
            : Recurring.fromJson(json['recurring'] as Map<String, dynamic>),
        isRecurring: json['is_recurring'] as bool?,
        callbackUrl: json['callback_url'] as String?,
        transactionRef: json['transaction_ref'] as String?,
        transactionAmount: json['transaction_amount'] as int?,
        authorizedChannels: json["authorized_channels"] is List
            ? List<String>.from(
                (json["authorized_channels"] as List).map((x) => x.toString()),
              )
            : [],
        checkoutUrl: json['checkout_url'] as String?,
        allowRecurring: json['allow_recurring'] as bool?,
        bankList: (json['bank_list'] as List<dynamic>)
            .map((e) => BankList.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'merchant_info': merchantInfo?.toJson(),
        'currency': currency,
        'recurring': recurring?.toJson(),
        'is_recurring': isRecurring,
        'callback_url': callbackUrl,
        'transaction_ref': transactionRef,
        'transaction_amount': transactionAmount,
        'authorized_channels': authorizedChannels == null
            ? []
            : List<dynamic>.from(authorizedChannels!.map((x) => x)),
        'checkout_url': checkoutUrl,
        'allow_recurring': allowRecurring,
        'bank_list': bankList == null
            ? []
            : List<dynamic>.from(bankList!.map((x) => x.toJson())),
      };
}

class BankList {
  String? code;
  String? name;
  String? description;

  BankList({this.code, this.name, this.description});

  factory BankList.fromJson(Map<String, dynamic> json) => BankList(
        code: json['code'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'description': description,
      };
}

class MerchantInfo {
  String? merchantName;
  String? merchantId;

  MerchantInfo({this.merchantName, this.merchantId});

  factory MerchantInfo.fromJson(Map<String, dynamic> json) => MerchantInfo(
        merchantName: json['merchant_name'] as String,
        merchantId: json['merchant_id'] as String,
      );

  Map<String, dynamic> toJson() => {
        'merchant_name': merchantName,
        'merchant_id': merchantId,
      };
}

class Recurring {
  int? type;

  Recurring({this.type});

  factory Recurring.fromJson(Map<String, dynamic> json) =>
      Recurring(type: json['type'] as int);

  Map<String, dynamic> toJson() => {'type': type};
}
