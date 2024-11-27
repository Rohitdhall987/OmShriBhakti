class FreeWallet {
  FreeWallet({
    required this.message,
    required this.amount,
  });
  late final String message;
  late final String amount;

  FreeWallet.fromJson(Map<String, dynamic> json){
    message = json['message'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['amount'] = amount;
    return _data;
  }
}