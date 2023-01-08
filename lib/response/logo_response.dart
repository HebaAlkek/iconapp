class LogoResponse {
  String loggs;
  int statuecode;

  LogoResponse(this.loggs, this.statuecode);

  LogoResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : statuecode = statueCode,
        loggs = json['logo'];

  LogoResponse.withError(Map<String, dynamic> json, int statueCode)
      : loggs = json['message'],
        statuecode = statueCode;
}
