

import 'message.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppService extends ChangeNotifier {
  //supabase bağlantısı...
  final _supabase = Supabase.instance.client;
  final   _password = 'asnh!ASsdlz235';
// otomatik test kullanıcı oluşturmak.
  Future<void> _createUser(int i) async {
     final response = await _supabase.auth.signUp(
    email: 'test_$i@test.com',
    password: _password,
  );


    await _supabase
        .from('contact')
        .insert({'id': response.user!.id, 'username': 'User $i'});
  }
// burada create user olarak degil supabase den alınan veriye göre entegre edilecek şimdilik test amaçlıdır.
  Future<void> createUsers() async {
    await _createUser(1);
    await _createUser(2);
  }
//giriş
  Future<void> signIn(int i) async {
    await _supabase.auth.signInWithPassword(email: 'test_$i@test.com', password: _password);
  }
//çıkış
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
// iletşim kuracağı kişinin idsini almak.
  Future<String> _getUserTo() async {
    final response = await _supabase
        .from('contact')
        .select('id')
        .not('id', 'eq', getCurrentUserId()).execute();

    return response.data[0]['id'];
  }
/// yaziları tekrar kontrol et.
  Stream<List<Message>> getMessages() {
    return _supabase
        .from('message')
        .stream(primaryKey: ['id'])
        .order('created_at')
        
        .map((maps) => maps
            .map((item) => Message.fromJson(item, getCurrentUserId()))
            .toList());
  }
// gönderen kişinin alıcıya nasıl nesaj göndermesi...
  Future<void> saveMessage(String content) async {

    final userTo = await _getUserTo();

    final message = Message.create(
        Konu: content, Gonderen: getCurrentUserId(), Alici: userTo);

    await _supabase.from('message').insert(message.toMap());
  }
// mesaj okunma kontrolu
  Future<void> markAsRead(String messageId) async {
    await _supabase
        .from('message')
        .update({'mark_as_read': true})
        .eq('id', messageId);
       
  }
// giriş kontrolu

  bool isAuthentificated() => _supabase.auth.currentUser != null;

  String getCurrentUserId() =>
      isAuthentificated() ? _supabase.auth.currentUser!.id : '';

  String getCurrentUserEmail() =>
      isAuthentificated() ? _supabase.auth.currentUser!.email ?? '' : '';
}