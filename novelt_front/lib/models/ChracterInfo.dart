class ChracterInfo{
  final String name, age, gender, personality, hairstyle, clothes, appearance;

  ChracterInfo({
    required this.name, // 필수
    required this.age, // 필수
    this.gender="",
    required this.personality, // 필수
    required this.hairstyle,
    required this.clothes,
    required this.appearance // 필수
  });

  // json 형식으로 넘겨받을 경우
  ChracterInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'],
        gender=json['gender'],
        personality = json['personality'],
        hairstyle = json['hairstyle'],
        clothes = json['clothes'],
        appearance = json['appearance'];
  Map<String, dynamic> toJson() {
    return {
      '이름': name,
      '나이': age,
      '성별': gender,
      '성격': personality,
      '헤어스타일': hairstyle,
      '옷': clothes,
      '외형': appearance,
    };
  }
}


