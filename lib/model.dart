class Model {
  final int number;
  final String title;
  final String originalTitle;
  final String releaseDate;
  final String description;
  final int pages;
  final String cover;

  Model(
      {required this.number,
      required this.title,
      required this.originalTitle,
      required this.releaseDate,
      required this.description,
      required this.pages,
      required this.cover});

 factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      number: json['number'] ?? 0,
      title: json['title'] ?? 'Без названия',
      originalTitle: json['originalTitle'] ?? 'No title',
      releaseDate: json['releaseDate'] ?? 'Неизвестно',
      description: json['description'] ?? 'Описание отсутствует',
      pages: json['pages'] ?? 0,
      cover: json['cover'] ?? '',
    );
  }
}

