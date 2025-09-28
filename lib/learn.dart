// ===== SECTION 1: DART BASICS =====
// This section teaches you the basics of the Dart language (Flutter's programming language)
//
// import 'package:flutter/material.dart'; // This line brings in Flutter's tools
//
// void main() {
//   // This is the starting point of our app
//   runApp(const MyApp()); // This tells Flutter to start our app
// }
//
// // This is our main app widget
// class MyApp extends StatelessWidget {
//   // This is how we create a new MyApp
//   const MyApp({super.key});
//
//   @override // This tells Dart we're replacing the original build method
//   Widget build(BuildContext context) {
//     // The build method returns what we want to show on screen
//
//     // DART BASICS - Let's learn inside the build method!
//
//     // 1. VARIABLES - Containers that hold values
//     // Technical: Variables store data in memory with a specific type
//     // Kid-friendly: Variables are like labeled boxes where you keep your toys
//
//     String name = "Flutter Beginner"; // Text variable (letters, words)
//     int age = 12; // Whole number variable (no decimals)
//     double height = 4.9; // Decimal number variable
//     bool isLearning = true; // True/false variable
//
//     // We can change variable values
//     age = 13; // Changed from 12 to 13
//
//     // 2. PRINTING TO CONSOLE - Useful for debugging
//     print("Hello, my name is $name"); // $ sign lets us put variables in text
//     print("I am $age years old and $height feet tall");
//     print("Am I learning Flutter? $isLearning");
//
//     // 3. LISTS - Collections of items
//     // Technical: Lists store multiple values in an ordered, indexed collection
//     // Kid-friendly: Lists are like toy boxes with numbered spots for toys
//     List<String> fruits = ["Apple", "Banana", "Cherry"];
//     print("My favorite fruit is ${fruits[0]}"); // Lists start counting at 0
//
//     // Adding to a list
//     fruits.add("Dragon fruit");
//     print("All fruits: $fruits");
//
//     // 4. MAPS - Collections of key-value pairs
//     // Technical: Maps store key-value pairs for quick lookups
//     // Kid-friendly: Maps are like a school locker - each has a number and contents
//     Map<String, String> countries = {
//       "USA": "Washington D.C.",
//       "India": "New Delhi",
//       "Japan": "Tokyo",
//     };
//     print("The capital of Japan is ${countries['Japan']}");
//
//     // 5. FUNCTIONS - Reusable blocks of code
//     // Technical: Functions encapsulate logic for reuse
//     // Kid-friendly: Functions are like recipes - follow steps to make something
//
//     // Simple function that adds two numbers
//     int addNumbers(int a, int b) {
//       return a + b;
//     }
//
//     int sum = addNumbers(5, 3);
//     print("5 + 3 = $sum");
//
//     // Function with optional parameter
//     String greet(String person, [String? message]) {
//       if (message != null) {
//         return "Hello $person, $message";
//       }
//       return "Hello $person";
//     }
//
//     print(greet("Flutter Student"));
//     print(greet("Flutter Student", "keep learning!"));
//
//     // 6. CONDITIONAL STATEMENTS - Making decisions
//     // Technical: Control flow structures that execute code based on conditions
//     // Kid-friendly: Like choosing which path to take in a garden
//
//     int score = 85;
//
//     if (score >= 90) {
//       print("Excellent job!");
//     } else if (score >= 80) {
//       print("Good work!"); // This will print
//     } else {
//       print("Keep practicing!");
//     }
//
//     // 7. LOOPS - Repeating code
//     // Technical: Control structures that repeat code execution
//     // Kid-friendly: Like walking around a track multiple times
//
//     // For loop
//     print("Counting from 1 to 5:");
//     for (int i = 1; i <= 5; i++) {
//       print(i);
//     }
//
//     // For-each loop with lists
//     print("Fruits one by one:");
//     for (String fruit in fruits) {
//       print(fruit);
//     }
//
//     // While loop
//     print("Countdown:");
//     int countdown = 3;
//     while (countdown > 0) {
//       print(countdown);
//       countdown--;
//     }
//
//     // 8. CLASSES - Blueprints for objects
//     // Technical: Templates that define properties and behaviors of objects
//     // Kid-friendly: Like a blueprint for building identical toys
//
//     // We'll create a simple Person class
//     // (This would normally go outside the build method, but we're learning!)
//     class Person {
//     String name;
//     int age;
//
//     // Constructor - how we create a new Person
//     Person(this.name, this.age);
//
//     // Method - something a Person can do
//     String introduce() {
//     return "Hi, I'm $name and I'm $age years old.";
//     }
//     }
//
//     // Creating objects from our class
//     Person student = Person("Alex", 12);
//     print(student.introduce());
//
//     Person teacher = Person("Ms. Flutter", 30);
//     print(teacher.introduce());
//
//     // 9. ASYNC/AWAIT - Handling operations that take time
//     // Technical: Mechanisms for handling asynchronous operations
//     // Kid-friendly: Like ordering food and doing other things while waiting
//
//     // This function simulates a delay (like loading data)
//     Future<String> fetchData() async {
//     // await makes the function pause until the Future completes
//     await Future.delayed(const Duration(seconds: 2));
//     return "Data loaded!";
//     }
//
//     // We need to call this differently, we'll just show the syntax
//     // (In real code, we'd use FutureBuilder or other async patterns)
//     print("Starting to fetch data...");
//     // fetchData().then((result) => print(result));
//     print("Waiting for data... (we'd see 'Data loaded!' after 2 seconds)");
//
//     // Now that we've learned Dart basics, let's return our actual Flutter app
//     return MaterialApp(
//     title: 'Flutter Demo',
//     theme: ThemeData(
//     primarySwatch: Colors.blue,
//     ),
//     home: Scaffold(
//     appBar: AppBar(
//     title: const Text('Dart Basics'),
//     ),
//     body: Center(
//     child: Text(
//     'Hello, $name!\nYou\'re learning Dart!',
//     style: const TextStyle(fontSize: 24),
//     textAlign: TextAlign.center,
//     ),
//     ),
//     ),
//     );
//   }
// }

