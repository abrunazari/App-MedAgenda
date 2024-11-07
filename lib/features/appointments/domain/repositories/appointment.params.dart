class GetClinicInfoCmsParams {
  String clinicId;

  GetClinicInfoCmsParams({
    required this.clinicId,
  });
}

class GetConsultInfoCmsParams {
  String consultId;
  String date;

  GetConsultInfoCmsParams({
    required this.consultId,
    required this.date,
  });
}

class ScheduleAppointmentCmsParams {
  String consultId;
  String professionalId;
  String dateTime;
  String clientName;
  String organizationId;

  ScheduleAppointmentCmsParams({
    required this.consultId,
    required this.professionalId,
    required this.dateTime,
    required this.clientName,
    required this.organizationId,
  });
}
