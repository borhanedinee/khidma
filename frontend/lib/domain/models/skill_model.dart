class SkillModel {
  final int id;
  final int userId;
  final String skill;

  SkillModel({
    required this.id,
    required this.userId,
    required this.skill,
  });

  // Factory method to create a SkillModel from JSON
  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['id'],
      userId: json['userid'],
      skill: json['skill'],
    );
  }

  // Method to convert a SkillModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userId,
      'skill': skill,
    };
  }
}
