class Model {
  final String fullName;
  final String nickname;
  final String hogwartsHouse;
  final String interpreteBy;
  final Object children;
  final String image;
  final String birthdate;

  Model({
    required this.fullName,
    required this.nickname,
    required this.hogwartsHouse,
    required this.interpreteBy,
    required this.children,
    required this.image,
    required this.birthdate,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      fullName: json['fullName'] ?? 0,
      nickname: json['nickname'] ?? 'Без названия',
      hogwartsHouse: json['hogwartsHouse'] ?? 'No title',
      interpreteBy: json['interpreteBy'] ?? 'Неизвестно',
      children: json['children'] ?? 'Описание отсутствует',
      image: json['image'] ?? 0,
      birthdate: json['birthdate'] ?? '',
    );
  }
}
