class ProfessionalEntity {
  final String id;
  final String name;
  final String? bio;
  final String? userId;
  final String? email;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final DateTime? deactivatedAt;
  final String? organizationId;
  final String? barberShopId;
  final bool isActive;

  ProfessionalEntity({
    required this.id,
    required this.name,
    this.bio,
    this.userId,
    this.email,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.isActive,
    this.deactivatedAt,
    this.organizationId,
    this.barberShopId,
  });

  factory ProfessionalEntity.fromJson(Map<String, dynamic> json) {
    return ProfessionalEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String?,
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deactivatedAt: json['deactivatedAt'] != null
          ? DateTime.parse(json['deactivatedAt'] as String)
          : null,
      organizationId: json['organizationId'] as String?,
      barberShopId: json['barberShopId'] as String?,
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'] as String)
          : null,
      isActive: json['deletedAt'] == null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'email': email,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'deactivatedAt': deactivatedAt?.toIso8601String(),
      'organizationId': organizationId,
      'barberShopId': barberShopId,
      'isActive': isActive,
    };
  }
}
