import 'package:flutter/material.dart';

//import to my files
import '.././enum/auth_mode.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  // I use SingleTickerProviderStateMixin => use animation and access to vsync

  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authInformation = {
    "email": "",
    "password": "",
  };

  late var _isLoading = false;
  final _passwordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -15),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    _opacityAnimation = Tween<double>(
      begin: 0.5,
      end: 0.6,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    super.initState();
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {} catch (message) {
      return;
    }
    setState(() {
      _isLoading = false;
    });
  }

  void switchAuthMode() {
    if (_authMode == AuthMode.SignUp) {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
      _animationController.reverse();

    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.SignUp ? 320 : 260,
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.SignUp ? 320 : 260),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Email TextFormField
                TextFormField(
                  decoration: const InputDecoration(labelText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val!.isEmpty || !val.contains("@")) {
                      return "Invalid email";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
                    _authInformation["email"] = val!;
                  },
                ),
                // Password TextFormField
                TextFormField(
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (val) {
                    if (val!.isEmpty || val.length < 8) {
                      return "Password is too short";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
                    _authInformation["password"] = val!;
                  },
                ),
                // Password Confirm TextFormField
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.SignUp ? 60 : 0,
                    maxHeight: _authMode == AuthMode.SignUp ? 120 : 0,
                  ),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.SignUp,
                      decoration: const InputDecoration(
                          labelText: "Confirm Password"),
                      obscureText: true,
                      validator: _authMode == AuthMode.SignUp
                          ? (val) {
                              if (val != _passwordController.text) {
                                return "Password do not match";
                              } else {
                                return null;
                              }
                            }
                          : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                        _authMode == AuthMode.SignUp ? "Sign Up" : "Login"),
                  ),
                TextButton(
                  onPressed: switchAuthMode,
                  child: Text(
                      "${_authMode == AuthMode.SignUp ? "Login" : "SignUp"} Instead "),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
