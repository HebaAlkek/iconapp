class ReturnPurResponse {
  final String message;
  final int code;

  ReturnPurResponse(this.message, this.code);

  ReturnPurResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : message = json['message'] != null ? json['message'] : 'Success',
        code = statueCode;

  ReturnPurResponse.withError(Map<String, dynamic> json)
      : message = '',
        code = 0;
}
