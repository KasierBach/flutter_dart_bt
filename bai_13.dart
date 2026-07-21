class DatabaseConnection {
  // Constructor có dấu _ nên chỉ được gọi bên trong file này.
  DatabaseConnection._();

  // Instance duy nhất được tạo một lần và dùng lại.
  static final DatabaseConnection _instance = DatabaseConnection._();

  static DatabaseConnection getInstance() {
    return _instance;
  }

  void connect() {
    print('Connected to database');
  }

  void disconnect() {
    print('Disconnected');
  }
}

void main() {
  final DatabaseConnection connection1 = DatabaseConnection.getInstance();
  final DatabaseConnection connection2 = DatabaseConnection.getInstance();

  connection1.connect();
  print(
    'Hai biến cùng tham chiếu một instance: '
    '${identical(connection1, connection2)}',
  );
  connection2.disconnect();
}
