class ProductDetailsModelList {
  String id;
  String name,
      unit,
      cost,
      price,
      qtybase,
  qty,
      alert_quantity,
      image,
      category_id,
      subcategory_id,
      cf1,
      cf2,
      cf3,
      cf4,
      cf5,
      cf6,
      quantity,
      code,
      tax_rate,
      track_quantity,
      details,
      warehouse,
      barcode_symbology,
      file,
      product_details,
      tax_method,
      type,
      lastPrice,
      supplier1,
      supplier1price,
      supplier2,
      supplier2price,
      supplier3,
      supplier3price,
      supplier4,
      supplier4price,
      supplier5,
      supplier5price,
      promotion,
      promo_price,
      start_date,
      end_date,
      supplier1_part_no,
      supplier2_part_no,
      supplier3_part_no,
      supplier4_part_no,
      supplier5_part_no,
      sale_unit,
      purchase_unit,
      brand,
      slug,
      featured,
      weight,
      hsn_code,
      views,
      hide,
      second_name,
      hide_pos,unit_price;
  int valRet;

  ProductDetailsModelList(
      {required this.name,
      required this.image,
      required this.price,
      required this.cost,
      required this.weight,
      required this.file,
      required this.alert_quantity,
      required this.quantity,
      required this.id,
      required this.code,
      required this.slug,
      required this.barcode_symbology,
      required this.brand,
      required this.tax_method,
      required this.category_id,
      required this.valRet,
      required this.second_name,
      required this.type,
      required this.cf1,
      required this.cf2,
      required this.cf3,
      required this.cf4,
      required this.cf5,
      required this.cf6,
        required this.unit_price,
      required this.details,
      required this.end_date,
      required this.featured,
      required this.hide,
      required this.qtybase,
        required this.qty,
      required this.hide_pos,
      required this.hsn_code,
      required this.lastPrice,
      required this.product_details,
      required this.promo_price,
      required this.promotion,
      required this.purchase_unit,
      required this.sale_unit,
      required this.start_date,
      required this.subcategory_id,
      required this.supplier1,
      required this.supplier1_part_no,
      required this.supplier1price,
      required this.supplier2,
      required this.supplier2_part_no,
      required this.supplier2price,
      required this.supplier3,
      required this.supplier3_part_no,
      required this.supplier3price,
      required this.supplier4,
      required this.supplier4_part_no,
      required this.supplier4price,
      required this.supplier5,
      required this.supplier5_part_no,
      required this.supplier5price,
      required this.tax_rate,
      required this.track_quantity,
      required this.unit,
      required this.views,
      required this.warehouse});

