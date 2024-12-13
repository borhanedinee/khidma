class JobModel {
  final int id;
  final String title;
  final String type;
  final String category;
  final String location;
  final String company;
  final String companyLogo;
  final double salary;
  final String description;
  final int recruiter;
  final DateTime postedAt;

  JobModel({
    required this.id,
    required this.title,
    required this.type,
    required this.category,
    required this.location,
    required this.company,
    required this.companyLogo,
    required this.salary,
    required this.description,
    required this.recruiter,
    required this.postedAt,
  });

  // Factory method to create a JobModel from JSON
  factory JobModel.fromMap(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      category: json['category'],
      location: json['location'],
      company: json['company'],
      companyLogo: json['companylogo'],
      salary: double.parse(json['salary'].toString()),
      description: json['description'],
      recruiter: json['recruiter'],
      postedAt: DateTime.parse(json['posted_at']),
    );
  }

  // Method to convert JobModel to JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'category': category,
      'location': location,
      'company': company,
      'companylogo': companyLogo,
      'salary': salary,
      'description': description,
      'recruiter': recruiter,
      'posted_at': postedAt.toIso8601String(),
    };
  }
}
