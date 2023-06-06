class SampleData {
  final String property1;
  final int property2;

  SampleData(this.property1, this.property2);

  factory SampleData.fromMap(Map<String, dynamic> map) {
    return SampleData(
      map['property1'] as String,
      map['property2'] as int,
    );
  }
}
