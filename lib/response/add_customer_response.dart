class AddCustomerResponse {
  final String message;
  final int code;
  final String error;
  final String invoice;

  AddCustomerResponse(this.message, this.code,this.error,this.invoice);

  AddCustomerResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : message = json['message'] != null ? json['message'] : json['data']!=null?json['data']['error']:json['success']!=null?json['success']:json['saccuss'],
        error = json['success'] != null ? 'null':json['saccuss']!=null?'null':json['error'],
        invoice = json['invoice']!=null?json['invoice'].toString():'',
        code = statueCode;

  AddCustomerResponse.withError(Map<String, dynamic> json,int? code)
      : message = json['message'],
        error = '',
        invoice='',
        code = code!;
}
