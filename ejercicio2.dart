import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final String email;
  final String phone;
  final String country;
  final String gender;

  User(
      {required this.name,
      required this.email,
      required this.phone,
      required this.country,
      required this.gender});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: '${json['name']['first']} ${json['name']['last']}',
        email: json['email'],
        phone: json['phone'],
        country: json['location']['country'],
        gender: json['gender']);
  }

  @override
  String toString() {
    return 'Name: $name\nEmail: $email\nPhone: $phone\nCountry: $country\nGender: $gender';
  }
}

class ProgramFemale {
  Future<User> getFemale() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?gender=female'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data['results'][0]);
    } else {
      throw Exception('Failed to load user');
    }
  }
}

mixin ProgramMale {
  Future<User> getMale() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?gender=male'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data['results'][0]);
    } else {
      throw Exception('Failed to load user');
    }
  }
}

class Program extends ProgramFemale with ProgramMale {
  Future<User> getUser(String gender) {
    if (gender == 'male') {
      return this.getMale();
    }
    if (gender == 'female') {
      return this.getFemale();
    }

    throw Exception('''Pick a valid sex: "male" or "female"''');
  }
}

void main() async {
  final program = Program();

  try {
    User user = await program.getUser('male');
    print('User fetched successfully:\n');
    print(user);
  } catch (e) {
    print('Error fetching user: $e');
  }
}
