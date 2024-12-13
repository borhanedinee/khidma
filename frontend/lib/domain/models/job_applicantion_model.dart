class JobApplicationModel {
  final int id;
  final int jobId;
  final int applicantId;
  final int expectedSalary;
  final String applicantFullName;
  final String applicantEmail;
  final int applicantPhone;
  final String applicantResume;
  final DateTime createdAt;
  final String applicantAvatar;

  JobApplicationModel({
    required this.id,
    required this.jobId,
    required this.applicantId,
    required this.expectedSalary,
    required this.applicantFullName,
    required this.applicantEmail,
    required this.applicantPhone,
    required this.applicantResume,
    required this.createdAt,
    required this.applicantAvatar,
  });

  // Factory method to create a JobApplicationModel from JSON
  factory JobApplicationModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationModel(
      id: json['id'],
      jobId: json['job'],
      applicantId: json['applicant'],
      expectedSalary: json['expected_salary'],
      applicantFullName: json['applicant_fullname'],
      applicantEmail: json['applicant_email'],
      applicantPhone: json['applicant_phone'],
      applicantResume: json['applicant_resume'],
      createdAt: DateTime.parse(json['created_at']),
      applicantAvatar: json['applicantAvatar'],
    );
  }

  // Method to convert a JobApplicationModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job': jobId,
      'applicant': applicantId,
      'expected_salary': expectedSalary,
      'applicant_fullname': applicantFullName,
      'applicant_email': applicantEmail,
      'applicant_phone': applicantPhone,
      'applicant_resume': applicantResume,
      'created_at': createdAt.toIso8601String(),
      'applicantAvatar': applicantAvatar,
    };
  }
}
