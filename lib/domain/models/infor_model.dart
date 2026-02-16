class InfoModel {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  InfoModel({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      count: json['count'] ?? 0,
      pages: json['pages'] ?? 0,
      next: json['next'],
      prev: json['prev'],
    );
  }
}
