class Config {
  final int id;
  final String key;
  final String value;

  const Config({
    required this.id,
    required this.key,
    required this.value,
  });

  factory Config.fromMap(Map<String, dynamic> json) =>
      Config(id: json['id'], key: json['key'], value: json['value'] ?? '');

  Map<String, dynamic> toMap() {
    return {'id': id, 'key': key, 'value': value};
  }
}
