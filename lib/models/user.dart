class UserModel {
  final String firstname;
  final String lastname;
  final String email;
  final String mobile;
  final String region;
  final String country;
  final String state;
  final String address;
  final String apt;
  final String zipcode;
  final String password;
  final List? bankDetails;
  final List? history;
  final double amountSpent;
  final bool pushNotification;
  final String image;
  final bool emailNotification;

  UserModel({
    this.firstname = "null",
    this.lastname = "null",
    required this.email,
    this.password = "null",
    this.bankDetails,
    this.history,
    this.pushNotification = false,
    this.emailNotification = false,
    this.image = "assets/images/user/team2.jpeg",
    this.amountSpent = 0.00,
    this.mobile = "null",
    this.region = "null",
    this.country = "null",
    this.state = "null",
    this.address = "null",
    this.apt = "null",
    this.zipcode = "null",
  });

  //factory allows you to use return
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      mobile: json['mobile'] as String,
      region: json['region'] as String,
      country: json['country'] as String,
      state: json['state'] as String,
      address: json['address'] as String,
      password: json['password'] as String,
      apt: json['apt'] as String,
      zipcode: json['zipcode'] as String,
      amountSpent: json['amountSpent'] as double,
      pushNotification: json['pushNotification'] as bool,
      emailNotification: json['emailNotification'] as bool,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['email'] = email;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['mobile'] = mobile;
    data['region'] = region;
    data['country'] = country;
    data['state'] = state;
    data['address'] = address;
    data['password'] = password;
    data['apt'] = apt;
    data['zipcode'] = zipcode;
    data['amountSpent'] = amountSpent;
    data['pushNotification'] = pushNotification;
    data['emailNotification'] = emailNotification;
    data['image'] = image;

    return data;
  }
}
