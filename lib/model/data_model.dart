class DataModel {
  DataModel({
    this.expression,
    this.image,
    this.quotation,
    this.audio,
    this.video,
    this.holyQuran,
  });

  DataModel.fromJson(dynamic json) {
    expression = json['expression'];
    image = json['image'];
    quotation =
        json['quotation'] != null ? json['quotation'].cast<String>() : [];
    audio = json['audio'];
    video = json['video'];
    holyQuran = json['holy_quran'] != null
        ? HolyQuran.fromJson(json['holy_quran'])
        : null;
  }

  String? expression;
  String? image;
  List<String>? quotation;
  String? audio;
  String? video;
  HolyQuran? holyQuran;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['expression'] = expression;
    map['image'] = image;
    map['quotation'] = quotation;
    map['audio'] = audio;
    map['video'] = video;
    if (holyQuran != null) {
      map['holy_quran'] = holyQuran?.toJson();
    }
    return map;
  }
}

class HolyQuran {
  HolyQuran({
    this.verse,
    this.arabic,
    this.urdu,
    this.english,
  });

  HolyQuran.fromJson(dynamic json) {
    verse = json['verse'];
    arabic = json['arabic'];
    urdu = json['urdu'];
    english = json['english'];
  }

  String? verse;
  String? arabic;
  String? urdu;
  String? english;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['verse'] = verse;
    map['arabic'] = arabic;
    map['urdu'] = urdu;
    map['english'] = english;
    return map;
  }
}
