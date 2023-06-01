import 'dart:convert';

class Epub {
  bool? isAvailable;
  String? acsTokenLink;

  Epub({this.isAvailable, this.acsTokenLink});

  factory Epub.fromMap(Map<String, dynamic> data) => Epub(
        isAvailable: data['isAvailable'] as bool?,
        acsTokenLink: data['acsTokenLink'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'isAvailable': isAvailable,
        'acsTokenLink': acsTokenLink,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Epub].
  factory Epub.fromJson(String data) {
    return Epub.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Epub] to a JSON string.
  String toJson() => json.encode(toMap());
}
