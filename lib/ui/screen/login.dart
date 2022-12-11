import 'package:sistem_akuntansi/ui/screen/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool checkedValue = false;
  bool _passwordVisible = true;

  void _navigateToDashboard(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Dashboard()));
  }

  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_login.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 64),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/Logo_STIKes.png'),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Sistem Akuntansi STIKes Santo Borromeus",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Selamat datang di Sistem Akuntansi STIKes Santo Borromeus, jangan lupa masuk pakai akun kamu ya",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 115),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Masukan email dan password untuk login ke dashboard",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: greyColor,
                      ),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 1,
                            color: greyColor,
                          ),
                        ),
                        hintText: 'Masukan email...',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: greyColor,
                        ),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 1,
                            color: greyColor,
                          ),
                        ),
                        hintText: 'Masukan password...',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: greyColor,
                        ),
                        contentPadding: EdgeInsets.all(16),
                        suffixIcon: new IconButton(
                          icon: SvgPicture.asset(
                            _passwordVisible
                                ? 'assets/icons/Eye.svg'
                                : 'assets/icons/eyeslash.svg',
                          ),
                          onPressed: (() {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: checkedValue,
                          onChanged: (bool? newValue) {
                            setState(() {
                              checkedValue = newValue!;
                            });
                          },
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Remember Me',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            yellowPrime,
                          ),
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(
                              vertical: 24,
                            ),
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          elevation: MaterialStatePropertyAll(0),
                          shadowColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                        onPressed: () {
                          _navigateToDashboard(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
