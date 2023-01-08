import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:icon/generated/l10n.dart';

class CountryModel {
  String id;
  String sortName;
  String name;
  String phoneCode;

  CountryModel(
      {required this.id,
      required this.sortName,
      required this.name,
      required this.phoneCode});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
        id: json['id'] as String,
        sortName: json['sortname'] as String,
        name: json['name'] as String,
        phoneCode: json['phonecode'] as String);
  }
}

class StateModel {
  String id;
  String name;
  String countryId;

  StateModel({required this.id, required this.name, required this.countryId});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
        id: json['id'] as String,
        name: json['name'] as String,
        countryId: json['country_id'] as String);
  }
}

class CityModel {
  String id;
  String name;
  String stateId;

  CityModel({required this.id, required this.name, required this.stateId});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      stateId: json['state_id'] as String,
    );
  }
}

class CountryStateCityPicker extends StatefulWidget {
  TextEditingController country;
  TextEditingController state;
  TextEditingController city;
  InputBorder? textFieldInputBorder;

  CountryStateCityPicker(
      {required this.country,
      required this.state,
      required this.city,
      this.textFieldInputBorder});

  @override
  _CountryStateCityPickerState createState() => _CountryStateCityPickerState();
}

class _CountryStateCityPickerState extends State<CountryStateCityPicker> {
  List<CountryModel> _countryList = [];
  List<StateModel> _stateList = [];
  List<CityModel> _cityList = [];

  List<CountryModel> _countrySubList = [];
  List<StateModel> _stateSubList = [];
  List<CityModel> _citySubList = [];
  String _title = '';

  @override
  void initState() {
    super.initState();
    _getCountry();
  }

  Future<void> _getCountry() async {
    _countryList.clear();
    var jsonString = await rootBundle
        .loadString('packages/country_state_city_pro/assets/country.json');
    List<dynamic> body = json.decode(jsonString);
    setState(() {
      _countryList =
          body.map((dynamic item) => CountryModel.fromJson(item)).toList();
      _countrySubList = _countryList;
    });
  }

  Future<void> _getState(String countryId) async {
    _stateList.clear();
    _cityList.clear();
    List<StateModel> _subStateList = [];
    var jsonString = await rootBundle
        .loadString('packages/country_state_city_pro/assets/state.json');
    List<dynamic> body = json.decode(jsonString);

    _subStateList =
        body.map((dynamic item) => StateModel.fromJson(item)).toList();
    _subStateList.forEach((element) {
      if (element.countryId == countryId) {
        setState(() {
          _stateList.add(element);
        });
      }
    });
    _stateSubList = _stateList;
  }

