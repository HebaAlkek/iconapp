import 'package:icon/model/biller_model.dart';
import 'package:icon/model/cart_model.dart';
import 'package:icon/model/creatUser_model.dart';
import 'package:icon/model/customer_sale_model.dart';
import 'package:icon/model/inv_model.dart';
import 'package:icon/model/pos_model.dart';
import 'package:icon/model/product_sale_model.dart';

class Invoice {
  final BillerModel supplier;
  final PosModel posItem;
  final SaleUserModel saleUser;
  final InvModel invItem;
  final List<ProductSaleModel> products;
  final CustomerSaleModel customerSale;

  const Invoice(
      {required this.supplier,
      required this.posItem,
      required this.saleUser,
      required this.customerSale,
      required this.invItem,
      required this.products});
}
