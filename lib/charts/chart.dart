class Chart {
  final int chartValue;
  final String color;
  final String chartClass;
  final String classUrl;
  final String className;

  Chart(
    this.chartValue,
    this.color,
    this.chartClass,
    this.classUrl,
    this.className,
  );

  Chart.fromMap(Map<String, dynamic> map)
      : assert(map['Value'] != null),
        assert(map['color'] != null),
        assert(map['class'] != null),
        assert(map['name'] != null),
        assert(map['url'] != null),
        chartValue = map['Value'],
        color = map['color'],
        chartClass = map['class'],
        classUrl = map['url'],
        className = map['name'];

  @override
  String toString() =>
      "Record<$chartValue:$color:$chartClass:$classUrl:$className>";
}
