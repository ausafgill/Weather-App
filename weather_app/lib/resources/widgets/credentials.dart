import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCredentials extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onTap;
  final bool loading;
  const AddCredentials({
    super.key,
    this.loading = false,
    required this.onTap,
    required this.buttonTitle,
    required GlobalKey<FormState> formkey,
    required this.emailController,
    required ValueNotifier<bool> obscureText,
    required this.passController,
  })  : _formkey = formkey,
        _obscureText = obscureText;

  final GlobalKey<FormState> _formkey;
  final TextEditingController emailController;
  final ValueNotifier<bool> _obscureText;
  final TextEditingController passController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EmailID*',
              style: Theme.of(context).copyWith().textTheme.bodySmall,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              style: Theme.of(context).copyWith().textTheme.bodySmall,
              controller: emailController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Your Email';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Password*',
              style: Theme.of(context).copyWith().textTheme.bodySmall,
            ),
            SizedBox(
              height: 10,
            ),
            ValueListenableBuilder(
              valueListenable: _obscureText,
              builder: (context, value, child) {
                return TextFormField(
                  style: Theme.of(context).copyWith().textTheme.bodySmall,
                  obscureText: _obscureText.value,
                  controller: passController,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          _obscureText.value = !_obscureText.value;
                        },
                        child: _obscureText.value
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Your Password';
                    } else {
                      return null;
                    }
                  },
                );
              },
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: loading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            buttonTitle,
                            style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
