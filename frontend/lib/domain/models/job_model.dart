class JobModel {
  final int id;
  final String title;
  final String type;
  final String company;
  final String companyLogo;
  final double salary;
  final String description;
  final int recruiter;

  JobModel({
    required this.id,
    required this.title,
    required this.type,
    required this.company,
    required this.companyLogo,
    required this.salary,
    required this.description,
    required this.recruiter,
  });

  // Factory method to create a JobModel from a map (useful for parsing JSON)
  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      company: map['company'],
      companyLogo: map['companylogo'],
      salary: double.parse(map['salary'].toString()),
      description: map['description'],
      recruiter: map['recruiter'],
    );
  }

  // Method to convert a JobModel to a map (useful for sending to backend or saving locally)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'company': company,
      'companylogo': companyLogo,
      'salary': salary,
      'description': description,
      'recruiter': recruiter,
    };
  }
}
