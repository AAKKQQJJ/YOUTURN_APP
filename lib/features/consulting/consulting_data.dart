class ConsultingData {
  final int? userId;
  final String? age;
  final String? gender;
  final DateTime? birthDate;
  final String? address;
  final String? familyMember;
  final String? occupation;
  final String? budget;
  final String? preferredCrops;
  final String? preferredRegion;
  final String? farmingExperience;
  final String? etc;

  ConsultingData({
    this.userId,
    this.age,
    this.gender,
    this.birthDate,
    this.address,
    this.familyMember,
    this.occupation,
    this.budget,
    this.preferredCrops,
    this.preferredRegion,
    this.farmingExperience,
    this.etc,
  });

  ConsultingData copyWith({
    int? userId,
    String? age,
    String? gender,
    DateTime? birthDate,
    String? address,
    String? familyMember,
    String? occupation,
    String? budget,
    String? preferredCrops,
    String? preferredRegion,
    String? farmingExperience,
    String? etc,
  }) {
    print('=== copyWith 디버깅 ===');
    print('전달받은 userId: $userId');
    print('기존 this.userId: ${this.userId}');
    print('최종 userId: ${userId ?? this.userId}');
    
    return ConsultingData(
      userId: userId ?? this.userId,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      address: address ?? this.address,
      familyMember: familyMember ?? this.familyMember,
      occupation: occupation ?? this.occupation,
      budget: budget ?? this.budget,
      preferredCrops: preferredCrops ?? this.preferredCrops,
      preferredRegion: preferredRegion ?? this.preferredRegion,
      farmingExperience: farmingExperience ?? this.farmingExperience,
      etc: etc ?? this.etc,
    );
  }

  factory ConsultingData.fromJson(Map<String, dynamic> json) {
    return ConsultingData(
      userId: json['userId'] as int?, // GoRouter에서는 userId 사용 안함
      age: json['age'] as String?,
      gender: json['gender'] as String?,
      birthDate: json['birthDate'] != null 
        ? DateTime.parse(json['birthDate'] as String)
        : null,
      address: json['address'] as String?,
      familyMember: json['familyMember'] as String?,
      occupation: json['occupation'] as String?,
      budget: json['budget'] as String?,
      preferredCrops: json['preferredCrops'] as String?,
      preferredRegion: json['preferredRegion'] as String?,
      farmingExperience: json['farmingExperience'] as String?,
      etc: json['etc'] as String?,
    );
  }

  // GoRouter 직렬화를 위한 간단한 toJson (API 호출용이 아님)
  Map<String, dynamic> toJson() {
    print('=== toJson() 호출됨 (GoRouter 직렬화) ===');
    // GoRouter에서 객체 전달을 위한 최소한의 데이터만 포함
    return {
      'age': age,
      'gender': gender,
      'birthDate': birthDate?.toIso8601String(),
      'address': address,
      'familyMember': familyMember,
      'occupation': occupation,
      'budget': budget,
      'preferredCrops': preferredCrops,
      'preferredRegion': preferredRegion,
      'farmingExperience': farmingExperience,
      'etc': etc,
      // userId는 GoRouter 전달시에는 제외 (API 호출시에만 필요)
    };
  }

  // API 호출 전용 메서드 (userId 포함 필수)
  Map<String, dynamic> toApiJson({required int userId}) {
    print('=== toApiJson() 디버깅 ===');
    print('전달받은 userId: $userId');
    
    final Map<String, dynamic> json = {};
    
    // 필수 필드들
    json["user_id"] = userId;
    
    if (gender != null) {
      String genderEn = gender!;
      if (gender == "남") {
        genderEn = "MALE";
      } else if (gender == "여") {
        genderEn = "FEMALE";
      } else {
        genderEn = gender!.toUpperCase();
      }
      json["gender"] = genderEn;
    }
    
    if (birthDate != null) json["birth_date"] = birthDate!.toIso8601String().split('T').first;
    if (address != null && address!.isNotEmpty) json["address"] = address;
    if (occupation != null && occupation!.isNotEmpty) json["occupation"] = occupation;
    
    if (budget != null && budget!.isNotEmpty) {
      final budgetNum = int.tryParse(budget!);
      if (budgetNum != null) json["budget"] = budgetNum;
    }
    
    if (familyMember != null && familyMember!.isNotEmpty) json["family_member"] = familyMember;
    if (preferredCrops != null && preferredCrops!.isNotEmpty) json["preferred_crops"] = preferredCrops;
    if (preferredRegion != null && preferredRegion!.isNotEmpty) json["preferred_region"] = preferredRegion;
    
    if (farmingExperience != null && farmingExperience!.isNotEmpty) {
      final experienceNum = int.tryParse(farmingExperience!);
      json["farming_experience"] = experienceNum ?? 0;
    } else {
      json["farming_experience"] = 0;
    }
    
    if (etc != null && etc!.isNotEmpty) json["etc"] = etc;
    
    print('=== API JSON 결과 ===');
    print('JSON 키들: ${json.keys.toList()}');
    print('user_id 값: ${json["user_id"]}');
    print('전체 JSON: $json');
    
    return json;
  }
}
