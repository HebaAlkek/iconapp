// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Price : `
  String get price {
    return Intl.message(
      'Price : ',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `cash`
  String get cash {
    return Intl.message(
      'cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `cc`
  String get cc {
    return Intl.message(
      'cc',
      name: 'cc',
      desc: '',
      args: [],
    );
  }

  /// `other`
  String get other {
    return Intl.message(
      'other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Select Biller`
  String get selectb {
    return Intl.message(
      'Select Biller',
      name: 'selectb',
      desc: '',
      args: [],
    );
  }

  /// `Biller`
  String get biller {
    return Intl.message(
      'Biller',
      name: 'biller',
      desc: '',
      args: [],
    );
  }

  /// `Add more details`
  String get adddetails {
    return Intl.message(
      'Add more details',
      name: 'adddetails',
      desc: '',
      args: [],
    );
  }

  /// `Sale Note`
  String get saleN {
    return Intl.message(
      'Sale Note',
      name: 'saleN',
      desc: '',
      args: [],
    );
  }

  /// `Staff Note`
  String get staffN {
    return Intl.message(
      'Staff Note',
      name: 'staffN',
      desc: '',
      args: [],
    );
  }

  /// `Paying by`
  String get paying {
    return Intl.message(
      'Paying by',
      name: 'paying',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get dones {
    return Intl.message(
      'Done',
      name: 'dones',
      desc: '',
      args: [],
    );
  }

  /// `You cannot make a return because the status of the purchase is not received`
  String get msgpur {
    return Intl.message(
      'You cannot make a return because the status of the purchase is not received',
      name: 'msgpur',
      desc: '',
      args: [],
    );
  }

  /// `You do not have the authority to perform a return operation`
  String get noper {
    return Intl.message(
      'You do not have the authority to perform a return operation',
      name: 'noper',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to exit app?`
  String get exitapp {
    return Intl.message(
      'Do you want to exit app?',
      name: 'exitapp',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get Amount {
    return Intl.message(
      'Amount',
      name: 'Amount',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get Quantity {
    return Intl.message(
      'Quantity',
      name: 'Quantity',
      desc: '',
      args: [],
    );
  }

  /// ` Items `
  String get Items {
    return Intl.message(
      ' Items ',
      name: 'Items',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get Total {
    return Intl.message(
      'Total Amount',
      name: 'Total',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get Error {
    return Intl.message(
      'Error',
      name: 'Error',
      desc: '',
      args: [],
    );
  }

  /// `Please select biller`
  String get pleaseb {
    return Intl.message(
      'Please select biller',
      name: 'pleaseb',
      desc: '',
      args: [],
    );
  }

  /// `The values of the payment entered is greater than the value of the invoice. Please review the values entered`
  String get max {
    return Intl.message(
      'The values of the payment entered is greater than the value of the invoice. Please review the values entered',
      name: 'max',
      desc: '',
      args: [],
    );
  }

  /// `The payment values entered are less than the invoice value. Please review the entered values`
  String get min {
    return Intl.message(
      'The payment values entered are less than the invoice value. Please review the entered values',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get Add {
    return Intl.message(
      'Add',
      name: 'Add',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get Company {
    return Intl.message(
      'Company',
      name: 'Company',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `VAT Number`
  String get vat {
    return Intl.message(
      'VAT Number',
      name: 'vat',
      desc: '',
      args: [],
    );
  }

  /// `GST Number`
  String get gst {
    return Intl.message(
      'GST Number',
      name: 'gst',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get Phone {
    return Intl.message(
      'Phone',
      name: 'Phone',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get Address {
    return Intl.message(
      'Address',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get postal {
    return Intl.message(
      'Postal Code',
      name: 'postal',
      desc: '',
      args: [],
    );
  }

  /// `Customer Custom Field 1`
  String get customero {
    return Intl.message(
      'Customer Custom Field 1',
      name: 'customero',
      desc: '',
      args: [],
    );
  }

  /// `Customer Custom Field 2`
  String get customert {
    return Intl.message(
      'Customer Custom Field 2',
      name: 'customert',
      desc: '',
      args: [],
    );
  }

  /// `Customer Custom Field 3`
  String get customerth {
    return Intl.message(
      'Customer Custom Field 3',
      name: 'customerth',
      desc: '',
      args: [],
    );
  }

  /// `Customer Custom Field 4`
  String get customerf {
    return Intl.message(
      'Customer Custom Field 4',
      name: 'customerf',
      desc: '',
      args: [],
    );
  }

  /// `Customer Custom Field 5`
  String get customerfi {
    return Intl.message(
      'Customer Custom Field 5',
      name: 'customerfi',
      desc: '',
      args: [],
    );
  }

  /// `Customer Custom Field 6`
  String get customerse {
    return Intl.message(
      'Customer Custom Field 6',
      name: 'customerse',
      desc: '',
      args: [],
    );
  }

  /// `Customer Group`
  String get customerg {
    return Intl.message(
      'Customer Group',
      name: 'customerg',
      desc: '',
      args: [],
    );
  }

  /// `Price Group`
  String get priceg {
    return Intl.message(
      'Price Group',
      name: 'priceg',
      desc: '',
      args: [],
    );
  }

  /// `Your location`
  String get location {
    return Intl.message(
      'Your location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Select Warehouse`
  String get selectw {
    return Intl.message(
      'Select Warehouse',
      name: 'selectw',
      desc: '',
      args: [],
    );
  }

  /// `Select Customer`
  String get selectc {
    return Intl.message(
      'Select Customer',
      name: 'selectc',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get Products {
    return Intl.message(
      'Products',
      name: 'Products',
      desc: '',
      args: [],
    );
  }

  /// `Edit Price`
  String get editp {
    return Intl.message(
      'Edit Price',
      name: 'editp',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get Edit {
    return Intl.message(
      'Edit',
      name: 'Edit',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Barcode Type:`
  String get barcode {
    return Intl.message(
      'Barcode Type:',
      name: 'barcode',
      desc: '',
      args: [],
    );
  }

  /// `Scan a code`
  String get scan {
    return Intl.message(
      'Scan a code',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Flash:`
  String get Flash {
    return Intl.message(
      'Flash:',
      name: 'Flash',
      desc: '',
      args: [],
    );
  }

  /// `Camera facing`
  String get camer {
    return Intl.message(
      'Camera facing',
      name: 'camer',
      desc: '',
      args: [],
    );
  }

  /// `loading`
  String get loading {
    return Intl.message(
      'loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `pause`
  String get pause {
    return Intl.message(
      'pause',
      name: 'pause',
      desc: '',
      args: [],
    );
  }

  /// `resum`
  String get resume {
    return Intl.message(
      'resum',
      name: 'resume',
      desc: '',
      args: [],
    );
  }

  /// `no Permission`
  String get per {
    return Intl.message(
      'no Permission',
      name: 'per',
      desc: '',
      args: [],
    );
  }

  /// `Product details`
  String get Productdetails {
    return Intl.message(
      'Product details',
      name: 'Productdetails',
      desc: '',
      args: [],
    );
  }

  /// `Type : `
  String get Type {
    return Intl.message(
      'Type : ',
      name: 'Type',
      desc: '',
      args: [],
    );
  }

  /// `Brand : `
  String get Brand {
    return Intl.message(
      'Brand : ',
      name: 'Brand',
      desc: '',
      args: [],
    );
  }

  /// `Category : `
  String get cat {
    return Intl.message(
      'Category : ',
      name: 'cat',
      desc: '',
      args: [],
    );
  }

  /// `Unit : `
  String get unit {
    return Intl.message(
      'Unit : ',
      name: 'unit',
      desc: '',
      args: [],
    );
  }

  /// `Tax Rate : `
  String get TaxRate {
    return Intl.message(
      'Tax Rate : ',
      name: 'TaxRate',
      desc: '',
      args: [],
    );
  }

  /// `Tax Method : `
  String get TaxMethod {
    return Intl.message(
      'Tax Method : ',
      name: 'TaxMethod',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addcart {
    return Intl.message(
      'Add to cart',
      name: 'addcart',
      desc: '',
      args: [],
    );
  }

  /// `Search product by name`
  String get search {
    return Intl.message(
      'Search product by name',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get Categories {
    return Intl.message(
      'Categories',
      name: 'Categories',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get Category {
    return Intl.message(
      'Category',
      name: 'Category',
      desc: '',
      args: [],
    );
  }

  /// `Sub Category`
  String get sub {
    return Intl.message(
      'Sub Category',
      name: 'sub',
      desc: '',
      args: [],
    );
  }

  /// `Brands`
  String get Brands {
    return Intl.message(
      'Brands',
      name: 'Brands',
      desc: '',
      args: [],
    );
  }

  /// `Cash in hand`
  String get cashh {
    return Intl.message(
      'Cash in hand',
      name: 'cashh',
      desc: '',
      args: [],
    );
  }

  /// `Please insert cash value`
  String get pleasecash {
    return Intl.message(
      'Please insert cash value',
      name: 'pleasecash',
      desc: '',
      args: [],
    );
  }

  /// `Open Register`
  String get openre {
    return Intl.message(
      'Open Register',
      name: 'openre',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get usern {
    return Intl.message(
      'User name',
      name: 'usern',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `* Please insert your password`
  String get isertp {
    return Intl.message(
      '* Please insert your password',
      name: 'isertp',
      desc: '',
      args: [],
    );
  }

  /// `* Please insert username`
  String get isertu {
    return Intl.message(
      '* Please insert username',
      name: 'isertu',
      desc: '',
      args: [],
    );
  }

  /// `* Please insert your email`
  String get iserte {
    return Intl.message(
      '* Please insert your email',
      name: 'iserte',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is incorrect`
  String get validn {
    return Intl.message(
      'Phone number is incorrect',
      name: 'validn',
      desc: '',
      args: [],
    );
  }

  /// `* Please insert mobile number`
  String get isertph {
    return Intl.message(
      '* Please insert mobile number',
      name: 'isertph',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the following data to be able to try the system`
  String get additem {
    return Intl.message(
      'Please fill in the following data to be able to try the system',
      name: 'additem',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get addp {
    return Intl.message(
      'Products',
      name: 'addp',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get addc {
    return Intl.message(
      'Customers',
      name: 'addc',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changel {
    return Intl.message(
      'Change Language',
      name: 'changel',
      desc: '',
      args: [],
    );
  }

  /// `Sub domain`
  String get subd {
    return Intl.message(
      'Sub domain',
      name: 'subd',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get Submit {
    return Intl.message(
      'Submit',
      name: 'Submit',
      desc: '',
      args: [],
    );
  }

  /// `Sub domain is not exits`
  String get notexit {
    return Intl.message(
      'Sub domain is not exits',
      name: 'notexit',
      desc: '',
      args: [],
    );
  }

  /// `* Please insert sub domain`
  String get insertsub {
    return Intl.message(
      '* Please insert sub domain',
      name: 'insertsub',
      desc: '',
      args: [],
    );
  }

  /// `Main Category`
  String get maincat {
    return Intl.message(
      'Main Category',
      name: 'maincat',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get Back {
    return Intl.message(
      'Back',
      name: 'Back',
      desc: '',
      args: [],
    );
  }

  /// `Step`
  String get Step {
    return Intl.message(
      'Step',
      name: 'Step',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Enter sale number`
  String get entert {
    return Intl.message(
      'Enter sale number',
      name: 'entert',
      desc: '',
      args: [],
    );
  }

  /// `* Please enter sale number`
  String get pleaseesn {
    return Intl.message(
      '* Please enter sale number',
      name: 'pleaseesn',
      desc: '',
      args: [],
    );
  }

  /// `Sale Number`
  String get salen {
    return Intl.message(
      'Sale Number',
      name: 'salen',
      desc: '',
      args: [],
    );
  }

  /// `You cannot return a value greater than the base value`
  String get maxerr {
    return Intl.message(
      'You cannot return a value greater than the base value',
      name: 'maxerr',
      desc: '',
      args: [],
    );
  }

  /// `Amount before tax`
  String get pri {
    return Intl.message(
      'Amount before tax',
      name: 'pri',
      desc: '',
      args: [],
    );
  }

  /// `Returned`
  String get retur {
    return Intl.message(
      'Returned',
      name: 'retur',
      desc: '',
      args: [],
    );
  }

  /// `Due`
  String get due {
    return Intl.message(
      'Due',
      name: 'due',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paidd {
    return Intl.message(
      'Paid',
      name: 'paidd',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Scan sale barcode`
  String get enterb {
    return Intl.message(
      'Scan sale barcode',
      name: 'enterb',
      desc: '',
      args: [],
    );
  }

  /// `Add Information`
  String get addi {
    return Intl.message(
      'Add Information',
      name: 'addi',
      desc: '',
      args: [],
    );
  }

  /// `Product Details For Invoice`
  String get detailsin {
    return Intl.message(
      'Product Details For Invoice',
      name: 'detailsin',
      desc: '',
      args: [],
    );
  }

  /// `Product Image`
  String get produxti {
    return Intl.message(
      'Product Image',
      name: 'produxti',
      desc: '',
      args: [],
    );
  }

  /// `Hide in POS Module`
  String get hidepos {
    return Intl.message(
      'Hide in POS Module',
      name: 'hidepos',
      desc: '',
      args: [],
    );
  }

  /// `Custom Fields`
  String get custom {
    return Intl.message(
      'Custom Fields',
      name: 'custom',
      desc: '',
      args: [],
    );
  }

  /// `Product Custom Filed`
  String get field {
    return Intl.message(
      'Product Custom Filed',
      name: 'field',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productn {
    return Intl.message(
      'Product Name',
      name: 'productn',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Name`
  String get arabic {
    return Intl.message(
      'Arabic Name',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Slug`
  String get Slug {
    return Intl.message(
      'Slug',
      name: 'Slug',
      desc: '',
      args: [],
    );
  }

  /// `Weight (KG)`
  String get weight {
    return Intl.message(
      'Weight (KG)',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Product Cost`
  String get cost {
    return Intl.message(
      'Product Cost',
      name: 'cost',
      desc: '',
      args: [],
    );
  }

  /// `Product Price`
  String get propi {
    return Intl.message(
      'Product Price',
      name: 'propi',
      desc: '',
      args: [],
    );
  }

  /// `Product Type`
  String get prot {
    return Intl.message(
      'Product Type',
      name: 'prot',
      desc: '',
      args: [],
    );
  }

  /// `Product Code`
  String get procode {
    return Intl.message(
      'Product Code',
      name: 'procode',
      desc: '',
      args: [],
    );
  }

  /// `Barcode Symbology`
  String get sym {
    return Intl.message(
      'Barcode Symbology',
      name: 'sym',
      desc: '',
      args: [],
    );
  }

  /// `Product Unit`
  String get prounit {
    return Intl.message(
      'Product Unit',
      name: 'prounit',
      desc: '',
      args: [],
    );
  }

  /// `Default Purchase  Unit`
  String get pur {
    return Intl.message(
      'Default Purchase  Unit',
      name: 'pur',
      desc: '',
      args: [],
    );
  }

  /// `Product Tax`
  String get protax {
    return Intl.message(
      'Product Tax',
      name: 'protax',
      desc: '',
      args: [],
    );
  }

  /// `Default Sale Unit`
  String get sale {
    return Intl.message(
      'Default Sale Unit',
      name: 'sale',
      desc: '',
      args: [],
    );
  }

  /// `Sales`
  String get Sales {
    return Intl.message(
      'Sales',
      name: 'Sales',
      desc: '',
      args: [],
    );
  }

  /// `Finalize Sale`
  String get done {
    return Intl.message(
      'Finalize Sale',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Username or password incorrect`
  String get usersE {
    return Intl.message(
      'Username or password incorrect',
      name: 'usersE',
      desc: '',
      args: [],
    );
  }

  /// `Please insert customer name`
  String get inserrtn {
    return Intl.message(
      'Please insert customer name',
      name: 'inserrtn',
      desc: '',
      args: [],
    );
  }

  /// `Your email is not valid`
  String get valid {
    return Intl.message(
      'Your email is not valid',
      name: 'valid',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get selectcou {
    return Intl.message(
      'Select Country',
      name: 'selectcou',
      desc: '',
      args: [],
    );
  }

  /// `Select State`
  String get selectst {
    return Intl.message(
      'Select State',
      name: 'selectst',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get conm {
    return Intl.message(
      'Company Name',
      name: 'conm',
      desc: '',
      args: [],
    );
  }

  /// `Select City`
  String get selectci {
    return Intl.message(
      'Select City',
      name: 'selectci',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get Close {
    return Intl.message(
      'Close',
      name: 'Close',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get Country {
    return Intl.message(
      'Country',
      name: 'Country',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get State {
    return Intl.message(
      'State',
      name: 'State',
      desc: '',
      args: [],
    );
  }

  /// `Supplier`
  String get suppl {
    return Intl.message(
      'Supplier',
      name: 'suppl',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Status`
  String get purstate {
    return Intl.message(
      'Purchase Status',
      name: 'purstate',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get paystate {
    return Intl.message(
      'Payment Status',
      name: 'paystate',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get City {
    return Intl.message(
      'City',
      name: 'City',
      desc: '',
      args: [],
    );
  }

  /// `Search here...`
  String get searchh {
    return Intl.message(
      'Search here...',
      name: 'searchh',
      desc: '',
      args: [],
    );
  }

  /// `Supplier`
  String get supplier {
    return Intl.message(
      'Supplier',
      name: 'supplier',
      desc: '',
      args: [],
    );
  }

  /// `Select supplier`
  String get selectsup {
    return Intl.message(
      'Select supplier',
      name: 'selectsup',
      desc: '',
      args: [],
    );
  }

  /// `Supplier Number`
  String get supno {
    return Intl.message(
      'Supplier Number',
      name: 'supno',
      desc: '',
      args: [],
    );
  }

  /// `Supplier price`
  String get supp {
    return Intl.message(
      'Supplier price',
      name: 'supp',
      desc: '',
      args: [],
    );
  }

  /// `The maximum allowed is 5 suppliers`
  String get maxs {
    return Intl.message(
      'The maximum allowed is 5 suppliers',
      name: 'maxs',
      desc: '',
      args: [],
    );
  }

  /// `Select Product`
  String get product {
    return Intl.message(
      'Select Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Digital File`
  String get digita {
    return Intl.message(
      'Digital File',
      name: 'digita',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `File Link`
  String get fileu {
    return Intl.message(
      'File Link',
      name: 'fileu',
      desc: '',
      args: [],
    );
  }

  /// `Please select product type`
  String get pleases {
    return Intl.message(
      'Please select product type',
      name: 'pleases',
      desc: '',
      args: [],
    );
  }

  /// `Please insert all data is required`
  String get insetdata {
    return Intl.message(
      'Please insert all data is required',
      name: 'insetdata',
      desc: '',
      args: [],
    );
  }

  /// `Alert Quantity`
  String get alert {
    return Intl.message(
      'Alert Quantity',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `Promotion`
  String get pro {
    return Intl.message(
      'Promotion',
      name: 'pro',
      desc: '',
      args: [],
    );
  }

  /// `Promotion Price`
  String get proprice {
    return Intl.message(
      'Promotion Price',
      name: 'proprice',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get dates {
    return Intl.message(
      'Start Date',
      name: 'dates',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get datee {
    return Intl.message(
      'End Date',
      name: 'datee',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get Price {
    return Intl.message(
      'Price',
      name: 'Price',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get passnew {
    return Intl.message(
      'New Password',
      name: 'passnew',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentp {
    return Intl.message(
      'Current Password',
      name: 'currentp',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get conP {
    return Intl.message(
      'Confirm New Password',
      name: 'conP',
      desc: '',
      args: [],
    );
  }

  /// `* Please insert New password`
  String get isertnp {
    return Intl.message(
      '* Please insert New password',
      name: 'isertnp',
      desc: '',
      args: [],
    );
  }

  /// `* Please insert Confirm password`
  String get isertcp {
    return Intl.message(
      '* Please insert Confirm password',
      name: 'isertcp',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changep {
    return Intl.message(
      'Change Password',
      name: 'changep',
      desc: '',
      args: [],
    );
  }

  /// `The two passwords do not match`
  String get notmatch {
    return Intl.message(
      'The two passwords do not match',
      name: 'notmatch',
      desc: '',
      args: [],
    );
  }

  /// `The old passwords incorrect`
  String get oldpassincor {
    return Intl.message(
      'The old passwords incorrect',
      name: 'oldpassincor',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get addcat {
    return Intl.message(
      'Categories',
      name: 'addcat',
      desc: '',
      args: [],
    );
  }

  /// `Sub Categories`
  String get addsubc {
    return Intl.message(
      'Sub Categories',
      name: 'addsubc',
      desc: '',
      args: [],
    );
  }

  /// `Category Code`
  String get catcode {
    return Intl.message(
      'Category Code',
      name: 'catcode',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get catname {
    return Intl.message(
      'Category Name',
      name: 'catname',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get desc {
    return Intl.message(
      'Description',
      name: 'desc',
      desc: '',
      args: [],
    );
  }

  /// `Category Image`
  String get catImg {
    return Intl.message(
      'Category Image',
      name: 'catImg',
      desc: '',
      args: [],
    );
  }

  /// `Brand Code`
  String get brandcode {
    return Intl.message(
      'Brand Code',
      name: 'brandcode',
      desc: '',
      args: [],
    );
  }

  /// `Brand Name`
  String get brandname {
    return Intl.message(
      'Brand Name',
      name: 'brandname',
      desc: '',
      args: [],
    );
  }

  /// `Brand Image`
  String get brandImg {
    return Intl.message(
      'Brand Image',
      name: 'brandImg',
      desc: '',
      args: [],
    );
  }

  /// `Brands`
  String get addBrand {
    return Intl.message(
      'Brands',
      name: 'addBrand',
      desc: '',
      args: [],
    );
  }

  /// `Sub Category Code`
  String get catcodesub {
    return Intl.message(
      'Sub Category Code',
      name: 'catcodesub',
      desc: '',
      args: [],
    );
  }

  /// `Sub Category Name`
  String get catnamesub {
    return Intl.message(
      'Sub Category Name',
      name: 'catnamesub',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get allcat {
    return Intl.message(
      'All Categories',
      name: 'allcat',
      desc: '',
      args: [],
    );
  }

  /// `All Brands`
  String get allb {
    return Intl.message(
      'All Brands',
      name: 'allb',
      desc: '',
      args: [],
    );
  }

  /// `All Sub Category`
  String get alls {
    return Intl.message(
      'All Sub Category',
      name: 'alls',
      desc: '',
      args: [],
    );
  }

  /// `Code : `
  String get code {
    return Intl.message(
      'Code : ',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Action Faild,Customer have sales`
  String get deletecu {
    return Intl.message(
      'Action Faild,Customer have sales',
      name: 'deletecu',
      desc: '',
      args: [],
    );
  }

  /// `Category Details`
  String get catde {
    return Intl.message(
      'Category Details',
      name: 'catde',
      desc: '',
      args: [],
    );
  }

  /// `Add Customer`
  String get addcu {
    return Intl.message(
      'Add Customer',
      name: 'addcu',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Id`
  String get id {
    return Intl.message(
      'Id',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Sub Category Details`
  String get catdesub {
    return Intl.message(
      'Sub Category Details',
      name: 'catdesub',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get report {
    return Intl.message(
      'Reports',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Sales Report`
  String get saleR {
    return Intl.message(
      'Sales Report',
      name: 'saleR',
      desc: '',
      args: [],
    );
  }

  /// `Taxes Report`
  String get taxR {
    return Intl.message(
      'Taxes Report',
      name: 'taxR',
      desc: '',
      args: [],
    );
  }

  /// `Sales`
  String get sales {
    return Intl.message(
      'Sales',
      name: 'sales',
      desc: '',
      args: [],
    );
  }

  /// `Purchases`
  String get puschae {
    return Intl.message(
      'Purchases',
      name: 'puschae',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Add Purchase`
  String get addpur {
    return Intl.message(
      'Add Purchase',
      name: 'addpur',
      desc: '',
      args: [],
    );
  }

  /// `Add Supplier`
  String get addsup {
    return Intl.message(
      'Add Supplier',
      name: 'addsup',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get statue {
    return Intl.message(
      'Status',
      name: 'statue',
      desc: '',
      args: [],
    );
  }

  /// `Warehouse`
  String get ware {
    return Intl.message(
      'Warehouse',
      name: 'ware',
      desc: '',
      args: [],
    );
  }

  /// `Product Tax`
  String get protx {
    return Intl.message(
      'Product Tax',
      name: 'protx',
      desc: '',
      args: [],
    );
  }

  /// `Order Tax`
  String get ordertax {
    return Intl.message(
      'Order Tax',
      name: 'ordertax',
      desc: '',
      args: [],
    );
  }

  /// `Biller`
  String get bil {
    return Intl.message(
      'Biller',
      name: 'bil',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get print {
    return Intl.message(
      'Print',
      name: 'print',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get action {
    return Intl.message(
      'Action',
      name: 'action',
      desc: '',
      args: [],
    );
  }

  /// `Add Return`
  String get addr {
    return Intl.message(
      'Add Return',
      name: 'addr',
      desc: '',
      args: [],
    );
  }

  /// `Return Sale`
  String get returnsale {
    return Intl.message(
      'Return Sale',
      name: 'returnsale',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Product(QTY)`
  String get productq {
    return Intl.message(
      'Product(QTY)',
      name: 'productq',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Details`
  String get invoiced {
    return Intl.message(
      'Invoice Details',
      name: 'invoiced',
      desc: '',
      args: [],
    );
  }

  /// `Biller Name`
  String get billern {
    return Intl.message(
      'Biller Name',
      name: 'billern',
      desc: '',
      args: [],
    );
  }

  /// `Reference No`
  String get refno {
    return Intl.message(
      'Reference No',
      name: 'refno',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Date`
  String get invoicedate {
    return Intl.message(
      'Invoice Date',
      name: 'invoicedate',
      desc: '',
      args: [],
    );
  }

  /// `Tax Price`
  String get taxpr {
    return Intl.message(
      'Tax Price',
      name: 'taxpr',
      desc: '',
      args: [],
    );
  }

  /// `This payment method is pre-tested`
  String get payerror {
    return Intl.message(
      'This payment method is pre-tested',
      name: 'payerror',
      desc: '',
      args: [],
    );
  }

  /// `Grand Total`
  String get grand {
    return Intl.message(
      'Grand Total',
      name: 'grand',
      desc: '',
      args: [],
    );
  }

  /// `Tax Number`
  String get taxn {
    return Intl.message(
      'Tax Number',
      name: 'taxn',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR Code`
  String get qrc {
    return Intl.message(
      'Scan QR Code',
      name: 'qrc',
      desc: '',
      args: [],
    );
  }

  /// `You have 3 failed login attempts. Please try again in 10 minutes`
  String get fail {
    return Intl.message(
      'You have 3 failed login attempts. Please try again in 10 minutes',
      name: 'fail',
      desc: '',
      args: [],
    );
  }

  /// `This code is invalid`
  String get errorqr {
    return Intl.message(
      'This code is invalid',
      name: 'errorqr',
      desc: '',
      args: [],
    );
  }

  /// `Use a trial version ! `
  String get guest {
    return Intl.message(
      'Use a trial version ! ',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Amount`
  String get tota {
    return Intl.message(
      'Invoice Amount',
      name: 'tota',
      desc: '',
      args: [],
    );
  }

  /// `VAT Number`
  String get vatnum {
    return Intl.message(
      'VAT Number',
      name: 'vatnum',
      desc: '',
      args: [],
    );
  }

  /// `Access Denied! You don't have right to access the requested page. If you think, it's by mistake, please contact system administrator.`
  String get accesss {
    return Intl.message(
      'Access Denied! You don\'t have right to access the requested page. If you think, it\'s by mistake, please contact system administrator.',
      name: 'accesss',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get sr {
    return Intl.message(
      'SAR',
      name: 'sr',
      desc: '',
      args: [],
    );
  }

  /// `Product By`
  String get proby {
    return Intl.message(
      'Product By',
      name: 'proby',
      desc: '',
      args: [],
    );
  }

  /// `VAT Amount`
  String get vatamount {
    return Intl.message(
      'VAT Amount',
      name: 'vatamount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}