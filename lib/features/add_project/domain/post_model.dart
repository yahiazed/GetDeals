class ProjectModel {
  String? id;
  String projectName;

  String imgUrls;
  String filesUrls;
  String filesNames;
  String userUid;
  String projectKind;
  String projectPlace;
  String projectDuration;
  String projectPartnerNumber;
  String projectReasonOfPay;
  String projectSumSales;
  String projectSubnetProfit;
  String projectDescription;
  String projectState;
  String projectDate;
  ProjectModel({
    this.id,
    required this.projectName,
    required this.imgUrls,
    required this.filesUrls,
    required this.filesNames,
    required this.userUid,
    required this.projectKind,
    required this.projectPlace,
    required this.projectDuration,
    required this.projectPartnerNumber,
    required this.projectReasonOfPay,
    required this.projectSumSales,
    required this.projectSubnetProfit,
    required this.projectDescription,
    required this.projectState,
    required this.projectDate,
  });
  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'],
        projectName: json['projectName'],
        imgUrls: json['imgUrls'],
        filesUrls: json['filesUrls'],
        filesNames: json['filesNames'],
        userUid: json['userUid'],
        projectKind: json['projectKind'],
        projectPlace: json['projectPlace'],
        projectDuration: json['projectDuration'],
        projectPartnerNumber: json['projectPartnerNumber'],
        projectReasonOfPay: json['projectReasonOfPay'],
        projectSumSales: json['projectSumSales'],
        projectSubnetProfit: json['projectSubnetProfit'],
        projectDescription: json['projectDescription'],
        projectState: json['projectState'],
        projectDate: json['projectDate'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectName': projectName,
      'imgUrls': imgUrls,
      'filesUrls': filesUrls,
      'filesNames': filesNames,
      'userUid': userUid,
      'projectKind': projectKind,
      'projectPlace': projectPlace,
      'projectDuration': projectDuration,
      'projectPartnerNumber': projectPartnerNumber,
      'projectReasonOfPay': projectReasonOfPay,
      'projectSumSales': projectSumSales,
      'projectSubnetProfit': projectSubnetProfit,
      'projectDescription': projectDescription,
      'projectState': projectState,
      'projectDate': projectDate,
    };
  }
}
