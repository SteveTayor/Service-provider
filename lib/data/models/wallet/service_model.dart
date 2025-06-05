// Universal service model that works for all service types
class ServiceModel {
  final String id;
  final String title;
  final String type; // 'betting', 'cable tv', 'education', 'mobile data', etc.
  final String status; // 'successful', 'failed', 'pending'
  final String amount;
  final String date;
  final String? bankName;
  final String? phoneNumber;
  final String? recipientName;
  final String? accountNumber;
  final String? iconUrl; // Optional icon URL for service providers
  final String? description; // Optional additional details

  ServiceModel({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    required this.amount,
    required this.date,
    this.accountNumber,
    this.bankName,
    this.phoneNumber,
    this.recipientName,
    this.iconUrl,
    this.description,
  });
}
