class UserModel {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? address;
  String? image;
  String? activationCode;
  String? isVerified;
  String? createdAt;
  String? updatedAt;
  String? iV;

  UserModel(
      {this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.address,
      this.image,
      this.activationCode,
      this.isVerified,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString() == 'null' ? '' : json['_id'].toString();
    firstName = json['firstName'].toString() == 'null'
        ? ''
        : json['firstName'].toString();
    lastName = json['lastName'].toString() == 'null'
        ? ''
        : json['lastName'].toString();
    email = json['email'].toString() == 'null' ? '' : json['email'].toString();
    password = json['password'].toString() == 'null'
        ? ''
        : json['password'].toString();
    address =
        json['address'].toString() == 'null' ? '' : json['address'].toString();
    image = json['image'].toString() == 'null' ? '' : json['image'].toString();
    activationCode = json['activationCode'].toString() == 'null'
        ? ''
        : json['activationCode'].toString();
    isVerified = json['isVerified'].toString() == 'null'
        ? ''
        : json['isVerified'].toString();
    createdAt = json['createdAt'].toString() == 'null'
        ? ''
        : json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString() == 'null'
        ? ''
        : json['updatedAt'].toString();
    iV = json['__v'].toString() == 'null' ? '' : json['__v'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['address'] = address;
    data['image'] = image;
    data['activationCode'] = activationCode;
    data['isVerified'] = isVerified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
