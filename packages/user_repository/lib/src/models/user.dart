import '../entities/entities.dart';

class MyUser {
  final String userID;
  final String email;
  final String name;
  final int age;
  String description;
  final Map<String, dynamic> location;
  List<dynamic> pictures;

  MyUser({
    required this.age,
    required this.userID,
    required this.email,
    required this.name,
    required this.description,
    required this.location,
    required this.pictures,
  });

  static final empty = MyUser(
    userID: '',
    email: '',
    name: '',
    age: 0,
    description: '',
    location: {},
    pictures: [],
  );

  MyUser copyWith({
    String? userID,
    String? email,
    String? name,
    int? age,
    String? description,
    Map<String, double>? location,
    List<String>? pictures,
  }) {
    return MyUser(
      userID: userID ?? this.userID,
      email: email ?? this.email,
      name: name ?? this.name,
      age: age ?? this.age,
      description: description ?? this.description,
      location: location ?? this.location,
      pictures: pictures ?? this.pictures,
    );
  }

  MyUserEntity toEntity() {
    return MyUserEntity(
      userID: userID,
      email: email,
      name: name,
      age: age,
      description: description,
      location: location,
      pictures: pictures,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userID: entity.userID,
      email: entity.email,
      name: entity.name,
      age: entity.age,
      description: entity.description,
      location: entity.location,
      pictures: entity.pictures,
    );
  }

  @override
  String toString() {
    return '''MyUser :
  userId: $userID, 
  email: $email, 
  name: $name,
  age: $age,
  description: $description, 
  location: $location,
  pictures: $pictures,
  ''';
  }
}
