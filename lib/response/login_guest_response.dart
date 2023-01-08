

class GuestResponse {
final String message;
final bool status;


GuestResponse(this.message, this.status);

GuestResponse.fromJson(Map<String, dynamic> json, int statueCode)
    :
message = json['message'] != null ? json['message'] : 'Success',
status = json['status'] != null ? json['status'] : true;

GuestResponse.withError(Map<String, dynamic> json)
    : status = false,
message = '';
}