  Future<void> _getCity(String stateId) async {
    _cityList.clear();
    List<CityModel> _subCityList = [];
    var jsonString = await rootBundle
        .loadString('packages/country_state_city_pro/assets/city.json');
    List<dynamic> body = json.decode(jsonString);

    _subCityList =
        body.map((dynamic item) => CityModel.fromJson(item)).toList();
    _subCityList.forEach((element) {
      if (element.stateId == stateId) {
        setState(() {
          _cityList.add(element);
        });
      }
    });
    _citySubList = _cityList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Country TextField
        ///
        SizedBox(
          height: 20,
        ),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF002e80), blurRadius: 1, spreadRadius: 0)
                ]),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                child: TextField(
                  controller: widget.country,
                  style: TextStyle(color: Color(0xFF002e80)),
                  onTap: () {
                    setState(() => _title = 'Country');
                    _showDialog(context);
                  },
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(15),
                      labelStyle: TextStyle(color: Color(0xFF002e80)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: S.of(context).selectcou,
                      hintStyle: TextStyle(color: Color(0xFF002e80)),
                      suffixIcon:
                          Icon(Icons.arrow_drop_down, color: Color(0xFF002e80)),
                      border:
                          widget.textFieldInputBorder ?? OutlineInputBorder()),
                  readOnly: true,
                ))),
        SizedBox(height: 20.0),

        ///State TextField
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF002e80), blurRadius: 1, spreadRadius: 0)
                ]),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                child: TextField(                  style: TextStyle(color: Color(0xFF002e80)),

                  controller: widget.state,
                  onTap: () {
                    setState(() => _title = 'State');
                    if (widget.country.text.isNotEmpty)
                      _showDialog(context);
                    else
                      _showSnackBar(S.of(context).selectcou);
                  },
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(15),
                      labelStyle: TextStyle(color: Color(0xFF002e80)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: S.of(context).selectst,
                      hintStyle: TextStyle(color: Color(0xFF002e80)),
                      suffixIcon:
                          Icon(Icons.arrow_drop_down, color: Color(0xFF002e80)),
                      border:
                          widget.textFieldInputBorder ?? OutlineInputBorder()),
                  readOnly: true,
                ))),
        SizedBox(height: 20.0),

        ///City TextField
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF002e80), blurRadius: 1, spreadRadius: 0)
                ]),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                child: TextField(                  style: TextStyle(color: Color(0xFF002e80)),

                  controller: widget.city,
                  onTap: () {
                    setState(() => _title = 'City');
                    if (widget.state.text.isNotEmpty)
                      _showDialog(context);
                    else
                      _showSnackBar(S.of(context).selectst);
                  },
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(15),
                      labelStyle: TextStyle(color: Color(0xFF002e80)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText:S.of(context).selectci,
                      hintStyle: TextStyle(color: Color(0xFF002e80)),
                      suffixIcon:
                          Icon(Icons.arrow_drop_down, color: Color(0xFF002e80)),
                      border:
                          widget.textFieldInputBorder ?? OutlineInputBorder()),
                  readOnly: true,
                ))),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    TextEditingController _controller2 = TextEditingController();
    TextEditingController _controller3 = TextEditingController();

    showGeneralDialog(
      barrierLabel: _title,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context, __, ___) {
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  margin: EdgeInsets.only(top: 60, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(_title=='Country'?S.of(context).Country:_title=="City"?S.of(context).City:S.of(context).State,
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),

                      ///Text Field
                      TextField(
                        controller: _title == 'Country'
                            ? _controller
                            : _title == 'State'
                                ? _controller2
                                : _controller3,
                        onChanged: (val) {
                          setState(() {
                            if (_title == 'Country') {
                              _countrySubList = _countryList
                                  .where((element) => element.name
                                      .toLowerCase()
                                      .contains(_controller.text.toLowerCase()))
                                  .toList();
                            } else if (_title == 'State') {
                              _stateSubList = _stateList
                                  .where((element) => element.name
                                      .toLowerCase()
                                      .contains(
                                          _controller2.text.toLowerCase()))
                                  .toList();
                            } else if (_title == 'City') {
                              _citySubList = _cityList
                                  .where((element) => element.name
                                      .toLowerCase()
                                      .contains(
                                          _controller3.text.toLowerCase()))
                                  .toList();
                            }
                          });
                        },
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 16.0),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: S.of(context).searchh,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            isDense: true,
                            prefixIcon: Icon(Icons.search)),
                      ),

                      ///Dropdown Items
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: _title == 'Country'
                                ? _countrySubList.length
                                : _title == 'State'
                                    ? _stateSubList.length
                                    : _citySubList.length,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  setState(() {
                                    if (_title == "Country") {
                                      widget.country.text =
                                          _countrySubList[index].name;
                                      _getState(_countrySubList[index].id);
                                      _countrySubList = _countryList;
                                      widget.state.clear();
                                      widget.city.clear();
                                    } else if (_title == 'State') {
                                      widget.state.text =
                                          _stateSubList[index].name;
                                      _getCity(_stateSubList[index].id);
                                      _stateSubList = _stateList;
                                      widget.city.clear();
                                    } else if (_title == 'City') {
                                      widget.city.text =
                                          _citySubList[index].name;
                                      _citySubList = _cityList;
                                    }
                                  });
                                  _controller.clear();
                                  _controller2.clear();
                                  _controller3.clear();
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 20.0, left: 10.0, right: 10.0),
                                  child: Text(
                                      _title == 'Country'
                                          ? _countrySubList[index].name
                                          : _title == 'State'
                                              ? _stateSubList[index].name
                                              : _citySubList[index].name,
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 16.0)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_title == 'City' && _citySubList.isEmpty) {
                            widget.city.text = _controller3.text;
                          }
                          _countrySubList = _countryList;
                          _stateSubList = _stateList;
                          _citySubList = _cityList;

                          _controller.clear();
                          _controller2.clear();
                          _controller3.clear();
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).Close),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0))));
  }
}
