//账号信息数据
class AccountData {
  String accessToken; //
  String nickName; //账户名称
  String userName; //真实姓名
  String wechatOpenId; //绑定微信openid
  String phone;
  String userId;
  String avatarUrl; //头像
  String backgroundUrl; //背景墙
  int level; //会员等级
  String type;
  String remark; //备注签名
  String heartRateAlert; //心率提醒

  AccountData(
      {this.accessToken,
      this.nickName,
      this.userName,
      this.wechatOpenId,
      this.phone,
      this.userId,
      this.avatarUrl,
      this.backgroundUrl,
      this.level,
      this.type,
      this.remark});
}
