import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  late Db _db;

  MongoDBService() {
    _connect();
  }

  Future<void> _connect() async {
    var client = Db("mongodb+srv://username:Don_gato01@cluster-url/dbname");
    await client.open();
    _db = client;
  }

  Future<bool> authenticateUser(String username, String password) async {
    var collection = _db.collection('alumnos');
    var user = await collection.findOne(where.eq('username', username).eq('password', password));
    return user != null;
  }
}
