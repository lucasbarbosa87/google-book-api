import 'dart:convert';

class Authors {
  List<String> authors;
  Authors({
    required this.authors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authors': authors,
    };
  }

  factory Authors.fromMap(Map<String, dynamic> map) {
    return Authors(
      authors: List<String>.from((map['authors'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Authors.fromJson(String source) =>
      Authors.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Authors.build(data) {
    if (data is String) {
      return Authors(authors: []);
    }
    var temp = (data as List<dynamic>).map((e) => e.toString()).toList();
    if (temp.isEmpty) {
      return Authors(authors: []);
    }
    return Authors(authors: temp);
  }
}