/*
// ===== SECTION 2: FLUTTER BASICS =====
// This section teaches you the fundamentals of Flutter widgets and structure

import 'package:flutter/material.dart'; // Import Flutter's material design package

// main function is the entry point for all Flutter apps
void main() {
  // runApp takes the root widget of your app and makes it take over the screen
  runApp(const MyApp());
  // Think of runApp like planting a seed that will grow into your app!
}

// StatelessWidget - A widget that doesn't change its appearance based on internal data
// Technical: A widget that never rebuilds itself except when external data changes
// Kid-friendly: Like a photo - once taken, it doesn't change by itself
class MyApp extends StatelessWidget {
  // Constructor - how we create a new MyApp
  const MyApp({super.key});

  // The build method describes what the widget looks like
  // It's like a recipe that tells Flutter how to create your widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp is a pre-made widget that sets up a lot for us
      // It's like getting a starter pack for making an app
      title: 'Flutter Demo', // Name of our app (shows in task switcher)
      theme: ThemeData(
        // Sets the color and style defaults for our app
        primarySwatch: Colors.blue, // Main color to use
        useMaterial3: true, // Use the newest Material design
      ),
      home: const MyHomePage(title: 'Flutter Basics'), // First screen we see
    );
  }
}

// StatefulWidget - A widget that can change its appearance based on user interaction
// Technical: A widget that can rebuild itself when internal state changes
// Kid-friendly: Like an interactive toy that changes when you play with it
class MyHomePage extends StatefulWidget {
  // Constructor requires a title
  const MyHomePage({super.key, required this.title});

  final String title; // Stores the title text

  @override
  // Creates the mutable state for this widget
  // Think of this as creating the "brains" for our interactive widget
  State<MyHomePage> createState() => _MyHomePageState();
}

// The State class - this holds all the changing data
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // This variable can change while the app runs

  // This function increases our counter
  void _incrementCounter() {
    // setState tells Flutter "something changed, please update the screen"
    // It's like saying "look at me, I've changed!"
    setState(() {
      _counter++; // Increase the counter by 1
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic material design visual structure
    // It's like the walls, floor and ceiling of a room
    return Scaffold(
      appBar: AppBar(
        // AppBar is the top bar of our app
        // It's like the sign above a store
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title), // Shows our title
      ),
      body: Center(
        // Center puts its child in the middle of the screen
        child: Column(
          // Column arranges its children in a vertical line
          // It's like stacking blocks one on top of another
          mainAxisAlignment: MainAxisAlignment.center, // Vertical center alignment
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter', // Shows our counter value
              style: Theme.of(context).textTheme.headlineMedium, // Makes the text big
            ),
            const SizedBox(height: 20), // Adds some space
            const Text(
              'Widget Tree Explanation:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Flutter uses a "Widget Tree" to build UIs. Each widget can contain child widgets, '
                'creating a tree structure. In this app, MaterialApp contains a Scaffold, which '
                'contains an AppBar and a body with Center, Column, and Text widgets.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // This is the button in the bottom corner
        onPressed: _incrementCounter, // What happens when pressed
        tooltip: 'Increment', // Text that appears on long press
        child: const Icon(Icons.add), // The + symbol
      ),
    );
  }
}

// ===== SECTION 3: LAYOUTS =====
// This section teaches you how to arrange widgets on the screen

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layouts',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: const LayoutsDemo(),
    );
  }
}

class LayoutsDemo extends StatefulWidget {
  const LayoutsDemo({super.key});

  @override
  State<LayoutsDemo> createState() => _LayoutsDemoState();
}

class _LayoutsDemoState extends State<LayoutsDemo> {
  // Current layout example to show (we'll switch between them)
  String _currentLayout = 'Container';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Layouts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Dropdown to select different layout examples
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _currentLayout,
              onChanged: (String? newValue) {
                // Update the state when we select a new layout
                if (newValue != null) {
                  setState(() {
                    _currentLayout = newValue;
                  });
                }
              },
              items: <String>[
                'Container',
                'Row & Column',
                'Stack',
                'Expanded',
                'ListView',
                'GridView',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),

          // Explanation text for current layout
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _getExplanation(),
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Divider line
          const Divider(thickness: 2),

          // The layout example we selected shows here
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildCurrentLayout(),
            ),
          ),
        ],
      ),
    );
  }

  // Returns a kid-friendly explanation for each layout
  String _getExplanation() {
    switch (_currentLayout) {
      case 'Container':
        return 'Container is like a box for holding other widgets. '
               'You can color it, size it, and put things inside!';
      case 'Row & Column':
        return 'Row puts widgets side by side (horizontally). '
               'Column stacks widgets on top of each other (vertically). '
               'Like arranging toys in a line or stacking blocks!';
      case 'Stack':
        return 'Stack lets you place widgets on top of each other, like '
               'placing stickers on paper - some cover others!';
      case 'Expanded':
        return 'Expanded makes a widget stretch to fill available space. '
               'Like pouring water into different sized cups - it fills whatever space it has!';
      case 'ListView':
        return 'ListView is for scrollable lists. Like a long scroll of paper '
               'with items written on it that you can scroll through!';
      case 'GridView':
        return 'GridView arranges widgets in a grid (rows and columns). '
               'Like arranging photos in a photo album or a calendar!';
      default:
        return '';
    }
  }

  // Builds the selected layout example
  Widget _buildCurrentLayout() {
    switch (_currentLayout) {
      case 'Container':
        return _buildContainerExample();
      case 'Row & Column':
        return _buildRowColumnExample();
      case 'Stack':
        return _buildStackExample();
      case 'Expanded':
        return _buildExpandedExample();
      case 'ListView':
        return _buildListViewExample();
      case 'GridView':
        return _buildGridViewExample();
      default:
        return const Center(child: Text('Select a layout'));
    }
  }

  // 1. CONTAINER EXAMPLE
  Widget _buildContainerExample() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // A simple container with color and padding
          Container(
            // Width and height set the size
            width: 200,
            height: 200,
            // Padding adds space inside the container
            padding: const EdgeInsets.all(20),
            // Decoration defines how the container looks
            decoration: BoxDecoration(
              color: Colors.blue,  // Background color
              borderRadius: BorderRadius.circular(15), // Rounded corners
              boxShadow: [  // Shadow effect
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            // Child is what goes inside the container
            child: const Center(
              child: Text(
                'This is a Container',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          const SizedBox(height: 30),  // Adds space vertically

          // Another container with different styling
          Container(
            width: 250,
            height: 100,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.purple, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Containers can have different sizes, colors, and borders',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 2. ROW & COLUMN EXAMPLE
  Widget _buildRowColumnExample() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First, let's show a Row
          const Text('Row Example (horizontal):'),
          const SizedBox(height: 10),

          // Row puts widgets side by side horizontally
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly spaces children
              children: [
                _buildColorSquare(Colors.red, 'Red'),
                _buildColorSquare(Colors.green, 'Green'),
                _buildColorSquare(Colors.blue, 'Blue'),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Now, let's show a Column
          const Text('Column Example (vertical):'),
          const SizedBox(height: 10),

          // Column stacks widgets vertically (on top of each other)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centers children vertically
              mainAxisSize: MainAxisSize.min, // Takes minimum space needed
              children: [
                _buildColorSquare(Colors.orange, 'Orange'),
                const SizedBox(height: 10), // Adds space between items
                _buildColorSquare(Colors.purple, 'Purple'),
                const SizedBox(height: 10),
                _buildColorSquare(Colors.teal, 'Teal'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Combining Row and Column
          const Text('Combining Row and Column:'),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // First column
              Column(
                children: [
                  _buildColorSquare(Colors.pink, 'Pink', size: 40),
                  const SizedBox(height: 10),
                  _buildColorSquare(Colors.indigo, 'Indigo', size: 40),
                ],
              ),

              // Second column
              Column(
                children: [
                  _buildColorSquare(Colors.amber, 'Amber', size: 40),
                  const SizedBox(height: 10),
                  _buildColorSquare(Colors.brown, 'Brown', size: 40),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper function to create colored squares for examples
  Widget _buildColorSquare(Color color, String text, {double size = 60}) {
    return Container(
      width: size,
      height: size,
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // 3. STACK EXAMPLE
  Widget _buildStackExample() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Stack places widgets on top of each other:'),
          const SizedBox(height: 20),

          // A Stack with positioned children
          SizedBox(
            width: 300,
            height: 300,
            child: Stack(
              // The first child is at the bottom, the last is on top
              children: [
                // Background
                Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                // Middle item - positioned relative to Stack boundaries
                Positioned(
                  left: 20,
                  top: 20,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Middle Layer',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                // Top item - another positioned element
                Positioned(
                  right: 40,
                  bottom: 40,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle, // Makes it a circle
                    ),
                    child: const Center(
                      child: Text(
                        'Top Layer',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                // Text on the very top
                const Positioned(
                  bottom: 15,
                  left: 15,
                  child: Text(
                    'Stack is perfect for overlapping elements!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Example of how stack can be used
          const Text('Common uses: profile pictures with badges, cards with labels, etc.'),
          const SizedBox(height: 10),

          // Simple profile picture with notification badge
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              children: [
                // Profile picture
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Icon(Icons.person, size: 60),
                  ),
                ),

                // Notification badge
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. EXPANDED EXAMPLE
  Widget _buildExpandedExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Expanded makes widgets take available space:'),
        const SizedBox(height: 20),

        // Example 1: Equal distribution with Expanded
        const Text('Example 1: Three equal parts'),
        const SizedBox(height: 10),
        Expanded(
          flex: 1, // This Expanded takes 1 part of the remaining space
          child: Row(
            children: [
              // Each Expanded gets 1/3 of the row's width
              Expanded(
                child: Container(color: Colors.red, child: const Center(child: Text('1'))),
              ),
              Expanded(
                child: Container(color: Colors.green, child: const Center(child: Text('1'))),
              ),
              Expanded(
                child: Container(color: Colors.blue, child: const Center(child: Text('1'))),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Example 2: Unequal distribution with flex
        const Text('Example 2: Different flex values'),
        const SizedBox(height: 10),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              // This takes 1 part (1/6 of the row)
              Expanded(
                flex: 1,
                child: Container(color: Colors.purple, child: const Center(child: Text('1'))),
              ),
              // This takes 2 parts (2/6 of the row)
              Expanded(
                flex: 2,
                child: Container(color: Colors.orange, child: const Center(child: Text('2'))),
              ),
              // This takes 3 parts (3/6 of the row)
              Expanded(
                flex: 3,
                child: Container(color: Colors.teal, child: const Center(child: Text('3'))),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Example 3: Combining fixed and expanded widgets
        const Text('Example 3: Fixed and expanded widgets'),
        const SizedBox(height: 10),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              // Fixed width container
              Container(
                width: 100,
                color: Colors.grey,
                child: const Center(child: Text('Fixed\n100px')),
              ),
              // This expands to fill the rest of the space
              Expanded(
                child: Container(color: Colors.amber, child: const Center(child: Text('Expanded'))),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Example 4: Nested Expanded widgets
        const Text('Example 4: Nested Expanded'),
        const SizedBox(height: 10),
        Expanded(
          flex: 2, // This example gets more space
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(color: Colors.pink[100], child: const Center(child: Text('2'))),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(color: Colors.pink[300], child: const Center(child: Text('1'))),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(color: Colors.cyan, child: const Center(child: Text('Column 2'))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 5. LISTVIEW EXAMPLE
  Widget _buildListViewExample() {
    // Create a list of items to display
    final List<Map<String, dynamic>> items = List.generate(
      20,
      (index) => {
        'title': 'Item ${index + 1}',
        'subtitle': 'This is item number ${index + 1}',
        'color': index % 2 == 0 ? Colors.blue[50] : Colors.grey[100],
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'ListView is for scrollable lists of items:',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),

        // Basic ListView
        Expanded(
          child: ListView.builder(
            // ListView.builder is more efficient than ListView because it only
            // builds items when they are visible on screen
            itemCount: items.length, // How many items to build
            itemBuilder: (context, index) {
              // Build each item based on index
              final item = items[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                color: item['color'],
                child: ListTile(
                  leading: CircleAvatar(
                    // Leading is at the start of the ListTile
                    backgroundColor: Colors.blue,
                    child: Text('${index + 1}'),
                  ),
                  title: Text(
                    item['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item['subtitle']),
                  trailing: const Icon(Icons.arrow_forward), // Trailing is at the end
                  onTap: () {
                    // What happens when you tap the item
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You tapped on ${item['title']}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),

        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'ListView.builder only creates items when they become visible, '
            'which is more efficient than creating all items at once.',
            style: TextStyle(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // 6. GRIDVIEW EXAMPLE
  Widget _buildGridViewExample() {
    // Create a list of grid items
    final List<Map<String, dynamic>> gridItems = List.generate(
      20,
      (index) => {
        'number': index + 1,
        'color': Colors.primaries[index % Colors.primaries.length],
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'GridView arranges items in a grid pattern:',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),

        // GridView builder
        Expanded(
          child: GridView.builder(
            // Defines how the grid is structured
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 items per row
              crossAxisSpacing: 10, // Horizontal gap between items
              mainAxisSpacing: 10, // Vertical gap between items
              childAspectRatio: 1, // Width ÷ height ratio of items (1 = square)
            ),
            padding: const EdgeInsets.all(10),
            itemCount: gridItems.length,
            itemBuilder: (context, index) {
              final item = gridItems[index];

              return Container(
                decoration: BoxDecoration(
                  color: item['color'],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '${item['number']}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'GridView is perfect for photo galleries, dashboards, or any UI that needs items arranged in rows and columns.',
            style: TextStyle(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// ===== SECTION 4: UI STYLING =====
// This section teaches you how to style your app with colors, fonts, and themes

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // You may need to add this package to pubspec.yaml

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // We'll use this to toggle between light and dark mode
  bool _isDarkMode = false;

  // Currently selected theme color
  Color _primaryColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Styling Demo',

      // ThemeData is how we set up the styling for our entire app
      // It's like choosing all the colors and fonts for your notebook at once
      theme: _isDarkMode
        ? _buildDarkTheme() // For dark mode
        : _buildLightTheme(), // For light mode

      home: Scaffold(
        appBar: AppBar(
          title: const Text('UI Styling & Themes'),
          actions: [
            // Toggle for dark/light mode
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode; // Toggle the mode
                });
              },
            ),
          ],
        ),
        body: StylingDemo(
          isDarkMode: _isDarkMode,
          onColorChanged: (Color color) {
            setState(() {
              _primaryColor = color; // Update the primary color
            });
          },
          currentPrimaryColor: _primaryColor,
        ),
      ),
    );
  }

  // Helper method to build the light theme
  ThemeData _buildLightTheme() {
    return ThemeData(
      // Material 3 is the newest design system from Google
      useMaterial3: true,

      // Color scheme defines all the colors for our app
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor, // Main color that other colors are based on
        brightness: Brightness.light, // Light mode
      ),

      // Text theme defines text styles throughout the app
      textTheme: TextTheme(
        // Display styles are for large headlines
        displayLarge: GoogleFonts.montserrat(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        // Title styles are for smaller headlines
        titleLarge: GoogleFonts.raleway(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        // Body styles are for regular text
        bodyLarge: GoogleFonts.roboto(fontSize: 16),
        bodyMedium: GoogleFonts.roboto(fontSize: 14),
      ),

      // Card theme applies to all Card widgets
      cardTheme: CardTheme(
        elevation: 4, // Shadow size
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
      ),

      // Button theme applies to all buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // Helper method to build the dark theme
  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: Brightness.dark, // Dark mode
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.raleway(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.roboto(fontSize: 16, color: Colors.white),
        bodyMedium: GoogleFonts.roboto(fontSize: 14, color: Colors.white70),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

// This widget demonstrates various styling options
class StylingDemo extends StatelessWidget {
  final bool isDarkMode;
  final Function(Color) onColorChanged;
  final Color currentPrimaryColor;

  const StylingDemo({
    super.key,
    required this.isDarkMode,
    required this.onColorChanged,
    required this.currentPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    // We get the theme from the context to use its styles
    final theme = Theme.of(context);

    // List of colors the user can choose from
    final colorOptions = [
      Colors.blue,
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.teal,
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title section
          Text(
            'UI Styling in Flutter',
            style: theme.textTheme.displayLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Learn how to make your app beautiful!',
            style: theme.textTheme.titleLarge,
          ),
          const Divider(height: 32),

          // Theme colors section
          Text(
            '1. Theme Colors',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildColorPalette(context),
          const SizedBox(height: 16),

          // Color picker section
          Text(
            'Change Primary Color:',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: colorOptions.map((color) {
              return InkWell(
                onTap: () => onColorChanged(color),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: color,
                  child: currentPrimaryColor == color
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              );
            }).toList(),
          ),
          const Divider(height: 32),

          // Typography section
          Text(
            '2. Typography',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Display Large', style: theme.textTheme.displayLarge),
                  const SizedBox(height: 8),
                  Text('Display Medium', style: theme.textTheme.displayMedium),
                  const SizedBox(height: 8),
                  Text('Display Small', style: theme.textTheme.displaySmall),
                  const SizedBox(height: 16),
                  Text('Headline Large', style: theme.textTheme.headlineLarge),
                  const SizedBox(height: 8),
                  Text('Headline Medium', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  Text('Title Large', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('Title Medium', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 16),
                  Text('Body Large', style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Text('Body Medium', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ),
          const Divider(height: 32),

          // Components styling section
          Text(
            '3. Component Styling',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildComponentsShowcase(context),
        ],
      ),
    );
  }

  // Shows the theme's color palette
  Widget _buildColorPalette(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _colorRow('Primary', colorScheme.primary),
            _colorRow('Secondary', colorScheme.secondary),
            _colorRow('Tertiary', colorScheme.tertiary),
            _colorRow('Error', colorScheme.error),
            _colorRow('Background', colorScheme.background),
            _colorRow('Surface', colorScheme.surface),
          ],
        ),
      ),
    );
  }

  // Helper to create a color row
  Widget _colorRow(String name, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            // Converting color to hex code
            '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
            style: TextStyle(
              fontFamily: 'monospace',
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // Shows different styled components
  Widget _buildComponentsShowcase(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Buttons:'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated'),
                ),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Filled'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Text Button'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text('Input Fields:'),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: const Icon(Icons.visibility),
              ),
            ),
            const SizedBox(height: 16),

            const Text('Cards:'),
            const SizedBox(height: 8),
            Card(
              color: isDarkMode ? Colors.grey[800] : Colors.blue[50],
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Styled Card',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Cards can be styled with different colors, borders, and shadows to create visual hierarchy.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== SECTION 5: NAVIGATION =====
// This section teaches you how to navigate between screens

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      // Named routes let us navigate to screens using names instead of pushing new screens
      // It's like having a map with named locations
      routes: {
        '/': (context) => const NavigationHome(), // Default route
        '/details': (context) => const DetailScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/notifications': (context) => const NotificationsScreen(),
      },
      initialRoute: '/', // Where our app starts
    );
  }
}

class NavigationHome extends StatefulWidget {
  const NavigationHome({super.key});

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  // Current index for bottom navigation
  int _currentIndex = 0;

  // List of pages to show based on bottom navigation
  final List<Widget> _pages = [
    const HomeContent(),
    const SearchContent(),
    const LibraryContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Demo'),
        // Actions are buttons in the app bar
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      // Drawer is a side menu that slides in from the left or right
      // It's like a hidden closet with options
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.indigo),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Flutter Student',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'student@flutter.example',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // List of drawer menu items
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer first
                Navigator.pushNamed(context, '/profile'); // Then navigate
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                // Show a dialog box
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('About Navigation Demo'),
                    content: const Text('This is a demonstration of different navigation techniques in Flutter.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // This shows the current page based on the bottom navigation selection
      body: _pages[_currentIndex],
      // Bottom navigation bar for switching between main sections
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Which tab is selected
        onTap: (index) {
          // Update the state when a new tab is tapped
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBar.item(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBar.item(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBar.item(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}

// Home tab content
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Home Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            'This demo shows different ways to navigate:',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• Push/pop navigation'),
                Text('• Named routes'),
                Text('• Bottom navigation bar'),
                Text('• Drawer navigation'),
                Text('• Tab navigation'),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Push navigation - adds a new screen on top of the current one
              // Like adding a new book on top of a stack of books
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailScreen(),
                ),
              );
            },
            child: const Text('Go to Detail Screen'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              // Navigate using named route
              // Like telling a taxi driver "take me to the museum" instead of giving directions
              Navigator.pushNamed(context, '/details');
            },
            child: const Text('Go to Detail (Named Route)'),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // Navigator.pushReplacement replaces the current screen
              // Like swapping one book for another in your stack
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            child: const Text('Replace with Settings Screen'),
          ),
        ],
      ),
    );
  }
}

// Search tab content
class SearchContent extends StatefulWidget {
  const SearchContent({super.key});

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> with SingleTickerProviderStateMixin {
  // Tab controller for the search section tabs
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the tab controller with 3 tabs
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TabBar creates the tab buttons at the top
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Recent'),
            Tab(text: 'Popular'),
            Tab(text: 'Favorites'),
          ],
        ),
        // TabBarView shows content for each tab
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Content for Recent tab
              _buildTabContent(
                'Recent Searches',
                Icons.history,
                Colors.blue,
                ['Flutter tutorial', 'Navigation example', 'Tab bar demo'],
              ),
              // Content for Popular tab
              _buildTabContent(
                'Popular Searches',
                Icons.trending_up,
                Colors.orange,
                ['Flutter jobs', 'Flutter vs React Native', 'State management'],
              ),
              // Content for Favorites tab
              _buildTabContent(
                'Your Favorites',
                Icons.favorite,
                Colors.red,
                ['Advanced Flutter', 'UI design tips', 'Animation tutorial'],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method to build similar content for each tab
  Widget _buildTabContent(String title, IconData icon, Color color, List<String> items) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: color),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(item, style: const TextStyle(fontSize: 16)),
          )).toList(),
        ],
      ),
    );
  }
}

// Library tab content
class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of books
    final List<Map<String, dynamic>> books = [
      {
        'title': 'Flutter Basics',
        'author': 'Dev Mentor',
        'cover': Colors.blue[200],
      },
      {
        'title': 'Advanced Dart Programming',
        'author': 'Code Master',
        'cover': Colors.green[200],
      },
      {
        'title': 'UI Design Patterns',
        'author': 'Designer Pro',
        'cover': Colors.orange[200],
      },
      {
        'title': 'State Management Guide',
        'author': 'Flutter Expert',
        'cover': Colors.purple[200],
      },
      {
        'title': 'Building Beautiful UIs',
        'author': 'Creative Coder',
        'cover': Colors.red[200],
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Library',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 60,
                      color: book['cover'],
                    ),
                    title: Text(book['title']),
                    subtitle: Text(book['author']),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // When tapped, navigate to a detail page and pass data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Screen to show details of a selected book
class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 200,
              color: book['cover'],
              child: const Center(
                child: Icon(Icons.book, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              book['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'by ${book['author']}',
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Go back to previous screen
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Details screen that can be accessed from multiple places
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline,
              size: 80,
              color: Colors.indigo,
            ),
            const SizedBox(height: 24),
            const Text(
              'This is a Detail Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'You navigated here using Navigator.push or a named route',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // Pop removes the current screen and goes back
                // Like taking a book off the top of a stack
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
} */