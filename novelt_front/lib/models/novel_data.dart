class SelectNovelData {
  final int novelId;
  final List<PageData> novelData;

  SelectNovelData({
    required this.novelId,
    required this.novelData,
  });

  factory SelectNovelData.fromJson(Map<String, dynamic> json) {
    return SelectNovelData(
      novelId: json['novel_id'],
      novelData: List<PageData>.from(json['noveldata'].map((x) => PageData.fromJson(x))),
    );
  }
}

class PageData {
  String subtitle;
  final int sceneNumber;
  final List<String> imageUrls;

  PageData({
    required this.subtitle,
    required this.sceneNumber,
    required this.imageUrls,
  });

  factory PageData.fromJson(List<dynamic> json) {
    return PageData(
      subtitle: json[0],
      sceneNumber: json[1],
      imageUrls: List<String>.from(json[2]),
    );
  }
}
