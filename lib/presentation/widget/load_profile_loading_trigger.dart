import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifier/login_notifier.dart';

class LoadProfileLoadingTrigger extends StatefulWidget {
  final Widget child;

  const LoadProfileLoadingTrigger({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  State<LoadProfileLoadingTrigger> createState() => _LoadProfileLoadingTriggerState();
}

class _LoadProfileLoadingTriggerState extends State<LoadProfileLoadingTrigger> {
  late LoginNotifier _loginNotifier;

  @override
  void initState() {
    super.initState();
    _loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loginNotifier.loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}