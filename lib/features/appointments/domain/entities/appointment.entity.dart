class AppointmentEntity {
  final String id;
  final String consultId;
  final String professionalId;
  final DateTime dateTime;
  final String clientName;
  final String organizationId;

  AppointmentEntity({
    required this.id,
    required this.consultId,
    required this.professionalId,
    required this.dateTime,
    required this.clientName,
    required this.organizationId,
  });

  factory AppointmentEntity.fromJson(Map<String, dynamic> json) {
    return AppointmentEntity(
      id: json['id'] as String? ?? 'default-id',
      consultId: json['consultId'] as String? ?? 'default-consult-id',
      professionalId:
          json['professionalId'] as String? ?? 'default-professional-id',
      dateTime: json['dateTime'] != null
          ? DateTime.parse(json['dateTime'] as String)
          : DateTime.now(),
      clientName: json['clientInfo'] != null
          ? (json['clientInfo']['name'] as String? ?? 'default-name')
          : 'default-client-name',
      organizationId:
          json['organizationId'] as String? ?? 'default-organization-id',
    );
  }
}
