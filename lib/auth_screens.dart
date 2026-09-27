import 'dart:math' as math;

import 'package:flutter/material.dart';

const _green = Color(0xFF087C53);
const _darkGreen = Color(0xFF075D40);
const _ink = Color(0xFF183A31);
const _muted = Color(0xFF71847D);
const _pale = Color(0xFFF1F8F4);
final _primaryButtonStyle = FilledButton.styleFrom(
  backgroundColor: _green,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
  textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
);

class WelcomePage extends StatelessWidget {
  const WelcomePage({required this.dashboardBuilder, super.key});

  final WidgetBuilder dashboardBuilder;

  void _openLogin(BuildContext context, {bool createAccount = false}) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DemoAuthPage(
          dashboardBuilder: dashboardBuilder,
          startWithCreateAccount: createAccount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pale,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 720;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    children: [
                      const _BrandLockup(compact: false),
                      SizedBox(height: compact ? 15 : 24),
                      _DairyIllustration(height: compact ? 255 : 310),
                      SizedBox(height: compact ? 9 : 18),
                      Text(
                        'Fresh Milk,\nHappy Life',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _ink,
                          fontSize: compact ? 30 : 34,
                          height: 1.14,
                          letterSpacing: -1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 9),
                      const Text(
                        'Get fresh milk and dairy products\nat your doorstep.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _muted,
                          height: 1.5,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 13),
                      const _PageDots(),
                      const SizedBox(height: 19),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton.icon(
                          onPressed: () => _openLogin(context),
                          icon: const Text('Get Started'),
                          label: const Icon(Icons.arrow_forward_rounded),
                          style: _primaryButtonStyle,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(color: _muted, fontSize: 13),
                          ),
                          TextButton(
                            onPressed: () => _openLogin(context),
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                                vertical: 7,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: _green,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () =>
                            _openLogin(context, createAccount: true),
                        child: const Text('New to Al Wasay? Create account'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DemoAuthPage extends StatefulWidget {
  const DemoAuthPage({
    required this.dashboardBuilder,
    this.startWithCreateAccount = false,
    super.key,
  });

  final WidgetBuilder dashboardBuilder;
  final bool startWithCreateAccount;

  @override
  State<DemoAuthPage> createState() => _DemoAuthPageState();
}

class _DemoAuthPageState extends State<DemoAuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  late bool _creatingAccount = widget.startWithCreateAccount;
  bool _rememberMe = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _showDemoMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _continueToShop() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(builder: widget.dashboardBuilder),
      (route) => false,
    );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty ||
        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if ((value ?? '').length < 4) {
      return 'Enter at least 4 characters for the demo.';
    }
    return null;
  }

  Widget _textField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String keyName,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      key: ValueKey(keyName),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: Icon(icon, size: 19, color: _green),
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _passwordField({required bool confirm}) {
    final controller = confirm ? _confirmController : _passwordController;
    final hidden = confirm ? _obscureConfirmPassword : _obscurePassword;
    return _textField(
      label: confirm ? 'Confirm password' : 'Password',
      icon: Icons.lock_outline_rounded,
      controller: controller,
      keyName: confirm ? 'confirmPasswordField' : 'passwordField',
      obscureText: hidden,
      validator: (value) {
        if (confirm && value != _passwordController.text) {
          return 'Passwords do not match.';
        }
        return _validatePassword(value);
      },
      suffixIcon: IconButton(
        tooltip: hidden ? 'Show password' : 'Hide password',
        onPressed: () => setState(() {
          if (confirm) {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          } else {
            _obscurePassword = !_obscurePassword;
          }
        }),
        icon: Icon(
          hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 19,
          color: _muted,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final creating = _creatingAccount;
    return Scaffold(
      backgroundColor: _pale,
      appBar: AppBar(
        backgroundColor: _pale,
        leading: IconButton(
          tooltip: 'Go back',
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 3, 22, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _BrandLockup(compact: true),
                  const SizedBox(height: 19),
                  Text(
                    creating ? 'Create Your Account' : 'Welcome Back!',
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    creating
                        ? 'Join Al Wasay Milk Shop and enjoy freshness at your doorstep.'
                        : 'Login to your account',
                    style: const TextStyle(color: _muted, fontSize: 13),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F3EB),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFD5EADF)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: _green,
                          size: 19,
                        ),
                        SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            'Demo access only. Enter any valid email and a password with at least 4 characters. No account or password is saved.',
                            style: TextStyle(
                              color: _darkGreen,
                              height: 1.4,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 17),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (creating) ...[
                          _textField(
                            label: 'Full Name',
                            icon: Icons.person_outline_rounded,
                            controller: _nameController,
                            keyName: 'nameField',
                            validator: (value) =>
                                (value?.trim().isNotEmpty ?? false)
                                    ? null
                                    : 'Enter your name.',
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 11),
                          _textField(
                            label: 'Phone Number',
                            icon: Icons.call_outlined,
                            controller: _phoneController,
                            keyName: 'phoneField',
                            validator: (value) =>
                                (value?.trim().length ?? 0) >= 7
                                    ? null
                                    : 'Enter a valid phone number.',
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 11),
                        ],
                        _textField(
                          label: 'Email Address',
                          icon: Icons.mail_outline_rounded,
                          controller: _emailController,
                          keyName: 'emailField',
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 11),
                        _passwordField(confirm: false),
                        if (!creating) ...[
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              SizedBox(
                                width: 32,
                                child: Checkbox(
                                  value: _rememberMe,
                                  activeColor: _green,
                                  visualDensity: VisualDensity.compact,
                                  onChanged: (value) => setState(
                                    () => _rememberMe = value ?? false,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Text(
                                  'Remember me',
                                  style: TextStyle(color: _muted, fontSize: 11),
                                ),
                              ),
                              TextButton(
                                onPressed: () => _showDemoMessage(
                                  'Password recovery is not connected in demo mode.',
                                ),
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(fontSize: 11, color: _green),
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          const SizedBox(height: 11),
                          _passwordField(confirm: true),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 49,
                    child: FilledButton.icon(
                      key: ValueKey(creating ? 'signUpButton' : 'loginButton'),
                      onPressed: _continueToShop,
                      icon: Text(creating ? 'Sign Up' : 'Login'),
                      label: const Icon(Icons.arrow_forward_rounded),
                      style: _primaryButtonStyle,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const _OrContinueDivider(),
                  const SizedBox(height: 12),
                  _SocialButton(
                    icon: const _GoogleMark(),
                    label: 'Continue with Google',
                    onPressed: () => _showDemoMessage(
                      'Google sign-in is not connected in demo mode.',
                    ),
                  ),
                  const SizedBox(height: 9),
                  _SocialButton(
                    icon: const Icon(Icons.apple, color: Colors.black),
                    label: 'Continue with Apple',
                    onPressed: () => _showDemoMessage(
                      'Apple sign-in is not connected in demo mode.',
                    ),
                  ),
                  const SizedBox(height: 13),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        creating
                            ? 'Already have an account? '
                            : 'Don’t have an account? ',
                        style: const TextStyle(color: _muted, fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () => setState(() {
                          _creatingAccount = !creating;
                          _formKey.currentState?.reset();
                        }),
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                            vertical: 5,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          creating ? 'Login' : 'Sign Up',
                          style: const TextStyle(
                            color: _green,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandLockup extends StatelessWidget {
  const _BrandLockup({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 62 : 76,
          height: compact ? 62 : 76,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(compact ? 20 : 25),
            boxShadow: const [
              BoxShadow(
                color: Color(0x17204A37),
                blurRadius: 22,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.local_drink_rounded,
            size: compact ? 36 : 45,
            color: _green,
          ),
        ),
        SizedBox(height: compact ? 5 : 8),
        Text(
          'Al Wasay',
          style: TextStyle(
            color: _ink,
            fontSize: compact ? 24 : 31,
            height: 1,
            letterSpacing: -1.1,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Text(
          'Milk Shop',
          style: TextStyle(
            color: _green,
            fontSize: 14,
            height: 1.4,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          'Fresh Milk, Healthy You',
          style: TextStyle(color: _muted, fontSize: 11),
        ),
      ],
    );
  }
}

class _DairyIllustration extends StatelessWidget {
  const _DairyIllustration({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: CustomPaint(painter: _PasturePainter())),
          Positioned(
            top: height * .13,
            left: 13,
            child: const _LeafDecoration(size: 29, rotation: -.65),
          ),
          Positioned(
            top: height * .08,
            right: 20,
            child: const _LeafDecoration(size: 35, rotation: .6),
          ),
          Positioned(
            left: height * .34,
            bottom: height * .14,
            child: Transform.rotate(
              angle: -.10,
              child: _MilkBottle(height: height * .61),
            ),
          ),
          Positioned(
            right: height * .21,
            bottom: height * .15,
            child: _MilkGlass(height: height * .28),
          ),
          Positioned(
            right: height * .43,
            bottom: height * .14,
            child: const _ButterBlock(),
          ),
          Positioned(
            left: height * .08,
            bottom: height * .18,
            child: const _MilkCan(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: height * .07,
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFB48A58),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Color(0x33806B45), blurRadius: 6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PasturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(34)),
      Paint()..color = const Color(0xFFE5F4FA),
    );
    canvas.drawCircle(
      Offset(size.width * .81, size.height * .19),
      size.height * .075,
      Paint()..color = const Color(0xFFFFDF92),
    );

    final farHill = Path()
      ..moveTo(0, size.height * .63)
      ..cubicTo(
        size.width * .24,
        size.height * .42,
        size.width * .36,
        size.height * .67,
        size.width * .60,
        size.height * .50,
      )
      ..cubicTo(
        size.width * .78,
        size.height * .36,
        size.width * .85,
        size.height * .43,
        size.width,
        size.height * .34,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(farHill, Paint()..color = const Color(0xFFA7D1C0));

    final nearHill = Path()
      ..moveTo(0, size.height * .73)
      ..cubicTo(
        size.width * .18,
        size.height * .58,
        size.width * .39,
        size.height * .72,
        size.width * .58,
        size.height * .63,
      )
      ..cubicTo(
        size.width * .76,
        size.height * .55,
        size.width * .85,
        size.height * .68,
        size.width,
        size.height * .58,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(nearHill, Paint()..color = const Color(0xFF75B48E));

    final meadow = Path()
      ..moveTo(0, size.height * .84)
      ..quadraticBezierTo(
        size.width * .48,
        size.height * .70,
        size.width,
        size.height * .80,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(meadow, Paint()..color = const Color(0xFF438C60));

    for (var index = 0; index < 25; index++) {
      final x = size.width * (index / 24);
      final y = size.height * (.82 + .08 * math.sin(index * .72));
      canvas.drawLine(
        Offset(x, y + 4),
        Offset(x - 3 + (index % 3) * 3, y - 4),
        Paint()
          ..color = const Color(0xFF36734E)
          ..strokeWidth = 1.5
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PasturePainter oldDelegate) => false;
}

class _MilkBottle extends StatelessWidget {
  const _MilkBottle({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: height * .56,
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: height * .20,
            bottom: 0,
            child: Container(
              width: height * .55,
              decoration: BoxDecoration(
                color: const Color(0xFFFCFFFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(height * .13),
                  topRight: Radius.circular(height * .13),
                  bottomLeft: Radius.circular(height * .09),
                  bottomRight: Radius.circular(height * .09),
                ),
                border: Border.all(color: const Color(0xFFDCEAE3), width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x2B284A3A),
                    blurRadius: 14,
                    offset: Offset(2, 8),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.water_drop_rounded,
                  color: const Color(0xFF94C8AC),
                  size: height * .25,
                ),
              ),
            ),
          ),
          Positioned(
            top: height * .10,
            child: Container(
              width: height * .28,
              height: height * .18,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FFFC),
                border: Border.all(color: const Color(0xFFDCEAE3), width: 2),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(height * .09),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * .04,
            child: Container(
              width: height * .31,
              height: height * .10,
              decoration: BoxDecoration(
                color: _green,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Positioned(
            left: height * .08,
            top: height * .32,
            child: Container(
              width: 3,
              height: height * .26,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MilkGlass extends StatelessWidget {
  const _MilkGlass({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height * .74,
      height: height,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0x67FFFFFF),
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(height * .12),
          bottomRight: Radius.circular(height * .12),
          topLeft: Radius.circular(height * .04),
          topRight: Radius.circular(height * .04),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: height * .70,
          decoration: BoxDecoration(
            color: const Color(0xFFFAFFFF),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(height * .08),
              bottomRight: Radius.circular(height * .08),
              topLeft: Radius.circular(height * .03),
              topRight: Radius.circular(height * .03),
            ),
          ),
        ),
      ),
    );
  }
}

class _ButterBlock extends StatelessWidget {
  const _ButterBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47,
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFFFD981),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFE7AD), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x332C4B31),
            blurRadius: 6,
            offset: Offset(1, 4),
          ),
        ],
      ),
      child: const Icon(
        Icons.star_rounded,
        color: Color(0xFFFFF4D6),
        size: 20,
      ),
    );
  }
}

class _MilkCan extends StatelessWidget {
  const _MilkCan();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 31,
      height: 53,
      decoration: BoxDecoration(
        color: const Color(0xFFEDF7F2),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: const Icon(Icons.local_drink_outlined, size: 19, color: _green),
    );
  }
}

class _LeafDecoration extends StatelessWidget {
  const _LeafDecoration({required this.size, required this.rotation});

  final double size;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Icon(
        Icons.eco_rounded,
        size: size,
        color: const Color(0xFF81B96B),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 17,
          height: 7,
          decoration: BoxDecoration(
            color: _green,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 5),
        const _InactiveDot(),
        const SizedBox(width: 5),
        const _InactiveDot(),
      ],
    );
  }
}

class _InactiveDot extends StatelessWidget {
  const _InactiveDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: Color(0xFFB8CEC0),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _OrContinueDivider extends StatelessWidget {
  const _OrContinueDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFDDE8E0))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or continue with',
            style: TextStyle(color: _muted, fontSize: 11),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFDDE8E0))),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Widget icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(43),
        foregroundColor: _ink,
        backgroundColor: Colors.white.withValues(alpha: .62),
        side: const BorderSide(color: Color(0xFFDDE8E0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _GoogleMark extends StatelessWidget {
  const _GoogleMark();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 19,
      height: 19,
      child: Center(
        child: Text(
          'G',
          style: TextStyle(
            color: Color(0xFF4285F4),
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
