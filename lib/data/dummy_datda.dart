import 'package:bundlegram/data/models/wallet/service_model.dart';

/// A globally accessible dummy list of ServiceModel entries.
/// Replace or comment this out when hooking up real API calls.
final List<ServiceModel> dummyTransactions = [
  ServiceModel(
    id: 'TXN10001',
    title: 'Top-Up',
    type: 'top-up',
    status: 'successful',
    amount: '₦5,000.00',
    date: '06-06-2025', // Today
    description: 'Added funds to wallet',
  ),
  ServiceModel(
    id: 'TXN10009',
    title: 'Top-Up',
    type: 'top-up',
    status: 'failed',
    amount: '₦6,000.00',
    date: '29-05-2025', // 8 days ago
    description: 'Failed to add funds',
  ),
  ServiceModel(
    id: 'TXN10010',
    title: 'Top-Up',
    type: 'top-up',
    status: 'successful',
    amount: '₦3,000.00',
    date: '01-06-2025', // 5 days ago
    description: 'Added funds to wallet',
  ),
  ServiceModel(
    id: 'TXN10018',
    title: 'Top-Up',
    type: 'top-up',
    status: 'failed',
    amount: '₦2,000.00',
    date: '04-06-2025', // 2 days ago
    description: 'Failed to add funds',
  ),

  // Withdrawal
  ServiceModel(
    id: 'TXN10002',
    title: 'Withdrawal',
    type: 'withdrawal',
    status: 'pending',
    amount: '₦2,500.00',
    date: '05-06-2025', // Yesterday
    description: 'Sent to bank account',
  ),
  ServiceModel(
    id: 'TXN10011',
    title: 'Withdrawal',
    type: 'withdrawal',
    status: 'successful',
    amount: '₦4,000.00',
    date: '03-06-2025', // 3 days ago
    description: 'Withdrawn to bank',
  ),
  ServiceModel(
    id: 'TXN10019',
    title: 'Withdrawal',
    type: 'withdrawal',
    status: 'pending',
    amount: '₦3,500.00',
    date: '02-06-2025', // 4 days ago
    description: 'Pending bank transfer',
  ),

  // Betting
  ServiceModel(
    id: 'TXN10003',
    title: 'Betting',
    type: 'betting',
    status: 'successful',
    amount: '₦2,000.00',
    date: '04-06-2025', // 2 days ago
    description: 'Bet on football match',
  ),
  ServiceModel(
    id: 'TXN10012',
    title: 'Betting',
    type: 'betting',
    status: 'failed',
    amount: '₦1,500.00',
    date: '02-06-2025', // 4 days ago
    description: 'Betting transaction failed',
  ),
  ServiceModel(
    id: 'TXN10020',
    title: 'Betting',
    type: 'betting',
    status: 'successful',
    amount: '₦3,000.00',
    date: '05-06-2025', // Yesterday
    description: 'Bet on basketball game',
  ),

  // Airtime
  ServiceModel(
    id: 'TXN10004',
    title: 'Airtime',
    type: 'airtime',
    status: 'failed',
    amount: '₦1,200.00',
    date: '03-06-2025', // 3 days ago
    description: 'MTN airtime purchase',
  ),
  ServiceModel(
    id: 'TXN10013',
    title: 'Airtime',
    type: 'airtime',
    status: 'successful',
    amount: '₦500.00',
    date: '05-06-2025', // Yesterday
    description: 'Glo airtime purchase',
  ),
  ServiceModel(
    id: 'TXN10021',
    title: 'Airtime',
    type: 'airtime',
    status: 'successful',
    amount: '₦200.00',
    date: '01-06-2025', // 5 days ago
    description: '9mobile airtime',
  ),

  // Mobile Data
  ServiceModel(
    id: 'TXN10005',
    title: 'Mobile Data',
    type: 'mobile data',
    status: 'successful',
    amount: '₦1,000.00',
    date: '02-06-2025', // 4 days ago
    description: 'MTN 1GB data',
  ),
  ServiceModel(
    id: 'TXN10014',
    title: 'Mobile Data',
    type: 'mobile data',
    status: 'successful',
    amount: '₦2,000.00',
    date: '04-06-2025', // 2 days ago
    description: 'Airtel 2GB data',
  ),
  ServiceModel(
    id: 'TXN10022',
    title: 'Mobile Data',
    type: 'mobile data',
    status: 'failed',
    amount: '₦1,500.00',
    date: '31-05-2025', // 6 days ago
    description: 'Data purchase failed',
  ),

  // Cable TV
  ServiceModel(
    id: 'TXN10006',
    title: 'Cable TV',
    type: 'cable tv',
    status: 'successful',
    amount: '₦3,500.00',
    date: '06-01-2025', // 5 days ago
    description: 'DSTV monthly subscription',
  ),
  ServiceModel(
    id: 'TXN10015',
    title: 'Cable TV',
    type: 'cable tv',
    status: 'pending',
    amount: '₦4,000.00',
    date: '06-06-2025', // Today
    description: 'GOTV subscription',
  ),
  ServiceModel(
    id: 'TXN10023',
    title: 'Cable TV',
    type: 'cable tv',
    status: 'successful',
    amount: '₦2,500.00',
    date: '06-03-2025', // 3 days ago
    description: 'Startimes subscription',
  ),

  // Electricity Bill
  ServiceModel(
    id: 'TXN10007',
    title: 'Electricity Bill',
    type: 'electricity',
    status: 'pending',
    amount: '₦4,800.00',
    date: '31-05-2025', // 6 days ago
    description: 'EKEDC prepaid token',
  ),
  ServiceModel(
    id: 'TXN10016',
    title: 'Electricity Bill',
    type: 'electricity',
    status: 'successful',
    amount: '₦3,000.00',
    date: '03-06-2025', // 3 days ago
    description: 'IKEDC postpaid bill',
  ),
  ServiceModel(
    id: 'TXN10024',
    title: 'Electricity Bill',
    type: 'electricity',
    status: 'failed',
    amount: '₦2,000.00',
    date: '04-06-2025', // 2 days ago
    description: 'Payment failed',
  ),

  // E-Pin Voucher
  ServiceModel(
    id: 'TXN10008',
    title: 'E-Pin Voucher',
    type: 'e-pin voucher',
    status: 'successful',
    amount: '₦500.00',
    date: '05-30-2025', // 7 days ago
    description: 'Recharge card purchase',
  ),
  ServiceModel(
    id: 'TXN10017',
    title: 'E-Pin Voucher',
    type: 'e-pin voucher',
    status: 'successful',
    amount: '₦1,000.00',
    date: '05-06-2025', // Yesterday
    description: 'WAEC pin purchase',
  ),
  ServiceModel(
    id: 'TXN10025',
    title: 'E-Pin Voucher',
    type: 'e-pin voucher',
    status: 'pending',
    amount: '₦800.00',
    date: '06-06-2025', // Today
    description: 'Pending voucher generation',
  ),
];
