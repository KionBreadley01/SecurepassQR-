import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  late Db _db;

  MongoDBService() {
    _connect();
  }

  Future<void> _connect() async {
    var client = Db('mongodb://root:@localhost:27017/SecurePassQR');
    await client.open();
    _db = client;
  }

  Future<bool> authenticateUser(String username, String password) async {
    var collection = _db.collection('alumnos');
    var user = await collection.findOne(
        where.eq('Usuario', username).eq('Contraseña', password));
    return user != null;
  }
}
