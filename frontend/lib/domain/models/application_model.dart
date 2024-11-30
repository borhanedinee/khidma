import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/domain/models/user_model.dart';

class ApplicationModel {
  final int applicationId;
  final int applicationExpectedSalary;
  final String applicationCreatedAt;
  final String applicationResume;
  final String applicationFullname;
  final String applicationEmail;
  final int applicantPhone;
  final UserModel user;
  final JobModel job;

  ApplicationModel({
    required this.applicationId,
    required this.applicationExpectedSalary,
    required this.applicationCreatedAt,
    required this.applicationResume,
    required this.applicationFullname,
    required this.applicationEmail,
    required this.applicantPhone,
    required this.user,
    required this.job,
  });

  // Factory method to create an Application instance from JSON
  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      applicationId: json['application_id'],
      applicationExpectedSalary: json['application_expectedSalary'],
      applicationCreatedAt: json['application_createdAt'].toString(),
      applicationResume: json['application_resume'],
      applicationFullname: json['application_fullname'],
      applicationEmail: json['application_email'],
      applicantPhone: int.parse(json['applicant_phone'].toString()),
      user: UserModel.fromJson(json['user']),
      job: JobModel.fromMap(json['job']),
    );
  }

  // Method to convert an Application instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'application_expectedSalary': applicationExpectedSalary,
      'application_createdAt': applicationCreatedAt,
      'application_resume': applicationResume,
      'application_fullname': applicationFullname,
      'application_email': applicationEmail,
      'applicant_phone': applicantPhone,
      'user': user.toJson(),
      'job': job.toMap(),
    };
  }

  String timeAgo() {
    try {
      // Parse the timestamp into a DateTime object
      DateTime dateTime = DateTime.parse(applicationCreatedAt);
      DateTime now = DateTime.now();

      // Calculate the difference
      Duration difference = now.difference(dateTime);

      if (difference.inSeconds < 60) {
        return '${difference.inSeconds}s ago';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        int days = difference.inDays;
        int hours = difference.inHours % 24;
        return hours > 0 ? '${days}d ${hours}h ago' : '${days}d ago';
      } else if (difference.inDays < 30) {
        return '${(difference.inDays / 7).floor()}w ago';
      } else if (difference.inDays < 365) {
        return '${(difference.inDays / 30).floor()}mo ago';
      } else {
        return '${(difference.inDays / 365).floor()}y ago';
      }
    } catch (e) {
      // Handle invalid dates
      return "Invalid date";
    }
  }
}
