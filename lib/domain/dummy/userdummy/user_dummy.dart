import '../../entity/user/user.dart';

class UserDummy {
  UserDummy();

  User generateShimmerDummy() {
    return User(
      id: "",
      name: "",
      role: 1,
      email: "",
      createdAt: DateTime.now(),
      userProfile: UserProfile(
        id: "1",
        userId: "",
        avatar: "",
        gender: "",
        dateBirth: DateTime.now(),
        placeBirth: "",
        phoneNumber: ""
      )
    );
  }

  User generateDefaultDummy() {
    return User(
      id: "1",
      name: "User 1",
      role: 1,
      email: "test@user.com",
      createdAt: DateTime.now(),
      userProfile: UserProfile(
        id: "1",
        userId: "1",
        avatar: "",
        gender: "male",
        dateBirth: DateTime.now(),
        placeBirth: "Jakarta",
        phoneNumber: "081234567890"
      )
    );
  }
}