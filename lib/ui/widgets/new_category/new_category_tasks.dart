import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../globals/globals.dart';
import '../../ui.dart';

class CategoryTasks extends StatefulWidget {
  @override
  _CategoryTasksState createState() => _CategoryTasksState();
}

class _CategoryTasksState extends State<CategoryTasks> {
  ScrollController? _scrollController;

  bool _needScroll = false;

  _scrollToTop() async {
    if (_needScroll) {
      _needScroll = false;
      _scrollController!.animateTo(_scrollController!.position.minScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Used to scroll to end of list after adding new task
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _scrollToTop();
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 0.0),
          child: Consumer<NewCategoryViewModel>(
            builder: (_, value, __) => Text(
              value.name,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
          child: AddTaskField(
            addTask: () {
              Provider.of<NewCategoryViewModel>(context, listen: false)
                  .addTaskToTemporaryList(context);
              _needScroll = true;
            },
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          TASK_SINGULAR_CAPITAL,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
            child: Scrollbar(
              child: Consumer<NewCategoryViewModel>(
                builder: (_, value, __) => ListView.separated(
                  controller: _scrollController,
                  itemCount: value.tasks.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 6.0),
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      title: Text(value.tasks[index].name!),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
