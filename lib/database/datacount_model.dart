class DatacountModel {
  int? id, serveCount, smashCount, driveCount, createAt;
  String? sessionName, createdAt;

  DatacountModel(
      {this.id,
      this.sessionName,
      this.serveCount,
      this.smashCount,
      this.driveCount,
      this.createdAt});

  factory DatacountModel.fromJson(Map<String, dynamic> json) {
    return DatacountModel(
        id: json['id'],
        sessionName: json['session_name'],
        serveCount: json['serve_count'],
        smashCount: json['smash_count'],
        driveCount: json['drive_count'],
        createdAt: json['created_at']);
  }
}
