class ConsultingData {
  final int? userId;
  final String? gender;
  final DateTime? birthDate;
  final String? address;
  final String? occupation;
  final String budget;
  final int? familyMember;
  final String preferredCrops;
  final String preferredRegion;
  final String farmingExperience;
  final String? etc;

  ConsultingData({
    this.userId,
    this.gender,
    this.birthDate,
    this.address,
    this.occupation,
    required this.budget,
    this.familyMember,
    required this.preferredCrops,
    required this.preferredRegion,
    required this.farmingExperience,
    this.etc,
  });

  ConsultingData copyWith({
    int? userId,
    String? gender,
    DateTime? birthDate,
    String? address,
    String? occupation,
    String? budget,
    int? familyMember,
    String? preferredCrops,
    String? preferredRegion,
    String? farmingExperience,
    String? etc,
  }) {
    return ConsultingData(
      userId: userId ?? this.userId,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      address: address ?? this.address,
      occupation: occupation ?? this.occupation,
      budget: budget ?? this.budget,
      familyMember: familyMember ?? this.familyMember,
      preferredCrops: preferredCrops ?? this.preferredCrops,
      preferredRegion: preferredRegion ?? this.preferredRegion,
      farmingExperience: farmingExperience ?? this.farmingExperience,
      etc: etc ?? this.etc,
    );
  }

  factory ConsultingData.fromJson(Map<String, dynamic> json) {
    return ConsultingData(
      budget: json['budget'] as String,
      preferred_crop: json['preferred_crop'] as String,
      preferredRegion: json['preferred_region'] as String,
      farmingExperience: json['farming_experience'] as String,
      userId: json['user_id'] as int,
    );
  }

  Map<String, dynamic> toJson({required int userId}) {
    return {
      "user_id": userId,
      "gender": gender,
      "birth_date": birthDate!.toIso8601String().split('T').first,
      "address": address,
      "occupation": occupation,
      "budget": budget,
      "family_member": familyMember,
      "preferred_crops": preferredCrops,
      "preferred_region": preferredRegion,
      "farming_experience": farmingExperience,
      "etc": etc,
    };
  }
}
