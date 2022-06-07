import 'package:flutter/material.dart';
import 'package:sats/cubit/fees.dart';
import 'package:sats/cubit/preferences.dart';
import 'package:sats/cubit/tor.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/ui/component/Home/Actions.dart';
import 'package:sats/ui/component/Home/Header.dart';
import 'package:sats/ui/component/Home/Loader.dart';
import 'package:sats/ui/component/Network/MyIdentity/Entrypoint.dart';
import 'package:sats/ui/component/Network/Tools.dart';

class _NetworkHome extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (context, prefState) {
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              displacement: 10.0,
              onRefresh: () async {
                c.read<WalletsCubit>().refresh();
                c.read<TorCubit>().start();
                c.read<TorCubit>().checkStatus();
                // if (c.select((TorCubit t) => t.state).isRunning
                return;
              },
              child: BlocBuilder<TorCubit, TorState>(
                builder: (context, torState) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        stretch: true,
                        pinned: true,
                        expandedHeight: c.height / 3,
                        automaticallyImplyLeading: false,
                        backgroundColor: c.colours.background,
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: const [
                            StretchMode.fadeTitle,
                          ],
                          background: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const HomeLoader(),
                              if (torState.isConnected) ...[
                                HomeHeader(),
                                EnterMyIdentity(),
                                SocialTools(),
                              ] else
                                Container()
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                                left: 12,
                                right: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (torState.isConnected)
                                    ...[]
                                  else ...[Container()]
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          bottomNavigationBar: HomeActions(),
        );
      },
    );
  }
}

class NetworkHomeScreen extends StatelessWidget {
  const NetworkHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _NetworkHome();
  }
}
