abstract class Routes {
  static const CLINIC = '/clinic/:clinicId';
  static const CONSULT_DETAILS = '/schedule/:clinicId/s/:consultId';
  static const CONFIRMATION = '/schedule/:clinicId/s/:consultId/confirm';
  static const RESULT = '/schedule/:clinicId/s/:consultId/result/:isSuccess';
}
