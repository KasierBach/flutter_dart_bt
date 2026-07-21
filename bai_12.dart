mixin Logger {
  void log(String message) {
    final String timestamp = DateTime.now().toIso8601String();
    print('[$timestamp] $message');
  }
}

mixin Validator {
  bool isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }
}

class UserService with Logger, Validator {
  void createUser(String email) {
    if (isValidEmail(email)) {
      log('Tạo người dùng với email $email thành công.');
    } else {
      log('Email $email không hợp lệ.');
    }
  }
}

void main() {
  final UserService userService = UserService();

  userService.createUser('student@example.com');
  userService.createUser('email-khong-hop-le');
}
