class Import {
  int id;
  String name;
  double total;
  Import({this.id, this.name, this.total});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'total': total,
  };

  factory Import.fromJson(Map<String, dynamic> json) {
    return Import(id: json['id'],
        name: json['name'], total: json['total']);
  }
}

class Export {
  int id;
  String name;
  double total;
  Export({this.id, this.name, this.total});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'total': total,
  };

  factory Export.fromJson(Map<String, dynamic> json) {
    return Export(id: json['id'],
        name: json['name'], total: json['total']);
  }
}

class ImEx {
  int id;
  Import im;
  Export ex;
}