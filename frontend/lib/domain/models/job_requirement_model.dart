class JobRequirementModel {
  final int id;
  final int job;
  final String requirement;

  JobRequirementModel({
    required this.id,
    required this.job,
    required this.requirement,
  });

  // Factory method to create a JobRequirementModel from JSON
  factory JobRequirementModel.fromJson(Map<String, dynamic> json) {
    return JobRequirementModel(
      id: json['id'],
      job: json['job'],
      requirement: json['requirement'],
    );
  }

  // Method to convert a JobRequirementModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job': job,
      'requirement': requirement,
    };
  }
}
