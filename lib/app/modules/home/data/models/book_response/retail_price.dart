import 'dart:convert';

class RetailPrice {
  double? amount;
  String? currencyCode;

  RetailPrice({this.amount, this.currencyCode});

  factory RetailPrice.fromMap(Map<String, dynamic> data) => RetailPrice(
        amount: (data['amount'] as num?)?.toDouble(),
        currencyCode: data['currencyCode'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'amount': amount,
        'currencyCode': currencyCode,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RetailPrice].
  factory RetailPrice.fromJson(String data) {
    return RetailPrice.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RetailPrice] to a JSON string.
  String toJson() => json.encode(toMap());
}
