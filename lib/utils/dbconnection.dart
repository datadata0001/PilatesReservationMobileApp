import 'package:postgres/postgres.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostgresDbConnection {
  final String host;
  final int port;
  final String database;
  final String username;
  final String password;

  PostgresDbConnection({
    required this.host,
    required this.port,
    required this.database,
    required this.username,
    required this.password,
  });

  static PostgresDbConnection fromEnvFile() {
    // Retrieve the database parameters from the environment file

    final host = dotenv.env['IP'];
    final port = int.parse(dotenv.env['DB_PORT'] ?? '5432');
    final database = dotenv.env['Database'];
    final username = dotenv.env['User'];
    final password = dotenv.env['Password'];

    return PostgresDbConnection(
      host: host!,
      port: port,
      database: database!,
      username: username!,
      password: password!,
    );
  }

  static Future<PostgresDbConnection> create() async {
    // Load the environment file
    await dotenv.load(fileName: ".env");
    // Retrieve the database parameters from the environment file
    final connection = PostgresDbConnection.fromEnvFile();
    return connection;
  }

  static Future<Result> executeQueryWithParams(
      String query, List<dynamic> params) async {
    final connection = await create();
    final result = await connection.executeWithParams(query, params);
    return result;
  }

  Future<Result> executeWithParams(
      String query, List<dynamic> params) async {
    final conn = await Connection.open(
      Endpoint(
        host: host,
        port: port,
        database: database,
        username: username,
        password: password,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
    final result = await conn.execute(Sql.named(query), parameters: params);
    await conn.close();

    // Convert the rows to a list of maps
    // return result.map((row) => row.toColumnMap()).toList();
    return result;

/*     List<YourModel> yourModel = result
      .map((row) => YourModel.fromMap(row.toColumnMap()))
      .toList();
 */


/*     final maps = <Map<String, dynamic>>[];
    if (rows.isNotEmpty) {
      for (final row in rows) {
        final map = <String, dynamic>{};
        for (final col in row.entries) {
          final key = col.key;
          final value =
              col.value is UndecodedBytes ? col.value.asString : col.value;
          map.addAll({key: value});
        }
        maps.add(map);
      }
    }
    return maps;
 */
    
  }
}
