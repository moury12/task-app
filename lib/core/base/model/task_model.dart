class TaskModel {
  String? sId;
  String? title;
  String? description;
  String? creatorEmail;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TaskModel(
      {this.sId,
        this.title,
        this.description,
        this.creatorEmail,
        this.createdAt,
        this.updatedAt,
        this.iV});

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    creatorEmail = json['creator_email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['creator_email'] = creatorEmail;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
