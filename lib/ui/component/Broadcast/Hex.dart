import 'package:flutter/material.dart';
import 'package:sats/cubit/broadcast.dart';
import 'package:sats/pkg/extensions.dart';

class BroadcastHex extends StatelessWidget {
  const BroadcastHex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<BroadcastCubit, BroadcastState>(
      builder: (context, broadcastState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Broadcast Hex'.toUpperCase(),
              textAlign: TextAlign.center,
              style: context.fonts.overline!.copyWith(
                color: context.colours.onBackground,
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              height: 52,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: c.colours.onPrimary),
                  primary: c.colours.primary,
                  onSurface: c.colours.background,
                ),
                onPressed: () {
                  context.read<BroadcastCubit>().pasteHex();
                },
                child: const Text('PASTE from Clipboard'),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 52,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: c.colours.onPrimary),
                  primary: c.colours.primary,
                  onSurface: c.colours.background,
                ),
                onPressed: () {
                  c.read<BroadcastCubit>().updateHexFile();
                },
                child: Text('Import hex'.toUpperCase() + ''),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 52,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: c.colours.onPrimary),
                  primary: c.colours.primary,
                  onSurface: c.colours.background,
                ),
                onPressed: () {
                  c.read<BroadcastCubit>().verifyImportHex();
                },
                child: Text('verify hex'.toUpperCase() + ''),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: c.colours.primary,
                  onPrimary: c.colours.background,
                ),
                onPressed: () {
                  context.read<BroadcastCubit>().broadcastHexConfirmed();
                },
                child: const Text('CONFIRM'),
              ),
            ),
            const SizedBox(height: 16),
            if (broadcastState.txId != '')
              Text(
                broadcastState.txId,
                textAlign: TextAlign.center,
                style: context.fonts.headline6!.copyWith(
                  color: context.colours.onBackground,
                ),
              )
            else
              Container(),
            if (broadcastState.errBroadcasting != '')
              Text(
                broadcastState.errBroadcasting,
                textAlign: TextAlign.center,
                style: context.fonts.caption!.copyWith(
                  color: context.colours.error,
                ),
              )
            else
              Container(),
          ],
        );
      },
    );
  }
}
