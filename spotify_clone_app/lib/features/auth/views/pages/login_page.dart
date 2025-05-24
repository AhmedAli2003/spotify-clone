import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/router/app_routes.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/core/utils/ui_utils.dart';
import 'package:spotify_clone_app/core/widgets/custom_field.dart';
import 'package:spotify_clone_app/core/widgets/loader.dart';
import 'package:spotify_clone_app/features/auth/controllers/auth_controller.dart';
import 'package:spotify_clone_app/features/auth/views/widgets/auth_gradient_button.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final isLoading = ref.watch(authControllerProvider.select((val) => val.isLoading));

    ref.listen(
      authControllerProvider,
      (_, next) {
        next.when(
          data: (data) {
            if (data != null) {
              navigateToHome(context);
            }
          },
          error: (error, st) => handleError(context, error, st: st),
          loading: () {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomField(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    CustomField(
                      hintText: 'Password',
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(height: 20),
                    AuthGradientButton(
                      buttonText: 'Sign in',
                      onTap: () => login(
                        ref: ref,
                        context: context,
                        formKey: formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => navigateToSignUp(context),
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: const [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: AppColors.gradient2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> login({
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required BuildContext context,
  }) async {
    if (formKey.currentState!.validate()) {
      await ref.read(authControllerProvider.notifier).login(
            email: emailController.text,
            password: passwordController.text,
          );
    } else {
      showSnackBar(context, 'Missing fields!');
    }
  }

  void navigateToSignUp(BuildContext context) {
    GoRouter.of(context).goNamed(AppRoutes.signup);
  }

  void navigateToHome(BuildContext context) {
    GoRouter.of(context).goNamed(AppRoutes.home);
  }
}
