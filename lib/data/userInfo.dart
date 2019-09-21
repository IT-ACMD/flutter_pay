//用户信息数据
class UserInfo {
  String accessToken;
  String sex; //性别
  String phone; //手机号
  String pwdPhone; //手机号
  String email; //邮箱
  String identityCard; //身份证号
  String cardId; //卡号
  String name;
  String age;

  UserInfo({
    //@required this.padding,
    this.sex,
    this.phone,
    this.pwdPhone,
    this.email,
    this.identityCard,
    this.cardId,
    this.name,
    this.age,
  });
}
