import 'package:cinema/core/features/ticket/data/local/ticket_local_datasource.dart';
import 'package:cinema/core/features/ticket/data/models/ticket_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TicketLocalDatasourceImplement extends TicketLocalDatasource {
  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();
  @override
  Future<Database> initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'cinema.db'),
        onCreate: (db, version) {
      return db.execute('''
    CREATE TABLE Ticket(
      id TEXT PRIMARY KEY,
      title TEXT,
      runtime REAL,
      filmFormat TEXT,1
      theater TEXT,
      time TEXT,
      seats TEXT,
      unitPrice REAL,
      userId TEXT,
      createAt TEXT) 
      ''');
    }, version: 1);
  }

  @override
  void createTicket(TicketModel model) async {
    Database? db = await database;
    await db.insert("Ticket", model.toJson());
  }

  @override
  void deleteTicket(String ticketId) async {
    Database? db = await database;
    final numberOfRow =
        await db.delete("Ticket", where: 'id = ?', whereArgs: [ticketId]);
    print(numberOfRow);
  }

  @override
  Future<List<TicketModel>> queryTickets({required String userId}) async {
    Database? db = await database;
    final result =
        await db.query('Ticket', where: 'userId = ?', whereArgs: [userId]);
    return result.map(TicketModel.fromJson).toList();
  }

  @override
  Future<TicketModel?> updateTicket(TicketModel model) async {
    Database? db = await database;
    await db.update('Ticket', model.toJson(),
        where: 'id = ?', whereArgs: [model.id]);
    return queryTicket(ticketId: model.id!);
  }

  @override
  void clearData() async {
    Database? db = await database;
    await db.delete('Ticket');
    return;
  }

  @override
  Future<TicketModel?> queryTicket({required String ticketId}) async {
    Database? db = await database;
    final result =
        await db.query('Ticket', where: 'id = ?', whereArgs: [ticketId]);
    if (result.length == 1) {
      return TicketModel.fromJson(result.first);
    }
    return null;
  }
}
