import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/authentication/auth_controller.dart';
import 'package:stasis/features/authentication/name_engine.dart';
import 'package:stasis/ui/common/error_loader.dart';
import 'package:stasis/utils/snackybar.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _isNewUser = false;
  late String _username;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _checkPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _changeUserName();
  }

  _changeUserName() {
    setState(() {
      _username = NameEngine.userName;
    });
  }

  _changeModes() {
    setState(() {
      _isNewUser = !_isNewUser;
    });
  }

  _proceed() {
    if (_isNewUser && _passwordController.text != _checkPassController.text) {
      showSnackBar(context, 'password do not match');
    } else {
      if (_isNewUser) {
        ref.read(authControllerProvider.notifier).signUp(_emailController.text, _passwordController.text, _username, context);
      } else {
        ref.read(authControllerProvider.notifier).logIn(_emailController.text, _passwordController.text, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(label: Text('email')),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(label: Text('password')),
              ),
              if (_isNewUser)
                TextField(
                  controller: _checkPassController,
                  obscureText: true,
                  decoration: const InputDecoration(label: Text('check password')),
                ),
              if (_isNewUser)
                Column(
                  children: [
                    const Text('username can be customized inside'),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(_username),
                        ElevatedButton(onPressed: _changeUserName, child: const Text('change')),
                      ],
                    ),
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              Container(child: isLoading ? const Loader() : OutlinedButton(onPressed: _proceed, child: const Text('proceed'))),
              const SizedBox(
                height: 20,
              ),
              TextButton(onPressed: _changeModes, child: const Text('log-in/sign-up instead'))
            ],
          ),
          const SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _checkPassController.dispose();
  }
}
