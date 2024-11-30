import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/domain/models/user_model.dart';

class BookmarkModel {
  final int bookmarkID;
  final UserModel user;
  final JobModel job;

  BookmarkModel({
    required this.bookmarkID,
    required this.user,
    required this.job,
  });

  // Factory constructor for JSON parsing
  factory BookmarkModel.fromJson(Map json) {
    return BookmarkModel(
      bookmarkID: json['bookmarkID'],
      user: UserModel.fromJson(json['user']),
      job: JobModel.fromMap(json['job']),
    );
  }

  // Convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'bookmarkID': bookmarkID,
      'user': user.toJson(),
      'job': job.toMap(),
    };
  }
}
