class JobModel {
  String companyName;
  String companyLogo;
  String jobTitle;
  String jobType;
  String jobSalary;

  // Constructor
  JobModel({
    required this.companyName,
    required this.companyLogo,
    required this.jobTitle,
    required this.jobType,
    required this.jobSalary,
  });

  // Optionally, you can add a method to display job details as a string
  @override
  String toString() {
    return 'Job Title: $jobTitle\n'
        'Company: $companyName\n'
        'Type: $jobType\n'
        'Salary: \$$jobSalary';
  }

  // You could also add methods to serialize/deserialize to/from JSON if needed
  // Example of a fromJson method:
  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      companyName: json['companyName'],
      companyLogo: json['companyLogo'],
      jobTitle: json['jobTitle'],
      jobType: json['jobType'],
      jobSalary: json['jobSalary'].toDouble(),
    );
  }

  // Example of a toJson method:
  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'companyLogo': companyLogo,
      'jobTitle': jobTitle,
      'jobType': jobType,
      'jobSalary': jobSalary,
    };
  }
}
