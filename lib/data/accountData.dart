//账号信息数据
class AccountData {
  String amount;
  String country;
  String currency_uuid;
  String currency_code;
  String currency_name;
  String uncash_amount;
  String freeze_cash_amount;
  String freeze_uncash_amount;
  String status;
  String account_type;

  AccountData({this.currency_code, this.amount});
}
