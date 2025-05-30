import 'package:flutter_test/flutter_test.dart';
import 'package:bundlegram/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    const user = UserModel(id: '1', name: 'Alice', email: 'alice@example.com');
    final userJson = {'id': '1', 'name': 'Alice', 'email': 'alice@example.com'};

    test('fromJson creates correct model', () {
      expect(UserModel.fromJson(userJson), user);
    });

    test('toJson returns correct map', () {
      expect(user.toJson(), userJson);
    });

    test('equality works as expected', () {
      expect(user, const UserModel(id: '1', name: 'Alice', email: 'alice@example.com'));
      expect(user == const UserModel(id: '2', name: 'Bob', email: 'bob@example.com'), isFalse);
    });

    test('copyWith returns updated model', () {
      final updated = user.copyWith(name: 'Bob');
      expect(updated.name, 'Bob');
      expect(updated.id, user.id);
      expect(updated.email, user.email);
    });
  });
} 