import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/common/xpub-import.dart';
import 'package:sats/cubit/new-wallet/from-old-xpub.dart';
import 'package:sats/pkg/extensions.dart';

class XpubLabel extends StatelessWidget {
  const XpubLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<XpubImportWalletCubit, XpubImportWalletState>(
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state.savingWallet,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: state.savingWallet ? 0.5 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Label your wallet',
                  style: c.fonts.headline4!.copyWith(
                    color: c.colours.onPrimary,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.zero,
                  child: TextField(
                    onChanged: (text) {
                      c.read<XpubImportWalletCubit>().labelChanged(text);
                    },
                    style: TextStyle(color: c.colours.onPrimary),
                    decoration: InputDecoration(
                      labelText: 'Wallet Name',
                      labelStyle: TextStyle(
                        color: context.colours.onPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                if (state.errSavingWallet != '')
                  Text(
                    state.errSavingWallet,
                    style: c.fonts.caption!.copyWith(color: c.colours.error),
                  ),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: c.colours.primary,
                      onPrimary: c.colours.background,
                    ),
                    onPressed: () {
                      c.read<XpubImportWalletCubit>().nextClicked();
                      c.read<XpubImportCubit>().clearCachedFiles();
                    },
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
