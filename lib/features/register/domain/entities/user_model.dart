// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String uid;
  String name;
  String email;
  String phoneNumber;
  int age;
  String gender;
  String city;
  String? interests;
  String? photo;
  int? experienceYears = 0;
  int? userKind = 0;
  String? specialist;
  String? serviceProviderKind;
  String? serviceDescription;
  num? rate;
  num? hourPrice;

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
            age: json['age'],
            city: json['city'],
            email: json['email'],
            gender: json['gender'],
            name: json['name'],
            uid: json['uid'],
            photo: json['photo'],
            phoneNumber: json['phoneNumber'],
            interests: json['interests'],
            userKind: json['userKind']);
  UserModel.fromJsonServiceProvider(Map<String, dynamic> json)
      : this(
          age: json['age'],
          city: json['city'],
          email: json['email'],
          gender: json['gender'],
          name: json['name'],
          uid: json['uid'],
          photo: json['photo'],
          phoneNumber: json['phoneNumber'],
          interests: json['interests'],
          experienceYears: json['experienceYears'],
          serviceDescription: json['serviceDescription'],
          serviceProviderKind: json['serviceProviderKind'],
          specialist: json['specialist'],
          userKind: json['userKind'],
          rate: json['rate'] ?? 0,
          hourPrice: json['hourPrice'] ?? 0,
        );

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'city': city,
      'email': email,
      'gender': gender,
      'name': name,
      'uid': uid,
      'interests': interests,
      'photo': photo,
      'phoneNumber': phoneNumber,
      'userKind': userKind
    };
  }

  Map<String, dynamic> toJsonServiceProvider() {
    return {
      'age': age,
      'city': city,
      'email': email,
      'gender': gender,
      'name': name,
      'uid': uid,
      'interests': interests,
      'photo': photo,
      'phoneNumber': phoneNumber,
      'experienceYears': experienceYears,
      'serviceDescription': serviceDescription,
      'serviceProviderKind': serviceProviderKind,
      'specialist': specialist,
      'userKind': userKind,
      'rate': rate ?? 0,
      'hourPrice': hourPrice ?? 0
    };
  }

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.age,
      required this.gender,
      required this.city,
      required this.phoneNumber,
      this.interests,
      this.photo,
      this.experienceYears,
      this.serviceDescription,
      this.serviceProviderKind,
      this.specialist,
      this.userKind,
      this.rate,
      this.hourPrice});
}
