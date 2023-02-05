class Company {
  String id;
  String companyName;

  Company({
    this.id='',
    required this.companyName,
  });

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'id': id,
    };
  }

  static Company fromJson(Map<String, dynamic> json) {
    return Company(
      companyName: json['companyName'],
      id: json['id'],
    );
  }
}
