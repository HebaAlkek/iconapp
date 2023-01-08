import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/supplier_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/supplier_model.dart';
import 'package:icon/screen/supplier/add_supplier_page.dart';
import 'package:icon/widget/supplier_card.dart';
import 'package:lottie/lottie.dart';

class SupplierPage extends StatefulWidget {
  @override
  _SupplierPage createState() => _SupplierPage();
}

class _SupplierPage extends State<SupplierPage> with TickerProviderStateMixin {
  SupplierController subController = Get.put(SupplierController());
  PosController posController = Get.put(PosController());

  bool searchh = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    subController.getSupplierList();
    super.initState();
  }
  void filterSearchResulthBrand(String query) {
    final dummySearchList = [];
    dummySearchList.addAll(subController.supplierListSearch.value);
    if (query.isNotEmpty) {
      final dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.person.toString().toLowerCase().contains(query.toString().toLowerCase()) ||
            item.company.toString().toLowerCase().contains(query.toString().toLowerCase())) {
          dummyListData.add(item);
        }
      });
        subController.supplierList.clear();
        subController.supplierList.addAll(dummyListData);

    } else {
      setState(() {
        subController.supplierList.clear();
        subController.supplierList.addAll(subController.supplierListSearch);
      });
    }
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(


      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              posController.languagee.value == 'en'
                  ? Icons.keyboard_arrow_left_sharp
                  : Icons.keyboard_arrow_right,
              color: Colors.white,
            )),
        actions: [

          Row(
            children: [
        posController.permission.value.length != 0?    posController.suppAdd=='1'?  InkWell(
                  onTap: () {
                    Get.to(() => AddSupplierPage('1',SupplierModelList(company: '',state: '',phone: '',address: '',id:'',
                    city: '',country: '',email: '',gst_no: '',person: '',postal_code: '',vat_no: '')));
                  },
                  child: Padding(
                      padding:
                      const EdgeInsets.fromLTRB(10, 0, 0, 0.0),
                      child: Container(decoration: BoxDecoration(color: Colors.transparent,
                          border: Border.all(color: Colors.white,width: 1),
                          shape: BoxShape.circle),
                        child: Padding(padding: EdgeInsets.all(3),
                          child:  Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 21,),),)
                  )):
        Visibility(child: Text(''), visible: false):InkWell(
            onTap: () {
              Get.to(() => AddSupplierPage('1',SupplierModelList(company: '',state: '',phone: '',address: '',id:'',
                  city: '',country: '',email: '',gst_no: '',person: '',postal_code: '',vat_no: '')));
            },
            child: Padding(
                padding:
                const EdgeInsets.fromLTRB(10, 0, 0, 0.0),
                child: Container(decoration: BoxDecoration(color: Colors.transparent,
                    border: Border.all(color: Colors.white,width: 1),
                    shape: BoxShape.circle),
                  child: Padding(padding: EdgeInsets.all(3),
                    child:  Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 21,),),)
            )),
              InkWell(
                  onTap: () {
                    setState(() {
                      searchh = !searchh;
                    });
                    if (searchh == false) {
                      subController.searchSupplier.text = '';
                      subController.supplierList.clear();
                      subController.supplierList.addAll(
                          subController.supplierListSearch);
                    }
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(10, 0, 5, 0.0),
                    child: searchh == false
                        ? Icon(
                      Icons.search,
                      color: Colors.white,
                    )
                        : Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                  )),
            ],
          )

        ],
        // hides default back button
        flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFF002e80).withOpacity(0.4),
                  Color(0xFF002e80).withOpacity(0.7),
                  Color(0xFF002e80)
                ],
              ),
            )),
        title:
        searchh == false
            ? Text(S.of(context).supplier,
            style:
            TextStyle(fontSize: 22.0, color: Colors.white))
            : Padding(
          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0.0),
          child: TextField(
            controller: subController.searchSupplier,
            autofocus:true,

            onChanged: (value) {
              filterSearchResulthBrand(value);
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                isDense: false,
                contentPadding: EdgeInsets.zero,
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: new UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 15,
                  minHeight: 25,
                ),
                hintText: S.of(context).searchh,
                hintStyle: TextStyle(
                  color: Colors.white,
                )),
          ),
        )
        ,
        centerTitle: true,
      ),

      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Obx(() => subController.isLoading.value == true
              ? Center(
                  child: Lottie.asset('assets/images/loading.json',
                      width: 90, height: 90),
                )
              : subController.supplierList.length == 0
                  ? Container(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 8.0),
                        child: Center(
                          child: Lottie.asset('assets/images/nodata.json',
                              height: 250, width: 250),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: ListView.builder(
                                itemBuilder: (contextt, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 5, 15, 10),
                                      child: SupplierCard(
                                          subController
                                              .supplierList.value[index],
                                          context),
                                    ),
                                  );
                                },
                                itemCount: subController.supplierList.length,
                              ))),
                    )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }

/*  void filterSearchResults(String query) {
    final dummySearchList = [];
    dummySearchList.addAll(posController.customerL.value);
    if (query.isNotEmpty) {
      final dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name.toString().toLowerCase().contains(query.toString().toLowerCase())||item.company.toString().toLowerCase().contains(query.toString().toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        posController.customerList.clear();
        posController.customerList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        posController.customerList.clear();
        posController.customerList.addAll(posController.customerL);
      });
    }
  }*/

}
