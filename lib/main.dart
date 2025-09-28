/*
NEWLY ADDED CONCEPTS (Read while you explore code):
1. Dark/Light Theme Toggle (with persistence)
2. Enum (TodoFilter) to filter list (All / Active / Completed)
3. Extension method on DateTime for readable formatting
4. Generic class Result<T> to teach generics
5. Mixin (LoggingMixin) for reusable behavior
6. Explicit animation (AnimationController + RotationTransition)
7. Implicit animations (AnimatedOpacity / AnimatedContainer)
8. FutureBuilder (async "Tip of the moment")
9. StreamBuilder (live ticking seconds timer)
10. Hero animation (todo title transitions into edit page)
11. GestureDetector (double-tap to toggle help panel)
12. CustomPainter (draw circular completion ring)
13. ValueNotifier + ValueListenableBuilder (local reactive counter)
14. ReorderableListView (optional; toggled via UI switch)
15. Custom global error UI via ErrorWidget.builder
16. Responsive design basics (LayoutBuilder, MediaQuery)
17. Accessibility hints (semanticsLabel examples)
18. Key usage clarifications
19. Defensive programming patterns
20. Separation of logic/helpers (utility functions)
21. Explanation of const optimization
22. Comments on performance + rebuild minimization
Enjoy learning! 🚀
================================================================================
*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async'; // For streams / timers / async
import 'dart:math' as math;

/*
--------------------------------------------------------------------------------
GLOBAL ERROR WIDGET OVERRIDE (Shows friendly UI instead of red error box)
--------------------------------------------------------------------------------
This is optional but demonstrates customizing error presentation.
Call placed before runApp or inside main() before widgets binding.
*/
void _configureGlobalErrorWidget() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: Colors.red.shade50,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Oops! A UI error occurred.\n\n${details.exception}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      ),
    );
  };
}

/*
--------------------------------------------------------------------------------
ENUM: Filtering modes for the todo list
--------------------------------------------------------------------------------
Enums define a small set of allowed constant values.
*/
enum TodoFilter { all, active, completed }

/*
--------------------------------------------------------------------------------
EXTENSION METHOD: Add extra functionality to existing types (DateTime)
--------------------------------------------------------------------------------
This does NOT modify DateTime source code, just adds a helper.
*/
extension FriendlyDate on DateTime {
  String friendly() {
    // Basic formatting (YYYY-MM-DD HH:MM). For real apps, use intl package.
    return '${year.toString().padLeft(4, '0')}-'
        '${month.toString().padLeft(2, '0')}-'
        '${day.toString().padLeft(2, '0')} '
        '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}';
  }
}

/*
--------------------------------------------------------------------------------
GENERIC CLASS: Result<T>
--------------------------------------------------------------------------------
Demonstrates generics (like List<T>). Useful for returning success/failure data.
*/
class Result<T> {
  final T? data;
  final Object? error;
  const Result.success(this.data) : error = null;
  const Result.failure(this.error) : data = null;
  bool get isSuccess => error == null;
}

/*
--------------------------------------------------------------------------------
MIXIN: LoggingMixin
--------------------------------------------------------------------------------
A mixin lets you "add" methods/fields to classes that use it.
*/
mixin LoggingMixin {
  void log(String message) {
    debugPrint('[LOG] $message');
  }
}

/*
--------------------------------------------------------------------------------
DATA MODEL: TodoItem
--------------------------------------------------------------------------------
*/
class TodoItem {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime createdAt;

