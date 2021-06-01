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
  ImEx({this.id, this.im, this.ex});

  Map<String, dynamic> toJson() => {
    'id': id,
    'ex': ex,
    'im': im,
  };

  factory ImEx.fromJson(Map<String, dynamic> json) {
    return ImEx(id: json['id'],
        im: json['im'] is Import ? json['im'] : Import.fromJson(json['im']), ex: json['ex'] is Export ? json['ex'] : Export.fromJson(json['ex']));
  }
}