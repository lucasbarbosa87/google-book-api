import 'dart:convert';

import 'list_price.dart';
import 'retail_price.dart';

class Offer {
  int? finskyOfferType;
  ListPrice? listPrice;
  RetailPrice? retailPrice;
  bool? giftable;

  Offer({
    this.finskyOfferType,
    this.listPrice,
    this.retailPrice,
    this.giftable,
  });

  factory Offer.fromMap(Map<String, dynamic> data) => Offer(
        finskyOfferType: data['finskyOfferType'] as int?,
        listPrice: data['listPrice'] == null
            ? null
            : ListPrice.fromMap(data['listPrice'] as Map<String, dynamic>),
        retailPrice: data['retailPrice'] == null
            ? null
            : RetailPrice.fromMap(data['retailPrice'] as Map<String, dynamic>),
        giftable: data['giftable'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'finskyOfferType': finskyOfferType,
        'listPrice': listPrice?.toMap(),
        'retailPrice': retailPrice?.toMap(),
        'giftable': giftable,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Offer].
  factory Offer.fromJson(String data) {
    return Offer.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Offer] to a JSON string.
  String toJson() => json.encode(toMap());
}
