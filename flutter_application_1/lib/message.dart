

class Message{
  final String Id;
final String Konu;
final String Alici;
final String Gonderen;
final DateTime OlusturulmaTarih;
final bool isMine;
final bool Okundu;

    Message({
      required this.Id,
 required this.Konu,
 required this.Alici,
 required this.Gonderen,
 required this.OlusturulmaTarih,
 required this.isMine,
 required this.Okundu,
    });
    Message.create({
      required this.Konu,required this.Gonderen, required this.Alici
    }):Id="", Okundu=false, isMine=true,OlusturulmaTarih=DateTime.now();

    Message.fromJson(Map<String,dynamic> json,String userId)
    :Id=json["id"],
    Konu=json["content"],
    OlusturulmaTarih=DateTime.parse(json["created_at"]),
    Okundu=json["mark_as_read"],
    isMine=json["user_from"]==userId,
    Alici=json["user_to"],
    Gonderen=json["user_from"];
    
    Map toMap(){
      return {'content':Konu,'user_from':Gonderen,'user_to':Alici,'mark_as_read':Okundu
    };
    }
}