  const TodoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
  });

  TodoItem copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isDone': isDone,
    'createdAt': createdAt.toIso8601String(),
  };

  factory TodoItem.fromJson(Map<String, dynamic> map) {
    return TodoItem(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

/*
--------------------------------------------------------------------------------
APP STATE CONTAINER (InheritedWidget + Stateful hosting)
Now includes:
- darkMode bool + persistence
- current filter (enum)
- reorder toggle
--------------------------------------------------------------------------------
*/
class AppStateContainer extends StatefulWidget {
  final Widget child;
  const AppStateContainer({super.key, required this.child});

  @override
  State<AppStateContainer> createState() => _AppState();
}

class _AppState extends State<AppStateContainer> with LoggingMixin {
  List<TodoItem> _todos = [];
  bool _isLoading = true;
  bool _showHelpPanel = false;
  bool _darkMode = false;
  TodoFilter _currentFilter = TodoFilter.all;
  bool _reorderMode = false; // When true, show ReorderableListView.

  // ValueNotifier demonstration (local ephemeral state, e.g. a counter)
  final ValueNotifier<int> tapCounter = ValueNotifier<int>(0);

  List<TodoItem> get todos => _todos;
  bool get isLoading => _isLoading;
  bool get showHelpPanel => _showHelpPanel;
  bool get darkMode => _darkMode;
  TodoFilter get currentFilter => _currentFilter;
  bool get reorderMode => _reorderMode;

  @override
  void initState() {
    super.initState();
    log('App State init');
    _loadPrefsAndTodos();
  }

  void toggleHelpPanel() {
    setState(() {
      _showHelpPanel = !_showHelpPanel;
    });
  }

  void toggleTheme() {
    setState(() {
      _darkMode = !_darkMode;
    });
    _savePreferences();
  }

  void setFilter(TodoFilter filter) {
    setState(() {
      _currentFilter = filter;
    });
  }

  void toggleReorderMode() {
    setState(() {
      _reorderMode = !_reorderMode;
    });
  }

  void incrementTapCounter() {
    tapCounter.value++;
  }

  void addTodo(TodoItem item) {
    setState(() {
      _todos = [..._todos, item];
    });
    saveTodos();
  }

  void updateTodo(TodoItem updated) {
    setState(() {
      _todos = _todos.map((t) => t.id == updated.id ? updated : t).toList();
    });
    saveTodos();
  }

  void deleteTodo(String id) {
    setState(() {
      _todos = _todos.where((t) => t.id != id).toList();
    });
    saveTodos();
  }

  void toggleDone(String id) {
    setState(() {
      _todos = _todos
          .map((t) => t.id == id ? t.copyWith(isDone: !t.isDone) : t)
          .toList();
    });
    saveTodos();
  }

  void reorderTodos(int oldIndex, int newIndex) {
    setState(() {
      // Standard pattern for ReorderableListView
      if (newIndex > oldIndex) newIndex -= 1;
      final moved = _todos.removeAt(oldIndex);
      _todos.insert(newIndex, moved);
    });
    saveTodos();
  }

  List<TodoItem> filteredTodos() {
    switch (_currentFilter) {
      case TodoFilter.active:
        return _todos.where((t) => !t.isDone).toList();
      case TodoFilter.completed:
        return _todos.where((t) => t.isDone).toList();
      case TodoFilter.all:
      default:
        return _todos;
    }
  }

  Future<void> _loadPrefsAndTodos() async {
    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(milliseconds: 800)); // Simulate delay
      final prefs = await SharedPreferences.getInstance();
      _darkMode = prefs.getBool('darkMode') ?? false;
      final raw = prefs.getString('todos_key');
      if (raw != null) {
        final List decoded = jsonDecode(raw);
        _todos = decoded
            .map((e) => TodoItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        _todos = [
          TodoItem(
            id: '1',
            title: 'Explore Flutter',
            description:
            'Read comments, scroll around, tap buttons, learn concepts.',
            isDone: false,
            createdAt: DateTime.now(),
          ),
          TodoItem(
            id: '2',
            title: 'Toggle Theme',
            description: 'Use the moon/sun icon to switch dark/light mode.',
            isDone: false,
            createdAt: DateTime.now(),
          ),
        ];
      }
    } catch (e) {
      log('Error loading: $e');
      _todos = [];
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> saveTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'todos_key',
        jsonEncode(_todos.map((t) => t.toJson()).toList()),
      );
    } catch (e) {
      log('Save error: $e');
    }
  }

  Future<void> _savePreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('darkMode', _darkMode);
    } catch (e) {
      log('Pref save error: $e');
    }
  }

  @override
  void dispose() {
    tapCounter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(appState: this, child: widget.child);
  }
}

