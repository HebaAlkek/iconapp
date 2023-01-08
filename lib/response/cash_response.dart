class CashResponse {
  final String message;
  final bool status;

  CashResponse(this.message, this.status);

  CashResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : message = json['message'] != null ? json['message'] : 'Success',
        status = json['status'] != null ? json['status'] : true;

  CashResponse.withError(Map<String, dynamic> json)
      : status = false,
        message = '';
}