  factory ProductDetailsModelList.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModelList(
        name: json['name'] != null ? json['name'].toString() : '',
        image: json['image'] != null ? json['image'].toString() : '',
        price: json['price'] != null ? json['price'].toString() : '',
        cost: json['cost'] != null ? json['cost'].toString() : '',
        qtybase: json['base_quantity'] != null ? json['base_quantity'] : '',
        qty: '0',

        weight: json['weight'] != null ? json['weight'].toString() : '',
        file: json['file'] != null ? json['file'].toString() : '',
        alert_quantity: json['alert_quantity'] != null
            ? json['alert_quantity'].toString()
            : '',
        valRet: 0,
        quantity: json['quantity'] != null ? json['quantity'].toString() : '',
        id: json['id'] != null ? json['id'].toString() : '',
        lastPrice: json['real_unit_cost'] != null
            ? json['real_unit_cost'].toString()
            : '',
        unit_price :json['real_unit_cost'] != null
            ? json['real_unit_cost'].toString()
            : '',
        code: json['code'] != null ? json['code'].toString() : '',
        slug: json['slug'] != null ? json['slug'].toString() : '',
        barcode_symbology: json['barcode_symbology'] != null
            ? json['barcode_symbology'].toString()
            : '',
        brand: json['brand'] != null ? json['brand'].toString() : '',
        tax_method:
            json['tax_method'] != null ? json['tax_method'].toString() : '',
        category_id:
            json['category_id'] != null ? json['category_id'].toString() : '',
        second_name:
            json['second_name'] != null ? json['second_name'].toString() : '',
        type: json['type'] != null ? json['type'].toString() : '',
        cf1: json['cf1'] != null ? json['cf1'].toString() : '',
        cf2: json['cf2'] != null ? json['cf2'].toString() : '',
        cf3: json['cf3'] != null ? json['cf3'].toString() : '',
        cf4: json['cf4'] != null ? json['cf4'].toString() : '',
        cf5: json['cf5'] != null ? json['cf5'].toString() : '',
        cf6: json['cf6'] != null ? json['cf6'].toString() : '',
        details: json['details'] != null ? json['details'].toString() : '',
        end_date: json['end_date'] != null ? json['end_date'].toString() : '',
        featured: json['featured'] != null ? json['featured'].toString() : '',
        hide: json['hide'] != null ? json['hide'].toString() : '',
        hide_pos: json['hide_pos'] != null ? json['hide_pos'].toString() : '',
        hsn_code: json['hsn_code'] != null ? json['hsn_code'].toString() : '',
        product_details: json['product_details'] != null
            ? json['product_details'].toString()
            : '',
        promo_price:
            json['promo_price'] != null ? json['promo_price'].toString() : '',
        promotion:
            json['promotion'] != null ? json['promotion'].toString() : '',
        purchase_unit: json['purchase_unit'] != null
            ? json['purchase_unit'].toString()
            : '',
        sale_unit:
            json['sale_unit'] != null ? json['sale_unit'].toString() : '',
        start_date:
            json['start_date'] != null ? json['start_date'].toString() : '',
        subcategory_id: json['subcategory_id'] != null
            ? json['subcategory_id'].toString()
            : '',
        supplier1:
            json['supplier1'] != null ? json['supplier1'].toString() : '',
        supplier1_part_no: json['supplier1_part_no'] != null
            ? json['supplier1_part_no'].toString()
            : '',
        supplier1price: json['supplier1price'] != null
            ? json['supplier1price'].toString()
            : '',
        supplier2:
            json['supplier2'] != null ? json['supplier2'].toString() : '',
        supplier2_part_no: json['supplier2_part_no'] != null
            ? json['supplier2_part_no'].toString()
            : '',
        supplier2price: json['supplier2price'] != null
            ? json['supplier2price'].toString()
            : '',
        supplier3:
            json['supplier3'] != null ? json['supplier3'].toString() : '',
        supplier3_part_no: json['supplier3_part_no'] != null
            ? json['supplier3_part_no'].toString()
            : '',
        supplier3price: json['supplier3price'] != null
            ? json['supplier3price'].toString()
            : '',
        supplier4:
            json['supplier4'] != null ? json['supplier4'].toString() : '',
        supplier4_part_no: json['supplier4_part_no'] != null
            ? json['supplier4_part_no'].toString()
            : '',
        supplier4price: json['supplier4price'] != null
            ? json['supplier4price'].toString()
            : '',
        supplier5:
            json['supplier5'] != null ? json['supplier5'].toString() : '',
        supplier5_part_no: json['supplier5_part_no'] != null
            ? json['supplier5_part_no'].toString()
            : '',
        supplier5price: json['supplier5price'] != null
            ? json['supplier5price'].toString()
            : '',
        tax_rate: json['tax_rate'] != null ? json['tax_rate'].toString() : '',
        track_quantity: json['track_quantity'] != null
            ? json['track_quantity'].toString()
            : '',
        unit: json['unit'] != null ? json['unit'].toString() : '',
        views: json['views'] != null ? json['views'].toString() : '',
        warehouse:
            json['warehouse'] != null ? json['warehouse'].toString() : '');
  }
}
