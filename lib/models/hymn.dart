class Hymn {
  final int id;
  final String hymnNo;
  final String? title;
  final String body;

  const Hymn({
    required this.id,
    required this.hymnNo,
    this.title,
    required this.body,
  });

  factory Hymn.fromMap(Map<String, dynamic> json) => Hymn(
        id: json['id'],
        hymnNo: json['hymn_no'],
        title: json['title'],
        body: json['body'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hymn_no': hymnNo,
      'title': title,
      'body': body,
    };
  }
}
