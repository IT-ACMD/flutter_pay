mixin ToAlias {}

@deprecated
class CElement = CountryCode with ToAlias;

/// Country element. This is the element that contains all the information
class CountryCode {
  /// the name of the country
  String name;

  /// the flag of the country
  String flagUri;

  /// the country code (IT,AF..)
  String code;

  /// the dial code (+39,+93..)
  String dialCode;

  /// the bi zhong (CNY,USD)
  String currency;

  /// the uusid
  String id;

  CountryCode(
      {this.name, this.flagUri, this.code, this.dialCode, this.currency, this.id});

  @override
  String toString() => "$dialCode";

  String toLongString() => "$name $currency ";

  String toCountryStringOnly() => '$name';
}
