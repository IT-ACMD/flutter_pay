//用户银行卡信息数据
class BankInfo {
  ///uuid
  String id;

  ///银行卡类型名称 (中国建设，中国工商)
  String bankName;

  ///银行卡用户名
  String cardUser;

  ///银行卡卡号
  String cardNumber;

  ///银行卡开户行 (中国建设银行北京新华支行，中国建设银行北京新华支行)
  String branch;

  BankInfo([
    this.bankName,
    this.cardUser,
    this.cardNumber,
    this.branch,
  ]);
}
