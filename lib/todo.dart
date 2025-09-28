/*
  ================================
  WELCOME TO: To-Do List App
  ================================
  This is a VERY beginner-friendly Flutter example.

  GOAL OF THIS APP:
  - Let the user type a task name (like: "Buy milk")
  - Press a button to add it to a list
  - Show all tasks in a scrollable list
  - Let the user:
      * Mark a task as "done" using a checkbox
      * Delete a task using a trash icon
  - Show how many tasks are completed vs total

  DESIGN PRINCIPLES:
  - Only ONE Dart file (this file).
  - No advanced patterns (no state management libraries, no databases).
  - Everything explained with plain English comments.
  - Simple in-memory list (if you close the app, tasks are lost).
  - Super clear and slow-paced explanations so even a NON-TECHNICAL beginner can follow.

  HOW TO RUN:
  1. Create a new Flutter project (e.g., run in terminal: flutter create todo_list_app).
  2. Replace the contents of lib/main.dart with THIS file.
  3. Run: flutter run
  4. Start adding tasks!

  WHAT YOU WILL LEARN:
  - What a "main" function does.
  - What a Widget is (a building block of the UI).
  - Difference between StatelessWidget and StatefulWidget.
  - How we store and update a list of items.
  - How setState() re-draws (rebuilds) the screen.
  - How layout widgets (Column, Row, Expanded, Padding) position things.
*/

/*
  This is the entry point of every Dart / Flutter program.
  The 'main' function runs first.
  We call runApp() and give it the ROOT widget of our app.
*/
import 'package:flutter/material.dart';

void main() {
  // runApp() tells Flutter: "Start showing things on the screen using this widget tree."
  runApp(const ToDoListApp());
}

/*
  This class represents the entire application.

  Why does it extend StatelessWidget?
  - Because this outer shell of the app does NOT need to change by itself.
  - It simply sets up global things like:
      * App title
      * Theme (colors, styles)
      * The home screen widget (our main page)
*/
class ToDoListApp extends StatelessWidget {
  // 'const' means this widget never changes internally.
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*
      MaterialApp is a special widget that gives us:
        - A basic visual style following Google's Material Design.
        - A place to define title, theme, routes, etc.
    */
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the "debug" banner
      title: 'To-Do List App', // Shown in app switcher
      theme: ThemeData(
        // A simple color theme (not required, but looks nicer)
        primarySwatch: Colors.indigo,
        useMaterial3: true, // Newer Material styling
      ),
      home:
      const ToDoHomePage(), // This is the FIRST screen (also called "home screen") shown when the app starts.
    );
  }
}

/*
  A SIMPLE DATA CLASS (also called a "model").

  What is a Task?
  - A task has:
      * A text/title (what to do)
      * A boolean flag telling if it's finished (completed)

  We create a class so that each task is a neat "object" we can manage,
  instead of using raw Maps or separate lists.
*/
class Task {
  String title;
  bool isDone;

  Task({
    required this.title,
    this.isDone = false, // Default: not done yet
  });
}

/*
  This is the MAIN SCREEN of the app where:
    - User types new tasks.
    - Sees existing tasks.
    - Marks tasks complete OR deletes them.

  Why StatefulWidget?
  - Because the list of tasks CHANGES over time (we add/remove/mark them).
  - StatefulWidget lets us store mutable (changeable) data in its State object.
*/
class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

/*
  This class holds the CHANGING DATA and the UI BUILD LOGIC
  for the ToDoHomePage widget above.

  Naming rule:
    - If the widget is called SomeWidget (Stateful),
      the state class is called _SomeWidgetState.

  The underscore "_" at the start means:
    - This class is PRIVATE to this file (not accessible elsewhere).
*/
class _ToDoHomePageState extends State<ToDoHomePage> {
  /*
    This list will store all our Task objects.
    - Starts empty.
    - When user adds a task, we push a new Task into it.
    - When user deletes a task, we remove it.
    - When user toggles a checkbox, we flip its isDone value.

    IMPORTANT:
    - Because this is inside the State class, when we modify the list
      and call setState(), Flutter rebuilds the screen to show the changes.
  */
  final List<Task> _tasks = [];

  /*
    This controller connects to the TextField where the user types a new task.
    It lets us:
      - Read what the user typed.
      - Clear the text after adding.
  */
  final TextEditingController _taskInputController = TextEditingController();

  /*
    CLEAN-UP:
    - When this screen widget is removed permanently (e.g., app closed),
      we dispose (release) the controller to free system resources.
  */
  @override
  void dispose() {
    _taskInputController.dispose();
    super.dispose();
  }

  /*
    This function is called when user presses the "ADD" button or the keyboard "done".
    STEPS:
      1. Read the text from the input field.
      2. Trim spaces.
      3. If not empty, create a new Task and add it to the list.
      4. Call setState() so Flutter redraws the screen with the new task.
      5. Clear the text field for the next input.
  */
  void _addTask() {
    final text = _taskInputController.text.trim();
    if (text.isEmpty) {
      // Do nothing if blank
      return;
    }
    setState(() {
      _tasks.add(Task(title: text));
    });
    _taskInputController.clear();
  }

