import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_project2/firebase_options.dart';
import 'package:graduation_project2/utils/validation.dart';
import 'package:graduation_project2/model/cart.dart';

void main() {
  test('Login_Credintials_Email_testing:Case1', () {
    //Valid
    String email = 'ahmad@gmail.com';

    expect(isEmailValid(email), true);
  });

  test('Login_Credintials_Email_testing:Case2', () {
    //Invalid email no dot
    String email = 'ahmad@gmailcom';

    expect(isEmailValid(email), false);
  });

  test('Login_Credintials_Email_testing:Case3', () {
    //Invalid email no @
    String email = 'ahmadgmail.com';

    expect(isEmailValid(email), false);
  });

  test('Login_Credintials_Email_testing:Case4', () {
    //Invalid email
    String email = 'ahmadgmailcom';

    expect(isEmailValid(email), false);
  });

  test('Login_Credintials_Email_testing:Case5', () {
    //Valid Case
    String email = 'a@gmail.com';
    expect(isEmailValid(email), true);
  });

  test('Login_Credintials_Password_testing:Case6', () {
    //Valid Password: 8 characters, at least a small letter, a capital letter and a special character
    String password = 'iCvm123#';
    expect(isPasswordValid(password), true);
  });

  test('Login_Credintials_Password_testing:Case6', () {
    //Invalid Password: 2 characters
    String password = 'iC';
    expect(isPasswordValid(password), false);
  });

  test('Login_Credintials_Password_testing:Case7', () {
    //Invalid Password: 7 characters , at least a small letter, a capital letter and a special character
    String password = 'i#ddd33';
    expect(isPasswordValid(password), false);
  });

  test('Login_Credintials_Password_testing:Case8', () {
    //Valid Password: 8 characters and no special character
    String password = '123456sS';
    expect(isPasswordValid(password), true);
  });

  test('Login_Credintials_Password_testing:Case9', () {
    //Valid Password: 8 characters and no special character
    String password = '123456sS';
    expect(isPasswordValid(password), true);
  });

  test('Login_Credintials_Password_testing:Case10', () {
    //Invalid Password: 8 characters , only numbers = weak password
    String password = '12345678';
    expect(isPasswordValid(password), false);
  });

  test('Login_Credintials_Password_testing:Case11', () {
    //Invalid Password: 8 characters , only small letters = weak password
    String password = 'aaaabbbb';
    expect(isPasswordValid(password), false);
  });

  test('Login_Credintials_Password_testing:Case12', () {
    //Invalid Password: 8 characters , only capital letters = weak password
    String password = 'AAAABBBB';
    expect(isPasswordValid(password), false);
  });

  test('Login_Credintials_Password_testing:Case13', () {
    //Invalid Password: 8 characters , only special character  = weak password
    String password = r'####$$$$';
    expect(isPasswordValid(password), false);
  });

  test('LoginPage_testing:Case14', () {
    //Valid Email
    String email = 'ahm3d.ghazi@gmail.com';
    //Valid Password
    String password = '123456sS@sasd';

    //Successful Login
    //Retrieve data from Firebase
    expect(
      isLoginSuccessful(
        isEmailValid(email),
        isPasswordValid(password),
      ),
      true,
    );
  });

  test('LoginPage_testing:Case15', () {
    //invalid Email
    String email = 'ahm3mail.com';
    //Valid Password
    String password = '123456sS@sasd';

    //Unsuccessful Login

    expect(
      isLoginSuccessful(
        isEmailValid(email),
        isPasswordValid(password),
      ),
      false,
    );
  });

  test('LoginPage_testing:Case16', () {
    //Valid Email
    String email = 'ahm3d.ghazi@gmail.com';
    //Invalid Password
    String password = '123';

    //Unsuccessful Login

    expect(
      isLoginSuccessful(
        isEmailValid(email),
        isPasswordValid(password),
      ),
      false,
    );
  });

  test('LoginPage_testing:Case17', () {
    //Invalid Email
    String email = 'ahmail.com';
    //Invalid Password
    String password = '123';

    //Unsuccessful Login

    expect(
      isLoginSuccessful(
        isEmailValid(email),
        isPasswordValid(password),
      ),
      false,
    );
  });

  test('CartPage_title_testing:Case18', () {
    //Valid title
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.Title = 'Watermelon';

    expect(user1.title, 'Watermelon');
  });

  test('CartPage_title_testing:Case19', () {
    //Invalid title because a title can't accept a number
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.Title = '2Watermelon';

    expect(user1.title, '2Watermelon');
  });

  test('CartPage_UsernameFarmer_testing:Case20', () {
    //Valid
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.UsernameFarmer = 'AhmedFarmer';

    expect(user1.usernameFarmer, 'AhmedFarmer');
  });

  test('CartPage_UsernameFarmer_testing:Case21', () {
    //Invalid usernameFarmer because a usernameFarmer can't accept a number
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.UsernameFarmer = 'AhmedFarmer222';

    expect(user1.usernameFarmer, 'empty');
  });

  test('CartPage_UsernameStoreOwner_testing:Case22', () {
    //Valid
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.UsernameStoreOwner = 'AhmedStoreOwner';

    expect(user1.usernameStoreOwner, 'AhmedStoreOwner');
  });

  test('CartPage_UsernameStoreOwner_testing:Case23', () {
    //Invalid usernameStoreOwner because a usernameStoreOwner can't accept a number
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.UsernameStoreOwner = 'AhmedStoreOwner222';

    expect(user1.usernameStoreOwner, 'empty');
  });

  test('CartPage_UsernameStoreOwner_testing:Case24', () {
    //Invalid usernameStoreOwner because a usernameStoreOwner can't accept a number
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.UsernameStoreOwner = 'AhmedStoreOwner222';

    expect(user1.usernameStoreOwner, 'empty');
  });

  test('CartPage_ProfileImg_testing:Case25', () {
    //Valid: The profile image's name which is saved in the database can contain all types of characters
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.ProfileImg = r'imag12$%^!*$%';

    expect(user1.profileImg, r'imag12$%^!*$%');
  });

  test('CartPage_ProfileImg_testing:Case26', () {
    //Valid 2: Empty Value will be stored in database in case of not providing an image
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.ProfileImg = 'empty';

    expect(user1.profileImg, 'empty');
  });

  test('CartPage_UidFarmer_testing:Case27', () {
    //Valid: The uid is auto generated by the database using this class set method- the uid contains random values consisting of any type of characters and numbers
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.UidFarmer = r'imS-S-AS-S--SA-ag12$%^!*$%';

    expect(user1.uidFarmer, r'imag12$%^!*$%');
  });

  test('CartPage_uidStorOwner_testing:Case28', () {
    //Valid: The uid is auto generated by the database using this class set method- the uid contains random values consisting of any type of characters and numbers
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.UidStorOwner = r'imS-S-AS-S--SA-ag12$%^!*$%';

    expect(user1.uidStorOwner, r'imag12$%^!*$%');
  });

  test('CartPage_prodactName_testing:Case29', () {
    //Valid: product name must be text only
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.ProdactName = 'Fresh Tomato';

    expect(user1.prodactName, 'Fresh Tomato');
  });

  test('CartPage_prodactName_testing:Case30', () {
    //Invalid: Product Name must not contain a number
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.ProdactName = 'tomat333sssss';

    expect(user1.prodactName, 'empty');
  });

  test('CartPage_phoneNumber_testing:Case30', () {
    //Valid 1 : A phone number must be of length 10 and starts with 078 or 077 or 079 (Jordanian Number)
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.PhoneNumber = '0782255618';

    expect(user1.phoneNumber, '0782255618');
  });

  test('CartPage_phoneNumber_testing:Case31', () {
    //Valid 2 : A phone number must be of length 10 and starts with 078 or 077 or 079 (Jordanian Number)
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.PhoneNumber = '0772255618';

    expect(user1.phoneNumber, '0772255618');
  });

  test('CartPage_phoneNumber_testing:Case32', () {
    //Valid 3 : A phone number must be of length 10 and starts with 078 or 077 or 079 (Jordanian Number)
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.PhoneNumber = '0792255618';

    expect(user1.phoneNumber, '0792255618');
  });

  test('CartPage_phoneNumber_testing:Case32', () {
    //Invalid 1 : This number is 11 characters
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.PhoneNumber = '07922556187';

    expect(user1.phoneNumber, 'empty');
  });

  test('CartPage_phoneNumber_testing:Case33', () {
    //Invalid 2 : This number is 9 characters
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.PhoneNumber = '079225561';

    expect(user1.phoneNumber, 'empty');
  });

  test('CartPage_phoneNumber_testing:Case34', () {
    //Invalid 3 : This number is 10 but it is not a Jordanian number!
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.PhoneNumber = '0732255618';

    expect(user1.phoneNumber, 'empty');
  });

  test('CartPage_phoneNumber_testing:Case35', () {
    //Invalid 4 : This number is 3 characters
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.PhoneNumber = '079';

    expect(user1.phoneNumber, 'empty');
  });

  test('age_testing:Case36', () {
    //Accept age from 15 to 100 years old only
    String age = '14';

    expect(isAgeValid(age), false);
  });

  test('age_testing:Case37', () {
    //Accept age from 15 to 100 years old only
    String age = '15';

    expect(isAgeValid(age), true);
  });

  test('age_testing:Case38', () {
    //Accept age from 15 to 100 years old only
    String age = '99';

    expect(isAgeValid(age), true);
  });

  test('age_testing:Case39', () {
    //Accept age from 15 to 100 years old only
    String age = '100';

    expect(isAgeValid(age), true);
  });

  test('age_testing:Case40', () {
    //Accept age from 15 to 100 years old only
    String age = '101';

    expect(isAgeValid(age), false);
  });

  test('title_testing:Case41', () {
    //Accept age String whether capital or small letters (accepted string length is 2-6)
    String title = 'ah';

    expect(isTitleValid(title), true);
  });

  test('title_testing:Case42', () {
    //Accept age String whether capital or small letters (accepted string length is 2-6)
    String title = 'ahmeda';

    expect(isTitleValid(title), true);
  });

  test('title_testing:Case43', () {
    //Accept age String whether capital or small letters (accepted string length is 2-6)
    String title = 'a';

    expect(isTitleValid(title), false);
  });

  test('title_testing:Case44', () {
    //Accept age String whether capital or small letters (accepted string length is 2-6)
    String title = 'ahmedghazi';

    expect(isTitleValid(title), false);
  });

  test('CartPage_phoneNumber_testing:Case45', () {
    //Invalid 4 : This number is 3 characters
    ProdactCartAllUser user1 = ProdactCartAllUser.anonymous();
    user1.PhoneNumber = '079';

    expect(user1.phoneNumber, 'empty');
  });

  //  String prodactName;
  //   String partquntity;
}
