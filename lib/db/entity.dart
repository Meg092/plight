class Plan {
  int? id;
  String name;
  int rate;
  String? date;

  Plan({this.id, required this.name, required this.rate, this.date});

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id'] as int?,
      name: map['name'] as String,
      rate: map['rate'] as int,
      date: map['date'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'name': name, 'rate': rate, 'date': date};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
