import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/new_category.dart';
import 'package:to_do/ui/widgets/add_task_field.dart';

class CategoryTasks extends StatefulWidget {
  @override
  _CategoryTasksState createState() => _CategoryTasksState();
}

class _CategoryTasksState extends State<CategoryTasks> {
  ScrollController _scrollController;

  bool _needScroll = false;

  _scrollToEnd() async {
    if (_needScroll) {
      _needScroll = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Used to scroll to end of list after adding new task
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollToEnd();
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 0.0),
          child: Consumer<NewCategory>(
            builder: (_, value, __) => Text(
              value.name,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
          child: AddTaskField(
            addTask: () {
              Provider.of<NewCategory>(context, listen: false)
                  .addTaskToTemporaryList(context);
              _needScroll = true;
            },
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          TASK_SINGULAR_CAPITAL,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Expanded(
          child: Consumer<NewCategory>(
            builder: (_, value, __) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Scrollbar(
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: value.tasks.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      title: Text(value.tasks[index].name),
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
