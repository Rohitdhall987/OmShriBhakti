class Version {
  Version({
    required this.version,
    required this.status,
  });
  late final String version;
  late final int status;

  Version.fromJson(Map<String, dynamic> json){
    version = json['version'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['version'] = version;
    _data['status'] = status;
    return _data;
  }
}