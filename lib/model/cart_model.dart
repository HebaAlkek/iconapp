import 'dart:convert';

import 'package:icon/model/produce_model.dart';
import 'package:icon/model/store_rpo.dart';

class CartMode {
  ProStore prList;
  int quan;
  double total;

  CartMode({required this.prList, required this.quan, required this.total});

  factory CartMode.fromJson(Map<String, dynamic> json) {
    return CartMode(
      quan: json['quan'],
      prList:
      ProStore.fromJson((jsonDecode(json["prList"]) as List<dynamic>))

   ,
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() => {
        'prList': prList,
        'total': total,
        'quan': quan,
      };

  static Map<String, dynamic> toMap(CartMode music) => {
        'total': music.total,
        // 'product': music.proitem,
        'quan': music.quan,
        'prList':
    json.encode(
      music.prList.listStorePro
          .map<Map<String, dynamic>>(
              (music) => ProductModdelList.toMavp(music))
          .toList(),
    )

      };

  static String encode(List<CartMode> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => CartMode.toMap(music))
            .toList(),
      );

  static List<CartMode> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<CartMode>((item) => CartMode.fromJson(item))
          .toList();
}
