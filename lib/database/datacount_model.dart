class DatacountModel {
  int? id,
      serveCount,
      smashCount,
      driveCount,
      wServeCount,
      wSmashCount,
      wDriveCount;
  String? sessionName, createdAt;

  DatacountModel(
      {this.id,
      this.sessionName,
      this.serveCount,
      this.smashCount,
      this.driveCount,
      this.wServeCount,
      this.wSmashCount,
      this.wDriveCount,
      this.createdAt});

  factory DatacountModel.fromJson(Map<String, dynamic> json) {
    return DatacountModel(
        id: json['id'],
        sessionName: json['session_name'],
        serveCount: json['serve_count'],
        smashCount: json['smash_count'],
        driveCount: json['drive_count'],
        wServeCount: json['wrong_serve_count'],
        wSmashCount: json['wrong_smash_count'],
        wDriveCount: json['wrong_drive_count'],
        createdAt: json['created_at']);
  }
}
