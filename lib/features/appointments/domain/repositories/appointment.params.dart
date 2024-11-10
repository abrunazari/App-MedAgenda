class GetClinicInfoDataSourceParams {
  String clinicId;

  GetClinicInfoDataSourceParams({
    required this.clinicId,
  });
}

class GetConsultInfoDataSourceParams {
  String consultId;
  String date;

  GetConsultInfoDataSourceParams({
    required this.consultId,
    required this.date,
  });
}

class ScheduleAppointmentDataSourceParams {
  String consultId;
  String professionalId;
  String dateTime;
  String clientName;
  String organizationId;

  ScheduleAppointmentDataSourceParams({
    required this.consultId,
    required this.professionalId,
    required this.dateTime,
    required this.clientName,
    required this.organizationId,
  });
}
