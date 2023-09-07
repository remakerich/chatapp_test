import 'package:chatapp_test/features/chat/widgets/chat_screen.dart';
import 'package:chatapp_test/core/core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > Constants.narrowScreenThreshold) {
          return const _WideScreenLayout();
        }
        return const ChatScreen();
      },
    );
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
          child: _ChatsList(),
        ),
        _Separator(),
        Expanded(
          flex: Constants.chatFlex,
          child: ChatScreen(),
        ),
      ],
    );
  }
}

class _ChatsList extends StatelessWidget {
  const _ChatsList();

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      color: Colors.grey,
    );
  }
}
