import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sats/cubit/master.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/ui/component/AddWallet/SelectButton.dart';
import 'package:sats/ui/component/common/BackButton.dart';
import 'package:sats/ui/component/common/header.dart';

class AddWalletScreen extends StatelessWidget {
  const AddWalletScreen({Key? key}) : super(key: key);
  final primaryWallet = 'PRIMARY';
  final importWallet = 'IMPORT';

  @override
  Widget build(BuildContext c) {
    final masterKey = c.select((MasterKeyCubit mc) => mc.state.key);
    final wallets = c.select((WalletsCubit wc) => wc.state);
    var signerExists = false;

    for (final wallet in wallets.wallets) {
      if (wallet.walletType == primaryWallet ||
          wallet.walletType == importWallet) signerExists = true;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            if (masterKey == null)
              Header(
                cornerTitle: 'Master Key'.toUpperCase(),
                children: [
                  Back(
                    onPressed: () {
                      Navigator.pop(c);
                    },
                  ),
                ],
              )
            else
              Header(
                cornerTitle: 'Add Account'.toUpperCase(),
                children: [
                  Back(
                    onPressed: () {
                      Navigator.pop(c);
                    },
                  ),
                ],
              ),
            const SizedBox(height: 24),
            if (masterKey == null) ...[
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'A 12/24 word mnemonic phrase represents your MASTER KEY.\n\nPRIMARY and SOCIAL accounts will be created from it.\n\nYou need it to recover these accounts.',
                  style: c.theme.primaryTextTheme.bodySmall!.copyWith(
                    color: c.colours.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
            if (masterKey == null) ...[
              const SizedBox(height: 16),
              SelectButton(
                text: 'New',
                description: 'Create a new mnemonic.',
                colour: c.colours.surface,
                onPressed: () {
                  c.push('/generate-seed');
                },
              ),
              const SizedBox(height: 16),
              SelectButton(
                text: 'Import',
                description: 'Import an existing mnemonic.',
                colour: c.colours.surface,
                onPressed: () {
                  c.push('/import-seed');
                },
              ),
            ],
            if (masterKey != null) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'WATCHER'.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: c.fonts.caption!.copyWith(
                    color: c.colours.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SelectButton(
                text: 'Coldcard',
                description: 'Import JSON from ColdCard.',
                colour: c.colours.surface,
                onPressed: () {
                  c.push('/coldcard');
                },
              ),
              const SizedBox(height: 8),
              SelectButton(
                text: 'Manual',
                description: 'Import a raw public key.',
                colour: c.colours.surface,
                onPressed: () {
                  c.push('/watch-only');
                },
              ),
              const SizedBox(height: 16),
              // SelectButton(
              //   text: 'Legacy (coming soon...)',
              //   description:
              //       'Derive a legacy ("1") account from your master key.',
              //   colour: c.colours.surface,
              //   onPressed: () {
              //     // c.push('/watch-only');
              //   },
              // ),
              // const SizedBox(height: 16),
              // SelectButton(
              //   text: 'Compatible (coming soon...)',
              //   description:
              //       'Derive a compatible ("3") account from your master key.',
              //   colour: c.colours.surface,
              //   onPressed: () {
              //     // c.push('/watch-only');
              //   },
              // ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'SIGNER'.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: c.fonts.caption!.copyWith(
                    color: c.colours.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SelectButton(
                text: 'DERIVE',
                description: 'Derive accounts from master key.',
                colour: c.colours.surface,
                onPressed: () {
                  c.push('/derive-account');
                },
              ),
              const SizedBox(height: 16),
              SelectButton(
                text: 'RECOVER',
                description: 'Recover an old wallet.',
                colour: c.colours.surface,
                onPressed: () {
                  c.push('/import-seed');
                },
              ),
            ],
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
