class Part {
  final String code, nameEn, nameSi;
  final int page;
  final String? parentCode;

  Part.fromCsv(List<dynamic> row)
      : code       = row[0] as String,
        nameEn     = row[1] as String,
        nameSi     = row[2] as String,
        page       = int.parse(row[3].toString()),
        parentCode = row[4].toString().isEmpty ? null : row[4] as String;
}