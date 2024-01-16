class MyUserEntity {
  final String userID;
  final String email;
  final String name;
  final int age;
  final String description;
  final Map<String, dynamic> location;
  final List<dynamic> pictures;

  const MyUserEntity({
    required this.age,
    required this.userID,
    required this.email,
    required this.name,
    required this.description,
    required this.location,
    required this.pictures,
  });

  Map<String, Object?> toDocument() {
    return {
      'userID': userID,
      'email': email,
      'name': name,
      'age': age,
      'description': description,
      'location': location,
      'pictures': pictures,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userID: doc['userID'],
      email: doc['email'],
      name: doc['name'],
      age: doc['age'],
      description: doc['description'],
      location: doc['location'],
      pictures: doc['pictures'],
    );
  }
}
