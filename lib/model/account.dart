class Account {
  int accountId;
  String userName;
  String password;
  String name;
  bool fromCache = false;

  Account({this.accountId, this.name, this.userName, this.password, this.fromCache});

  Map<String, dynamic> toJson() => {
    'accountId': accountId,
    'name': name,
    'userName': userName,
    'password': password,
  };

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(accountId: json['accountId'],
    name: json['name'], userName: json['userName'], password: json['password']);
  }
}