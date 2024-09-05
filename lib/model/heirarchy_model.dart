class UserDetails {
  final String empCode;
  final String empName;
  final String reportingTo;
  final String designation;
  final String Premier_code;
  final String Region;
  final bool isCheck; // Add the isChecked field

  UserDetails({
    required this.empCode,
    required this.empName,
    required this.reportingTo,
    required this.designation,
    required this.Premier_code,
    required this.Region,
    required this.isCheck, // Include the isChecked parameter
  });

  Map<String, dynamic> toMap() {
    return {
      'EmpCode': empCode,
      'EmpName': empName,
      'ReportTo': reportingTo,
       'EmpDesignation': designation,
      'Premier_code':Premier_code,
      'Region':Region,
      'is_check': isCheck, // Map the isChecked field
    };
  }
}