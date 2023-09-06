import 'package:chatapp_test/core/constants.dart';
import 'package:chatapp_test/core/extensions.dart';
import 'package:chatapp_test/features/chats/widgets/chats_list_screen.dart';
import 'package:chatapp_test/features/room/widgets/room_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isNarrowScreen) {
      return const RoomScreen();
    }

    return const _WideScreenLayout();
  }
}

class _WideScreenLayout extends StatelessWidget {
  const _WideScreenLayout();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: Constants.chatsListFlex,
          child: ChatsListScreen(),
        ),
        _Separator(),
        Expanded(
          flex: Constants.chatRoomFlex,
          child: RoomScreen(),
        ),
      ],
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.separatorWidth,
      color: Colors.grey,
    );
  }
}
