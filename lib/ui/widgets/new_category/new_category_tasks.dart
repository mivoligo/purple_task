import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/new_category.dart';
import 'package:to_do/ui/widgets/add_task_field.dart';

class CategoryTasks extends StatefulWidget {
  final Function onFinishPressed;

  const CategoryTasks({
    Key key,
    @required this.onFinishPressed,
  }) : super(key: key);

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
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
          child: AddTaskField(
            addTask: () {
              Provider.of<NewCategory>(context, listen: false).addTask(context);
              _needScroll = true;
            },
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          TASK_SINGULAR_CAPITAL,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
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
        Row(
          children: [
            SizedBox(width: 16.0),
            FlatButton(
              color: Colors.grey[400],
              child: Text(CANCEL),
              onPressed: () {
                Provider.of<NewCategory>(context, listen: false)
                    .addingNewCategoryCompleted = false;
                Navigator.of(context).pop();
              },
            ),
            Spacer(),
            FlatButton(
              autofocus: true,
              color: Colors.green,
              child: Text(FINISH),
              onPressed: widget.onFinishPressed,
            ),
            SizedBox(width: 16.0),
          ],
        )
      ],
    );
  }
}
