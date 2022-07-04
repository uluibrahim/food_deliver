import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';
import 'package:food_deliver/core/navigator/navigator_manager.dart';
import 'package:food_deliver/screen/bottom_navigation/viewmodel/bottom_navigation_viewmodel.dart';
import 'package:food_deliver/screen/login/viewmodel/login_viewmodel.dart';
import 'package:food_deliver/user_data.dart';
import 'package:provider/provider.dart';

import '../../../core/component/text_field/custom_text_form_field.dart';
import '../../../core/init/language/locale_keys.dart';
import '../../../product/validations.dart';
import '../../bottom_navigation/view/bottom_navigation_view.dart';
import '../widgets/sign_in_button.dart';
import '../widgets/social_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with Validations, NavigatorManager {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewmodel>(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _tapContainer(viewmodel),
          _bottomCard(viewmodel),
        ],
      ),
    );
  }

  Container _bottomCard(LoginViewmodel viewmodel) {
    return Container(
      height: context.height / 2,
      width: context.width,
      decoration: BoxDecoration(
        color: const Color(0xff8D34A4).withOpacity(0.5),
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(50), right: Radius.circular(50)),
      ),
      child: Padding(
        padding: context.paddingNormal,
        child: Column(
          children: [
            SignInButton(context: context, onPress: () => _signIn(viewmodel)),
            Expanded(
              flex: 10,
              child: Center(
                child: Text(LocaleKeys.orSignInWith.tr(),
                    style: context.textTheme.headline6),
              ),
            ),
            Expanded(flex: 10, child: _socialButtons),
            Expanded(flex: 20, child: _signUp),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Row get _signUp {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(LocaleKeys.dontHaveAccount.tr(),
            style: context.textTheme.headline6),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {},
          child: Text(
            LocaleKeys.singUp.tr(),
            style: context.textTheme.headline6?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Center get _socialButtons {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SocialButton(context: context, imagePath: "png_google"),
          SocialButton(context: context, imagePath: "png_facebook"),
          SocialButton(context: context, imagePath: "png_twitter"),
        ],
      ),
    );
  }

  Container _tapContainer(LoginViewmodel viewmodel) {
    return Container(
      height: context.height,
      width: context.width,
      decoration: _tapContainerDecoration,
      child: Column(
        children: [
          SizedBox(
            height: context.height / 2,
            child: _loginForm(viewmodel),
          ),
        ],
      ),
    );
  }

  Form _loginForm(LoginViewmodel viewmodel) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Padding(
        padding: context.paddingNormal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.loginToYourAccount.tr(),
              style: context.textTheme.headline5,
            ),
            CustomTextFormField(
              context: context,
              controllers: _emailController,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.emailAddress,
              validators: (value) => validationEmail(value),
              label: LocaleKeys.email.tr(),
            ),
            CustomTextFormField(
              context: context,
              controllers: _passwordController,
              changeObscure: () {
                viewmodel.obscure = !viewmodel.obscure;
              },
              obscureText: viewmodel.obscure,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              validators: (value) => validationPassword(value),
              label: LocaleKeys.password.tr(),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration get _tapContainerDecoration {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xffFF8686),
          const Color(0xff0A1342).withOpacity(0.5),
        ],
      ),
    );
  }

  void _signIn(LoginViewmodel viewmodel) {
    viewmodel.changeValidateMode();
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      bool isLogined = viewmodel.login(
          email: _emailController.text, password: _passwordController.text);
      if (isLogined) {
        context.read<UserData>().createdUser(viewmodel.user);
        navigateReplaceToWidget(
          context,
          ChangeNotifierProvider(
            create: (_) => BottomNavigationViewmodel(),
            child: const BottomNavigationView(),
          ),
        );
      }
    }
  }
}
