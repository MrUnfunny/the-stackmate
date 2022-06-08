import 'package:flutter/material.dart';
import 'package:sats/cubit/tor.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/ui/component/Landing/Loader.dart';
import 'package:sats/ui/component/Landing/Logo.dart';
import 'package:sats/ui/component/Landing/Start.dart';
import 'package:sats/ui/component/Tor/Manual.dart';

class _Landing extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<TorCubit, TorState>(
      // listener: (context, state) {
      // if (state.isRunning && masterKey != null) {
      //   c.pop();
      //   c.push('/home');
      // }
      // if (state.isRunning && masterKey == null) {
      //   c.pop();
      //   c.push('/add-wallet');
      // }
      // },
      builder: (context, torState) {
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              edgeOffset: 10.0,
              displacement: 10.0,
              onRefresh: () async {
                // c.read<TorCubit>().start();
                c.read<TorCubit>().checkStatus();
                c.read<TorCubit>().testConnection();

                // c.read<TorCubit>().getProgress();
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    stretch: true,
                    pinned: true,
                    expandedHeight: c.height / 1.2,
                    automaticallyImplyLeading: false,
                    backgroundColor: c.colours.background,
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.fadeTitle,
                      ],
                      background: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const LandingLoader(),
                          const SizedBox(height: 48),
                          const LandingLogo(),
                          if (torState.isConnected) Container(),
                          const SizedBox(height: 12),
                          ManualTor()
                          // const Start(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const Start(),
        );
      },
    );
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Landing();
  }
}
