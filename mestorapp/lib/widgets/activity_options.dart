import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mestorapp/domain/models/models.dart';

class ActivityOptionsDialog extends StatelessWidget {
  final Activity act;

  const ActivityOptionsDialog({super.key, required this.act});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(act.name),
      children: [
        SimpleDialogOption(
          child: const Text("Edit"),
          onPressed: () {
            context.push("/new_activity");
          },
        ),
        SimpleDialogOption(
          child: const Text("Close"),
          onPressed: () {
            context.pop();
          },
        ),
      ],
    );
  }
}
