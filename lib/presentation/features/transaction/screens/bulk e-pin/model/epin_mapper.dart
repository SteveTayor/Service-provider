import 'package:bundlegram/data/models/products/epin/epin_trannsactions.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';

extension DatumToUserTransactions on Datum {
  UserTransactions toUserTransactions() {
    Product? fakeProduct;
    SubProduct? fakeSubProduct;

    try {
      fakeProduct = Product(productName: network ?? 'E-pin Voucher');
      fakeSubProduct =
          SubProduct(subName: businessName ?? 'E-pin', product: fakeProduct);
    } catch (_) {
      fakeProduct = null;
      fakeSubProduct = null;
    }

    return UserTransactions(
      id: id,
      userId: userId,
      subProdId: null,
      transType: 'e_pin',
      amount: amount?.toString(),
      crAcc: agentPhone, // show agent phone in the receipt if useful
      trxFrom: null,
      deductAmount:
          (amount == null) ? null : double.tryParse(amount!.toString()),
      transRef: reference?.toString() ?? 'EPIN-${id ?? ''}',
      autoRef: null,
      token: null,
      unit: null,
      cardPin: null,
      cardSerialNo: null,
      status: status,
      isActive: null,
      balanceBefore: null,
      balanceAfter: null,
      paymentType: null,
      channel: null,
      platform: null,
      macAddress: null,
      ipAddress: null,
      longitude: null,
      latitude: null,
      createdAt: createdAt,
      updatedAt: updatedAt,
      subProduct: fakeSubProduct,
      bank: null,
    );
  }
}
