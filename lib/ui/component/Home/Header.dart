import 'package:flutter/material.dart';
import 'package:sats/cubit/tor.dart';
import 'package:sats/pkg/extensions.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tor = context.select((TorCubit t) => t.state);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Row(
        //   children: [
        //     const Spacer(),
        //     LogButton(
        //       child: Padding(
        //         padding: const EdgeInsets.only(right: 19),
        //         child: IconButton(
        //           onPressed: () {},
        //           icon: Icon(
        //             Icons.lightbulb_outline_sharp,
        //             size: 32,
        //             color: context.colours.primary,
        //             semanticLabel: 'Logs',
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 2,
        ),
        if (tor.isConnected)
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Tooltip(
              preferBelow: false,
              triggerMode: TooltipTriggerMode.tap,
              message: (tor.isRunning)
                  ? 'Torified Natively.'
                  : 'Torified via External.',
              textStyle: context.fonts.caption!.copyWith(
                color: context.colours.primary,
              ),
              decoration: BoxDecoration(
                color: context.colours.surface,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                Icons.security_sharp,
                color: context.colours.tertiaryContainer,
              ),
            ),
          )
        else ...[
          Icon(
            Icons.security_sharp,
            color: context.colours.error,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            'Lost connection to Tor.\nGoto settings to reconnect.',
            textAlign: TextAlign.center,
            style: context.fonts.caption!.copyWith(
              color: context.colours.error,
            ),
          ),
        ]
      ],
    );
  }
}