class AppStateScope extends InheritedWidget {
  final _AppState appState;
  const AppStateScope({
    super.key,
    required this.appState,
    required Widget child,
  }) : super(child: child);

  static _AppState of(BuildContext context) {
    final scope =
    context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    return scope!.appState;
  }

  @override
  bool updateShouldNotify(covariant AppStateScope oldWidget) {
    // Basic approach — always notify if reference differs.
    return oldWidget.appState != appState;
  }
}

/*
--------------------------------------------------------------------------------
MAIN ENTRY
--------------------------------------------------------------------------------
*/
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _configureGlobalErrorWidget();
  runApp(const AppStateContainer(child: MyApp()));
}

/*
--------------------------------------------------------------------------------
ROOT MyApp with ThemeMode switching
--------------------------------------------------------------------------------
*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enhanced Flutter Tutorial',
      themeMode: appState.darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/about': (_) => const AboutScreen(),
      },
    );
  }
}

/*
--------------------------------------------------------------------------------
HOME SCREEN with explicit animation (rotating help icon)
--------------------------------------------------------------------------------
*/
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  late final List<Widget> _tabs;

  // AnimationController for explicit animation (rotating icon)
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _tabs = const [TodoParentView(), StatsScreen()];
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); // Continuous rotation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    return GestureDetector(
      // Double-tap anywhere on Scaffold background to toggle help panel.
      onDoubleTap: () => appState.toggleHelpPanel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Enhanced Tutorial App'),
          actions: [
            // Theme toggle
            IconButton(
              tooltip: 'Toggle Dark/Light Theme',
              onPressed: appState.toggleTheme,
              icon: Icon(appState.darkMode
                  ? Icons.light_mode
                  : Icons.dark_mode),
            ),
            // Rotating help icon (explicit animation)
            RotationTransition(
              turns: _controller,
              child: IconButton(
                tooltip: 'Rotate Help Toggle',
                onPressed: appState.toggleHelpPanel,
                icon: const Icon(Icons.help_outline),
              ),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: appState.showHelpPanel
                  ? Container(
                key: const ValueKey('help'),
                color: Colors.amber.withOpacity(0.2),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'HELP PANEL: Double-tap background or press rotating ? icon to hide.\n'
                      'Reorder tasks, filter them, view stats, open About screen.\n'
                      'This panel uses AnimatedSwitcher (implicit animation).',
                  style: TextStyle(fontSize: 13),
                ),
              )
                  : const SizedBox(key: ValueKey('nohelp')),
            ),
            Expanded(child: _tabs[_tabIndex]),
          ],
        ),
        floatingActionButton: _tabIndex == 0
            ? FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddEditTodoScreen(),
              ),
            );
          },
          child: const Icon(Icons.add),
        )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tabIndex,
          onTap: (i) => setState(() => _tabIndex = i),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Todos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Stats',
            ),
          ],
        ),
      ),
    );
  }
}

/*
--------------------------------------------------------------------------------
DRAWER
--------------------------------------------------------------------------------
*/
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Menu\nTheme: ${appState.darkMode ? "Dark" : "Light"}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }
}

