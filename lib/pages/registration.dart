
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project2/Controller/RegisreationController.dart';
import 'package:graduation_project2/Controller/authntecation.dart';
import 'package:graduation_project2/pages/Login.dart';
import 'package:graduation_project2/shared/colors.dart';
import 'package:graduation_project2/shared/showSnackBar.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isVisable = true;
  Uint8List? imgPath;
  String? imgName;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();
  final phoneNumberController = TextEditingController();
  bool isPassword8Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  bool farmercheck = false;
  bool storeOwnerCheck = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    ageController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: appbarGreen,
      ),
      body: Center(
        child: Padding(
          padding: widthScreen > 600
              ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
              : const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 71,
                          backgroundImage: RegistreationController.imgPath !=
                                  null
                              ? MemoryImage(RegistreationController.imgPath!)
                              : const AssetImage("assets/avatarImage.jpg")
                                  as ImageProvider,
                        ),
                        Positioned(
                          right: -10,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () async {
                              await RegistreationController.showModel(context);
                              setState(() {});
                            },
                            icon: const Icon(Icons.add_a_photo,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 33),
                  _buildTextField(
                    controller: usernameController,
                    hintText: "Enter Your Username",
                    icon: Icons.person,
                    validator: (value) => value!.isEmpty || value.length < 5
                        ? "Cannot be less than 5 characters"
                        : null,
                  ),
                  const SizedBox(height: 22),
                  _buildTextField(
                    controller: phoneNumberController,
                    hintText: "Enter Your Phone Number",
                    icon: Icons.phone,
                    validator: (value) => value!.isEmpty || value.length < 10
                        ? "Cannot be less than 10 numbers"
                        : null,
                  ),
                  const SizedBox(height: 22),
                  _buildTextField(
                    controller: titleController,
                    hintText: "Enter Your Title",
                    icon: Icons.person_outline,
                    validator: (value) =>
                        value!.isEmpty ? "Cannot be empty" : null,
                  ),
                  const SizedBox(height: 22),
                  _buildTextField(
                    controller: ageController,
                    hintText: "Enter Your Age",
                    icon: Icons.emoji_nature,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 33),
                  _buildTextField(
                    controller: emailController,
                    hintText: "Enter Your Email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) => email!.contains(RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"))
                        ? null
                        : "Enter a valid email",
                  ),
                  const SizedBox(height: 22),
                  _buildPasswordField(
                    controller: passwordController,
                    hintText: "Enter Your Password",
                    icon: Icons.lock,
                    obscureText: isVisable,
                    onVisibilityToggle: () {
                      setState(() {
                        isVisable = !isVisable;
                      });
                    },
                    onChanged: (password) {
                      RegistreationController.onPasswordChanged(password,
                          (bool is8Char, bool has1Number, bool hasUpper,
                              bool hasLower, bool hasSpecialChars) {
                        setState(() {
                          isPassword8Char = is8Char;
                          isPasswordHas1Number = has1Number;
                          hasUppercase = hasUpper;
                          hasLowercase = hasLower;
                          hasSpecialCharacters = hasSpecialChars;
                        });
                      });
                    },
                    validator: (value) => value!.length < 8
                        ? "Enter at least 8 characters"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  _buildPasswordCriteria(),
                  const SizedBox(height: 33),
                  _buildUserTypeSelection(),
                  const SizedBox(height: 33),
                  _buildRegisterButton(),
                  const SizedBox(height: 33),
                  _buildLoginLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: false,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool obscureText,
    required VoidCallback onVisibilityToggle,
    required void Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(
          onPressed: onVisibilityToggle,
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }

  Widget _buildPasswordCriteria() {
    return Column(
      children: [
        _buildCriteriaRow("At least 8 characters", isPassword8Char),
        const SizedBox(height: 10),
        _buildCriteriaRow("At least 1 number", isPasswordHas1Number),
        const SizedBox(height: 10),
        _buildCriteriaRow("Has Uppercase", hasUppercase),
        const SizedBox(height: 10),
        _buildCriteriaRow("Has Lowercase", hasLowercase),
        const SizedBox(height: 10),
        _buildCriteriaRow("Has Special Characters", hasSpecialCharacters),
      ],
    );
  }

  Widget _buildCriteriaRow(String text, bool isMet) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isMet ? Colors.green : Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 15,
          ),
        ),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }

  Widget _buildUserTypeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildUserTypeOption("Farmer", farmercheck, () {
          setState(() {
            farmercheck = true;
            storeOwnerCheck = false;
          });
        }),
        _buildUserTypeOption("Store Owner", storeOwnerCheck, () {
          setState(() {
            storeOwnerCheck = true;
            farmercheck = false;
          });
        }),
      ],
    );
  }

  Widget _buildUserTypeOption(
      String text, bool isSelected, VoidCallback onTap) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(10),
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.green : Colors.white,
              border: Border.all(color: Colors.grey),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate() &&
            RegistreationController.imgName != null &&
            RegistreationController.imgPath != null &&
            (farmercheck || storeOwnerCheck)) {
          setState(() {
            isLoading = true;
          });
          await AuthMethods().register(
            emailll: emailController.text,
            passworddd: passwordController.text,
            context: context,
            titleee: titleController.text,
            usernameee: usernameController.text,
            imgName: RegistreationController.imgName,
            imgPath: RegistreationController.imgPath,
            age: ageController.text,
            situation: farmercheck
                ? "Farmer"
                : storeOwnerCheck
                    ? "Store Owner"
                    : null,
            balance: 100.0,
            phoneNumber: phoneNumberController.text,
          );
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        } else {
          showSnackBar(context, "ERROR Form Field");
          setState(() {
            isLoading = false;
          });
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(BTNgreen),
        padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              "Register",
              style: TextStyle(fontSize: 19, color: Colors.white),
            ),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Do not have an account?", style: TextStyle(fontSize: 18)),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          },
          child: const Text(
            'Sign in',
            style:
                TextStyle(fontSize: 18, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
