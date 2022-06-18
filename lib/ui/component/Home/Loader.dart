import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sats/cubit/tor.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/ui/component/common/loading.dart';

class HomeLoader extends StatelessWidget {
  const HomeLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tor = context.select((TorCubit hc) => hc.state);
    // final fees = context.select((FeesCubit hc) => hc.state);
    const String loading = 'Connecting to Tor...';
    if (tor.isConnected) return Container();
    if (tor.errConnection != '') return Text(tor.errConnection);
    return const Loading(
      text: loading,
    );

    return Container();
  }
}