/*
--------------------------------------------------------------------------------
PARENT VIEW FOR TODO LIST + FILTER BAR + REORDER SWITCH
Separated from list to minimize rebuilds and demonstrate composition.
--------------------------------------------------------------------------------
*/
class TodoParentView extends StatelessWidget {
  const TodoParentView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return Column(
      children: [
        // Filter + reorder row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text('Filter:'),
              FilterChip(
                label: const Text('All'),
                selected: appState.currentFilter == TodoFilter.all,
                onSelected: (_) => appState.setFilter(TodoFilter.all),
              ),
              FilterChip(
                label: const Text('Active'),
                selected: appState.currentFilter == TodoFilter.active,
                onSelected: (_) => appState.setFilter(TodoFilter.active),
              ),
              FilterChip(
                label: const Text('Completed'),
                selected: appState.currentFilter == TodoFilter.completed,
                onSelected: (_) =>
                    appState.setFilter(TodoFilter.completed),
              ),
              const SizedBox(width: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Reorder'),
                  Switch(
                    value: appState.reorderMode,
                    onChanged: (_) => appState.toggleReorderMode(),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(child: TodoListScreen()),
      ],
    );
  }
}

/*
--------------------------------------------------------------------------------
TODO LIST SCREEN
Now supports:
- filtering
- optional ReorderableListView
- Hero animation
- Responsive layout using LayoutBuilder
--------------------------------------------------------------------------------
*/
class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    if (appState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final todos = appState.filteredTodos();

    // Responsive: Use LayoutBuilder to decide layout behavior.
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        Widget listChild;

        if (appState.reorderMode) {
          // ReorderableListView only when reorderMode true
          listChild = ReorderableListView(
            padding: const EdgeInsets.only(bottom: 80),
            onReorder: appState.reorderTodos,
            children: [
              for (final todo in todos)
                _TodoTile(
                  key: ValueKey('reorder_${todo.id}'),
                  todo: todo,
                  allowDragIcon: true,
                ),
            ],
          );
        } else {
          listChild = ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Dismissible(
                key: ValueKey(todo.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => appState.deleteTodo(todo.id),
                child: _TodoTile(todo: todo),
              );
            },
          );
        }