  /*
    Toggle (flip) the completion status of a task at a given index.
    - If it was false -> becomes true.
    - If it was true -> becomes false.
  */
  void _toggleTaskDone(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  /*
    Remove a task completely from the list.
  */
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  /*
    Helper to count how many tasks are completed.
  */
  int get _completedCount =>
      _tasks.where((task) => task.isDone).length; // filters only done ones

  @override
  Widget build(BuildContext context) {
    /*
      Scaffold is a ready-made layout structure that provides:
        - App bar (top bar)
        - Body area (main content)
        - Floating action button (optional)
        - Snack bars, drawers, etc.
    */
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List App',
          // Text shown in the top bar
        ),
        centerTitle: true, // Center the title horizontally
      ),

      /*
        The main area (body) of the screen.
        We wrap EVERYTHING in Padding to avoid touching screen edges.
      */
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Space from edges
        child: Column(
          /*
            Column arranges its children VERTICALLY (top to bottom).
            Children we will include (in order):
              1. A header summary (how many tasks total / done)
              2. A text input row (TextField + Add Button)
              3. A spacing gap
              4. The list of tasks (Scrollable)
          */
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSummaryHeader(),
            const SizedBox(height: 16), // Just visual space
            _buildInputRow(),
            const SizedBox(height: 16),
            /*
              Expanded:
              - Tells the Column: "Let this child take ALL the remaining vertical space."
              - Inside it we place the ListView (scrollable list of tasks).
              Without Expanded, the ListView would try to be infinite height and cause errors.
            */
            Expanded(child: _buildTaskList()),
          ],
        ),
      ),

      /*
        A FloatingActionButton (round button floating over content)
        gives users a quick way to add tasks too.

        It does the exact same thing as the "ADD" button next to the text field.
        We provide both to show multiple interaction styles.
      */
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }

  /*
    Builds the top summary text.
    Example: "You have 3 tasks (1 completed)"
  */
  Widget _buildSummaryHeader() {
    return Container(
      /*
        A decorative container with slight background to highlight info.
      */
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'You have ${_tasks.length} task(s) (${_completedCount} completed)',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /*
    Builds the row containing:
      [ TextField | Add Button ]

    Layout explanation:
    - Row arranges children horizontally (left to right).
    - Expanded around TextField = it takes all remaining space.
    - SizedBox width adds space between TextField and button.
  */
  Widget _buildInputRow() {
    return Row(
      children: [
        /*
          Expanded => Let the TextField stretch to use most of the row width.
        */
        Expanded(
          child: TextField(
            controller: _taskInputController, // Connects input to our controller
            decoration: const InputDecoration(
              labelText: 'Enter a new task', // Faint label inside box
              border: OutlineInputBorder(), // Draws an outlined box
            ),
            onSubmitted: (_) =>
                _addTask(), // Pressing "Enter" / "Done" adds the task
          ),
        ),
        const SizedBox(width: 8), // Gap between field and button
        /*
          ElevatedButton is a standard clickable button with elevation (shadow).
        */
        ElevatedButton(
          onPressed: _addTask,
          child: const Text('ADD'),
        ),
      ],
    );
  }

  /*
    Builds the scrollable list of tasks.

    If there are no tasks, we show a friendly message instead.

    ListView.builder:
      - Efficiently builds only the visible rows.
      - itemCount tells how many items.
      - itemBuilder is called for each index.

    Each row uses ListTile:
      - leading: a Checkbox to mark done.
      - title: task text (with line-through if completed).
      - trailing: a delete icon button.
  */
  Widget _buildTaskList() {
    if (_tasks.isEmpty) {
      return const Center(
        /*
          Center widget centers its child both horizontally and vertically.
        */
        child: Text(
          'No tasks yet.\nAdd something above!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index]; // Current task

        return Card(
          /*
            Card gives a slight shadow & rounded corners to visually separate each task.
          */
          child: ListTile(
            /*
              Checkbox to show and toggle completion.
              value: whether it's checked (done).
              onChanged: what happens when user taps it.
            */
            leading: Checkbox(
              value: task.isDone,
              onChanged: (_) => _toggleTaskDone(index),
            ),
            /*
              The main text for the task.
              If the task is done, we show a line-through style to indicate completion.
            */
            title: Text(
              task.title,
              style: TextStyle(
                decoration:
                task.isDone ? TextDecoration.lineThrough : TextDecoration
                    .none,
                color: task.isDone ? Colors.grey : Colors.black,
              ),
            ),
            /*
              A trash can icon to delete the task.
              onPressed calls _deleteTask().
            */
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => _deleteTask(index),
              tooltip: 'Delete this task',
            ),
          ),
        );
      },
    );
  }
}

/*
  END OF FILE
  You now have a fully working, simple To-Do List app!

  IDEAS TO IMPROVE (Optional for later learning):
    - Save tasks to local storage (e.g., using shared_preferences package).
    - Let user edit an existing task.
    - Add categories or due dates.
    - Add a "clear completed" button.
    - Persist tasks in a database (Hive, SQLite).
    - Add animations.

  But for now, this is intentionally kept VERY SIMPLE.
*/