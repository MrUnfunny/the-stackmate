import 'package:flutter/material.dart';
import 'package:sats/cubit/chain-select.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/pkg/extensions.dart';

class SelectNetwork extends StatelessWidget {
  const SelectNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    final blockchain = c.select((ChainSelectCubit b) => b.state.blockchain);
    return ElevatedButton(
      onPressed: () {
        if (blockchain == Blockchain.main)
          c.read<ChainSelectCubit>().changeBlockchain(Blockchain.test);
        else
          c.read<ChainSelectCubit>().changeBlockchain(Blockchain.main);
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: c.colours.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
      child: Container(
        height: 80,
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change Network',
                  style: c.fonts.button!.copyWith(
                    color: c.colours.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  blockchain.displayName.toUpperCase(),
                  maxLines: 3,
                  style: c.fonts.bodyMedium!.copyWith(
                    color: c.colours.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Image.asset(
              'assets/icon/bitcoin_icons/png/outline/node.png',
              width: 52,
              height: 52,
              color: c.colours.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
