import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/providers/providers.dart';
import 'package:mestorapp/utils/utils.dart';
import 'package:mestorapp/widgets/widgests.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actsProv = ref.watch(activitiesNotifierProvider);
    final recordFilter = ref.watch(recordFilterNotifierProvider);
    final textTheme = Theme.of(context).textTheme;

    void openActivityMenu(Activity act) {
      showDialog(
        context: context,
        builder: (_) => ActivityOptionsDialog(act: act),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(12),
        child: AppBar(
          title: Text("MESTOR", style: textTheme.bodySmall),
          centerTitle: true,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "What you did",
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium,
            ),
            Text(
              getLabel(recordFilter),
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lightbulb, size: 14),
                Text(
                  "Long press to see more options",
                  style: textTheme.bodySmall
                      ?.copyWith(fontStyle: FontStyle.italic),
                ),
              ],
            ),
            const SizedBox(height: 8),
            actsProv.when(
              error: (error, _) => Text('$error'),
              loading: () => const CircularProgressIndicator(),
              data: (acts) => Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 90,
                  ),
                  itemCount: acts.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == acts.length) {
                      return Center(
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => context.push("/new_activity"),
                          padding: const EdgeInsets.all(18),
                        ),
                      );
                    }
                    return ActivityItem(
                      activity: acts[index],
                      openActivityMenu: openActivityMenu,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
