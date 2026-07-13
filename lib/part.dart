class Part {
  final String code, nameEn, nameSi;
  final int page;
  final String? parentCode;

  Part.fromCsv(List<dynamic> row)
      : code       = row.isNotEmpty ? row[0].toString() : '',
        nameEn     = row.length > 1 ? row[1].toString() : '',
        nameSi     = row.length > 2 ? row[2].toString() : '',
        page       = row.length > 3 ? int.tryParse(row[3].toString()) ?? 1 : 1,
        parentCode = row.length > 4 && row[4].toString().isNotEmpty ? row[4].toString() : null;
}