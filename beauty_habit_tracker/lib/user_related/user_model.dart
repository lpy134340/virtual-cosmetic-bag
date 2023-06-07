class AppUser {
  String firstName;
  String lastName;
  String email;
  String password;
  int? age;
  String skinType;
  String image;

  AppUser(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.age,
      required this.skinType,
      required this.image});

  AppUser.fromJson(Map<String, Object?> json)
      : this(
            firstName: json['firstName']! as String,
            lastName: json['lastName']! as String,
            email: json['email']! as String,
            password: json['password']! as String,
            age: json['age'] as int,
            skinType: json['skinType'] as String,
            image: json['image'] as String);

  Map<String, Object?> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'age': age,
      'skinType': skinType,
      'image': image
    };
  }
}

/*
User newUser = User(
    firstName: "",
    lastName: "",
    email: "",
    password: "",
    age: 0,
    skinType: "",
    image: "");

Future<void> handleSignUp() async {
  try {
    // ignore: unused_local_variable
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: newUser.email,
      password: newUser.password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      throw Exception('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      throw Exception('The account already exists for that email.');
    }
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }

  try {
    String userPath = '/users';
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var dataVar = FirebaseFirestore.instance
        .collection(userPath)
        .doc(userId)
        .withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (newUser, _) => newUser.toJson(),
        );
    await dataVar.set(User(
        firstName: newUser.firstName,
        lastName: newUser.lastName,
        email: newUser.email,
        password: "",
        age: newUser.age,
        skinType: newUser.skinType,
        image: ""));
  } catch (error) {
    debugPrint(error.toString());
  }

  try {
    // ignore: unused_local_variable
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: newUser.email, password: newUser.password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw Exception('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      throw Exception('Wrong password provided for that user.');
    }
  }
}
*/
