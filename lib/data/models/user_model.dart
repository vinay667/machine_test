
class UserModel {
  final int id;
  final String firstName, lastName, email, image, phone, gender;
  final String city, state, country, dob;
  final int age;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.phone,
    required this.gender,
    required this.city,
    required this.state,
    required this.country,
    required this.dob,
    required this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
        id: j['id'],
        firstName: j['firstName'],
        lastName: j['lastName'],
        email: j['email'],
        image: j['image'],
        phone: j['phone'],
        gender: j['gender'],
        city: j['address']['city'],
        state: j['address']['state'],
        country: j['address']['country'],
        dob: j['birthDate'],
        age: j['age'],
      );
}
