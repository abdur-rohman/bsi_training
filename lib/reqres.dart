import 'package:bsi_training/http_client.dart';
import 'package:flutter/material.dart';

class ReqResPage extends StatefulWidget {
  const ReqResPage({Key? key}) : super(key: key);

  @override
  State<ReqResPage> createState() => _ReqResPageState();
}

class _ReqResPageState extends State<ReqResPage> {
  List<User> _users = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    HttpClient.dio().get('users').then((response) {
      var data = response.data;
      var usersData = data['data'] as List<dynamic>;
      _users = usersData.map((item) => User.fromJson(item)).toList();
    }).catchError((e) {
      print('error: $e');
    }).whenComplete(() {
      _isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (_, index) {
                var user = _users[index];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.network(user.image),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.fullName),
                            Text(user.email),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class User {
  final int id;
  final String fullName, email, image;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    var firstName = data['first_name'] ?? '';
    var lastName = data['last_name'] ?? '';

    return User(
      id: data['id'] ?? 0,
      fullName: '$firstName $lastName',
      email: data['email'] ?? '',
      image: data['avatar'] ?? '',
    );
  }
}
