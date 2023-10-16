class DatacountModel {
  int? id, serveCount, smashCount, driveCount, createAt;

  DatacountModel(
      {this.id,
      this.serveCount,
      this.smashCount,
      this.driveCount,
      this.createAt});

  factory DatacountModel.fromJson(Map<String, dynamic> json) {
    return DatacountModel(
        id: json['id'],
        serveCount: json['serve_count'],
        smashCount: json['smash_count'],
        driveCount: json['drive_count'],
        createAt: json['created_at']);
  }
}