        // Show side-by-side with a mini stats ring if wide
        return Row(
          children: [
            Expanded(flex: 3, child: listChild),
            if (isWide)
              Expanded(
                flex: 2,
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceVariant
                      .withOpacity(0.3),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CompletionRingWidget(),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/*
--------------------------------------------------------------------------------
SINGLE TODO TILE (extracted for clarity + to reduce parent rebuild)
--------------------------------------------------------------------------------
*/
class _TodoTile extends StatelessWidget {
  final TodoItem todo;
  final bool allowDragIcon;
  const _TodoTile({super.key, required this.todo, this.allowDragIcon = false});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return ListTile(
      leading: allowDragIcon
          ? const Icon(Icons.drag_handle)
          : Checkbox(
        value: todo.isDone,
        onChanged: (_) => appState.toggleDone(todo.id),
      ),
      title: Hero(
        // Hero animation: unique tag links two screens
        tag: 'hero_title_${todo.id}',
        child: Material(
          type: MaterialType.transparency,
          child: Text(
            todo.title,
            semanticsLabel:
            'Task title: ${todo.title} ${todo.isDone ? "completed" : "not completed"}',
            style: TextStyle(
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      subtitle: Text(
        '${todo.description}\nCreated: ${todo.createdAt.friendly()}',
        style: const TextStyle(fontSize: 12),
      ),
      isThreeLine: true,
      trailing: !allowDragIcon
          ? IconButton(
        tooltip: 'Delete',
        onPressed: () => appState.deleteTodo(todo.id),
        icon: const Icon(Icons.delete_outline),
      )
          : null,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddEditTodoScreen(existing: todo),
          ),
        );
      },
    );
  }
}

/*
--------------------------------------------------------------------------------
CUSTOM PAINTER: Draw completion percentage ring
--------------------------------------------------------------------------------
*/
class CompletionRingWidget extends StatelessWidget {
  const CompletionRingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final total = appState.todos.length;
    final done = appState.todos.where((t) => t.isDone).length;
    final ratio = total == 0 ? 0.0 : done / total;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Progress Ring', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        SizedBox(
          width: 140,
          height: 140,
          child: CustomPaint(
            painter: _RingPainter(ratio: ratio),
            child: Center(
              child: Text(
                '${(ratio * 100).toStringAsFixed(1)}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Text('$done of $total completed'),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  final double ratio;
  _RingPainter({required this.ratio});
  @override
  void paint(Canvas canvas, Size size) {
    final stroke = 12.0;
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (math.min(size.width, size.height) / 2) - stroke;

    final bgPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.deepPurple, Colors.blue],
      ).createShader(rect)
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Background circle
    canvas.drawCircle(center, radius, bgPaint);

    // Foreground arc
    final sweep = 2 * math.pi * ratio;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start at top
      sweep,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.ratio != ratio;
  }
}

/*
--------------------------------------------------------------------------------
STATS SCREEN
Added:
- FutureBuilder (async tip)
- StreamBuilder (live seconds)
- ValueListenableBuilder (tap counter)
- CustomPainter used above (completion ring)
--------------------------------------------------------------------------------
*/
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  // Simulate fetching a motivational tip (returns Future<String>)
  Future<String> _fetchTip() async {
    await Future.delayed(const Duration(seconds: 1));
    final tips = [
      'Stay consistent.',
      'Small steps matter.',
      'Refactor when needed.',
      'Readable code wins.',
      'Test your logic.',
    ];
    tips.shuffle();
    return tips.first;
  }

  // Provide a simple ticking stream
  Stream<int> _secondTicker() {
    return Stream.periodic(const Duration(seconds: 1), (count) => count);
  }

  String categorize(int total, int done) {
    final percent = total == 0 ? 0 : (done / total) * 100;
    switch (percent ~/ 10) {
      case 10:
      case 9:
        return 'Legendary 🔥';
      case 8:
      case 7:
        return 'Excellent 💪';
      case 6:
      case 5:
        return 'Solid 👍';
      case 4:
      case 3:
        return 'Keep pushing 😊';
      default:
        return 'Just starting 🐣';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final todos = appState.todos;
    final doneCount = todos.where((t) => t.isDone).length;
    final remaining = todos.length - doneCount;

    // Use generic Result<T> pattern for a trivial example:
    final Result<double> avgTitleLengthResult = todos.isEmpty
        ? const Result.failure('No todos yet')
        : Result.success(
      todos.map((t) => t.title.length).reduce((a, b) => a + b) /
          todos.length,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CompletionRingWidget(),
          const SizedBox(height: 16),
          Text('Total: ${todos.length}  |  Done: $doneCount  |  Remaining: $remaining'),
          Text('Category: ${categorize(todos.length, doneCount)}'),
          const SizedBox(height: 12),
          Text(
            avgTitleLengthResult.isSuccess
                ? 'Avg title length: ${avgTitleLengthResult.data!.toStringAsFixed(1)}'
                : 'Avg title length: (no data)',
          ),
          const Divider(),
          // FUTUREBUILDER
          FutureBuilder<String>(
            future: _fetchTip(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading a motivational tip...');
              } else if (snapshot.hasError) {
                return Text('Tip error: ${snapshot.error}');
              } else {
                return Text('Tip: ${snapshot.data}');
              }
            },
          ),
          const SizedBox(height: 12),
          // STREAMBUILDER
          StreamBuilder<int>(
            stream: _secondTicker(),
            builder: (context, snapshot) {
              final seconds = snapshot.data ?? 0;
              return Text('Seconds since you opened this page: $seconds');
            },
          ),
          const SizedBox(height: 12),
          // VALUE LISTENABLE BUILDER (tap counter)
          ValueListenableBuilder<int>(
            valueListenable: appState.tapCounter,
            builder: (context, value, _) {
              return Text(
                'Tap counter (updates reactively via ValueNotifier): $value',
              );
            },
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: appState.incrementTapCounter,
            child: const Text('Increment Tap Counter'),
          ),
          const Divider(),
          const Text(
            'Concepts used here:\n'
                '- FutureBuilder (async one-off future)\n'
                '- StreamBuilder (continuous time stream)\n'
                '- ValueNotifier + ValueListenableBuilder\n'
                '- Generics (Result<T>)\n'
                '- CustomPainter (Progress ring)\n'
                '- Extension method (Date formatting on todo list)\n'
                '- Enum-based filtering on main list',
          ),
        ],
      ),
    );
  }
}

/*
--------------------------------------------------------------------------------
ADD / EDIT TODO SCREEN
Adds:
- Hero animation for title
- AnimatedOpacity transition on save button state
--------------------------------------------------------------------------------
*/
class AddEditTodoScreen extends StatefulWidget {
  final TodoItem? existing;
  const AddEditTodoScreen({super.key, this.existing});

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.existing?.title ?? '');
    _descCtrl = TextEditingController(text: widget.existing?.description ?? '');
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await Future.delayed(const Duration(milliseconds: 800));

    final appState = AppStateScope.of(context);
    if (widget.existing == null) {
      appState.addTodo(
        TodoItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleCtrl.text.trim(),
          description: _descCtrl.text.trim(),
          isDone: false,
          createdAt: DateTime.now(),
        ),
      );
    } else {
      appState.updateTodo(
        widget.existing!.copyWith(
          title: _titleCtrl.text.trim(),
          description: _descCtrl.text.trim(),
        ),
      );
    }
    setState(() => _saving = false);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.existing != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Edit Task' : 'Add Task'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Hero(
              tag: widget.existing == null
                  ? 'new_hero_placeholder'
                  : 'hero_title_${widget.existing!.id}',
              child: Material(
                type: MaterialType.transparency,
                child: TextFormField(
                  controller: _titleCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter a title' : null,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              minLines: 2,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: _saving ? 0.4 : 1,
              child: ElevatedButton.icon(
                onPressed: _saving ? null : _save,
                icon: const Icon(Icons.save),
                label: Text(editing ? 'Save Changes' : 'Add Task'),
              ),
            ),
            if (_saving)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: LinearProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

/*
--------------------------------------------------------------------------------
ABOUT SCREEN
--------------------------------------------------------------------------------
*/
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  String longExplanation() {
    return 'This single-file project demonstrates a wide spectrum of Flutter and '
        'Dart concepts with comments. Explore each widget, learn state management, '
        'animations, async patterns, theming, and more.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('About This App', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(longExplanation()),
          const SizedBox(height: 20),
          const Text(
            'Key Concepts Recap (Extended):\n'
                '- Widgets: Stateless, Stateful, Custom\n'
                '- InheritedWidget for shared app state\n'
                '- setState & rebuilds\n'
                '- Theme + Dark/Light mode persistence\n'
                '- Enums, Extensions, Mixins, Generics\n'
                '- Forms, Validation, Controllers\n'
                '- ListView, ReorderableListView, Dismissible\n'
                '- Grid, Responsive Layout (LayoutBuilder)\n'
                '- Navigation (push, pop, named)\n'
                '- Hero animation, Implicit & Explicit animations\n'
                '- FutureBuilder, StreamBuilder, ValueListenableBuilder\n'
                '- Async/await, try/catch, local persistence\n'
                '- CustomPainter (progress ring)\n'
                '- GestureDetector (double tap)\n'
                '- Keys & Hero tags\n'
                '- ErrorWidget customization\n'
                '- Performance notes (const, minimal rebuilds)',
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}

/*
================================================================================
HOW THE APP RUNS (UPDATED SUMMARY)
================================================================================
1. main() -> sets up global ErrorWidget override -> runApp(AppStateContainer(MyApp()))
2. AppStateContainer creates _AppState which loads stored preferences + todos.
3. _AppState exposes shared data (todos, theme, filter, reorderMode, etc.) via InheritedWidget (AppStateScope).
4. MyApp reads darkMode to set themeMode.
5. HomeScreen shows tabs (todos / stats) + rotating help icon + gesture double-tap.
6. TodoParentView shows filter chips + reorder switch + TodoListScreen.
7. TodoListScreen:
   - If reorder mode -> ReorderableListView
   - Else -> ListView with Dismissible + Hero titles
   - Uses LayoutBuilder for responsive wide layout (shows Progress ring).
8. Add/Edit screen uses Form + Hero + AnimatedOpacity + validation + async save.
9. StatsScreen shows:
   - FutureBuilder (tip)
   - StreamBuilder (seconds ticker)
   - ValueListenableBuilder (tap counter)
   - Completion ring (CustomPainter)
10. Theme toggle persists using SharedPreferences.
11. Enum filters refine displayed list.
12. Extension formats DateTime for display.
13. Mixin provides logging.
14. All changes trigger setState in _AppState -> UI rebuild appropriately.

End of File.
================================================================================
*/