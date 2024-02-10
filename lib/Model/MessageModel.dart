class MessageModel {
  MessageModel({
    required this.msg,
    required this.read,
    required this.told,
    required this.type,
    required this.fromid,
    required this.sent,
  });
  late final String msg;
  late final String read;
  late final String told;
  late final Type type;
  late final String fromid;
  late final String sent;

  MessageModel.fromJson(Map<String, dynamic> json){
    msg = json['msg'].toString();
    read = json['read'].toString();
    told = json['told'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    fromid = json['fromid'].toString();
    sent = json['sent'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = msg;
    data['read'] = read;
    data['told'] = told;
    data['type'] = type;
    data['fromid'] = fromid;
    data['sent'] = sent;
    return data;
  }
}

enum Type{text,image}