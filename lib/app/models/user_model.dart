class UserModel {
  final String? id;
  final String name;
  final int age;
  final String gender;
  final String maritalStatus;
  final String occupation;
  final String samajName;
  final String qualification;
  final DateTime birthDate;
  final String bloodGroup;
  final String exactNatureOfDuties;
  final String email;
  final String phoneNumber;
  final String? alternativeNumber;
  final String? landlineNumber;
  final String? socialMediaLink;
  final String flatNumber;
  final String buildingName;
  final String streetName;
  final String? landmark;
  final String city;
  final String district;
  final String state;
  final String nativeCity;
  final String nativeState;
  final String country;
  final String pincode;
  final String? photoUrl;
  final String? relationWithHead;
  final bool isHead;
  final String? headId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? doorNumber;

  UserModel({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.maritalStatus,
    required this.occupation,
    required this.samajName,
    required this.qualification,
    required this.birthDate,
    required this.bloodGroup,
    required this.exactNatureOfDuties,
    required this.email,
    required this.phoneNumber,
    this.alternativeNumber,
    this.landlineNumber,
    this.socialMediaLink,
    required this.flatNumber,
    required this.buildingName,
    required this.streetName,
    this.landmark,
    required this.city,
    required this.district,
    required this.state,
    required this.nativeCity,
    required this.nativeState,
    required this.country,
    required this.pincode,
    this.photoUrl,
    this.relationWithHead,
    required this.isHead,
    this.headId,
    required this.createdAt,
    required this.updatedAt,
    this.doorNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      maritalStatus: json['maritalStatus'],
      occupation: json['occupation'],
      samajName: json['samajName'],
      qualification: json['qualification'],
      birthDate: DateTime.parse(json['birthDate']),
      bloodGroup: json['bloodGroup'],
      exactNatureOfDuties: json['exactNatureOfDuties'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      alternativeNumber: json['alternativeNumber'],
      landlineNumber: json['landlineNumber'],
      socialMediaLink: json['socialMediaLink'],
      flatNumber: json['flatNumber'],
      buildingName: json['buildingName'],
      streetName: json['streetName'],
      landmark: json['landmark'],
      city: json['city'],
      district: json['district'],
      state: json['state'],
      nativeCity: json['nativeCity'],
      nativeState: json['nativeState'],
      country: json['country'],
      pincode: json['pincode'],
      photoUrl: json['photoUrl'],
      relationWithHead: json['relationWithHead'],
      isHead: json['isHead'],
      headId: json['headId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      doorNumber: json['doorNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'maritalStatus': maritalStatus,
      'occupation': occupation,
      'samajName': samajName,
      'qualification': qualification,
      'birthDate': birthDate.toIso8601String(),
      'bloodGroup': bloodGroup,
      'exactNatureOfDuties': exactNatureOfDuties,
      'email': email,
      'phoneNumber': phoneNumber,
      'alternativeNumber': alternativeNumber,
      'landlineNumber': landlineNumber,
      'socialMediaLink': socialMediaLink,
      'flatNumber': flatNumber,
      'buildingName': buildingName,
      'streetName': streetName,
      'landmark': landmark,
      'city': city,
      'district': district,
      'state': state,
      'nativeCity': nativeCity,
      'nativeState': nativeState,
      'country': country,
      'pincode': pincode,
      'photoUrl': photoUrl,
      'relationWithHead': relationWithHead,
      'isHead': isHead,
      'headId': headId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'doorNumber': doorNumber,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    String? maritalStatus,
    String? occupation,
    String? samajName,
    String? qualification,
    DateTime? birthDate,
    String? bloodGroup,
    String? exactNatureOfDuties,
    String? email,
    String? phoneNumber,
    String? alternativeNumber,
    String? landlineNumber,
    String? socialMediaLink,
    String? flatNumber,
    String? buildingName,
    String? streetName,
    String? landmark,
    String? city,
    String? district,
    String? state,
    String? nativeCity,
    String? nativeState,
    String? country,
    String? pincode,
    String? photoUrl,
    String? relationWithHead,
    bool? isHead,
    String? headId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? doorNumber,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      occupation: occupation ?? this.occupation,
      samajName: samajName ?? this.samajName,
      qualification: qualification ?? this.qualification,
      birthDate: birthDate ?? this.birthDate,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      exactNatureOfDuties: exactNatureOfDuties ?? this.exactNatureOfDuties,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      alternativeNumber: alternativeNumber ?? this.alternativeNumber,
      landlineNumber: landlineNumber ?? this.landlineNumber,
      socialMediaLink: socialMediaLink ?? this.socialMediaLink,
      flatNumber: flatNumber ?? this.flatNumber,
      buildingName: buildingName ?? this.buildingName,
      streetName: streetName ?? this.streetName,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      district: district ?? this.district,
      state: state ?? this.state,
      nativeCity: nativeCity ?? this.nativeCity,
      nativeState: nativeState ?? this.nativeState,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
      photoUrl: photoUrl ?? this.photoUrl,
      relationWithHead: relationWithHead ?? this.relationWithHead,
      isHead: isHead ?? this.isHead,
      headId: headId ?? this.headId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      doorNumber: doorNumber ?? this.doorNumber,
    );
  }
}
