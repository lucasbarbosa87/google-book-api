import 'dart:convert';

class Categories {
  List<String> categories;
  Categories({
    required this.categories,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Categories': categories,
    };
  }

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      categories: List<String>.from((map['Categories'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Categories.fromJson(String source) =>
      Categories.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Categories.build(data) {
    if (data is String) {
      return Categories(categories: []);
    }
    var temp = (data as List<dynamic>).map((e) => e.toString()).toList();
    if (temp.isEmpty) {
      return Categories(categories: []);
    }
    return Categories(categories: temp);
  }
}
