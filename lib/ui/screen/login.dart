import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  final SupabaseClient client;

  const Login({required this.client, Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool checkedValue = false;
  bool _passwordVisible = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _navigateToDashboard(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
        SideNavigationBar(
          index: 0,
          coaIndex: 0,
          jurnalUmumIndex: 0,
          bukuBesarIndex: 0,
          neracaLajurIndex: 0,
          labaRugiIndex: 0,
          amortisasiIndex: 0,
          jurnalPenyesuaianIndex: 0,
          client: widget.client,
        )
      )
    );
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
                    Image.asset(
                      'assets/images/logo_stikes.png',
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Sistem Akuntansi \nSTIKes Santo Borromeus",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: "Inter",
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Selamat datang di Sistem Akuntansi STIKes Santo Borromeus, \njangan lupa masuk pakai akun kamu ya",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: "Inter",
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
                        fontWeight: FontWeight.w600,
                        color: yellowTextColor,
                        fontFamily: "Inter",
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
                        color: greyFontColor,
                        fontFamily: "Inter",
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
                        fontFamily: "Inter",
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 1,
                            color: greyFontColor,
                          ),
                        ),
                        hintText: 'Masukan email...',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: greyFontColor,
                          fontFamily: "Inter",
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
                        fontFamily: "Inter",
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 1,
                            color: greyFontColor,
                          ),
                        ),
                        hintText: 'Masukan password...',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: greyFontColor,
                          fontFamily: "Inter",
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
                            fontFamily: "Inter",
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
                            yellowTextColor,
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
                          if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                            Future.delayed(Duration(seconds: 2), () {
                              _navigateToDashboard(context);
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Login Berhasil"))
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Pastikan kolom email dan password terisi dengan benar."))
                            );
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                            fontFamily: "Inter",
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