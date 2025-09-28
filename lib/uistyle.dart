// # Flutter UI Development Guide for Beginners
//
// ## Introduction to Flutter UI
//
// Flutter uses a widget-based approach for building UIs. Everything in Flutter is a widget - from a simple text or button to a complex screen layout. This makes UI development consistent and flexible.
//
// ## Basic Layout Concepts
//
// ### Container Widget
//
// The `Container` widget is like a box that can contain other widgets. It's highly customizable with properties for padding, margins, decoration, etc.
//
// ```dart
// Container(
// width: 200,
// height: 100,
// padding: EdgeInsets.all(16.0),
// margin: EdgeInsets.symmetric(vertical: 10.0),
// decoration: BoxDecoration(
// color: Colors.blue,
// borderRadius: BorderRadius.circular(10.0),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.5),
// spreadRadius: 2,
// blurRadius: 5,
// offset: Offset(0, 3),
// ),
// ],
// ),
// child: Text(
// 'Hello Flutter',
// style: TextStyle(color: Colors.white, fontSize: 20),
// ),
// )
// ```
//
// In this example:
// - We create a container with specific width and height
// - Add padding inside and margin outside the container
// - Apply decoration with color, rounded corners, and a shadow
// - Add a text widget as a child
//
// ### Row and Column Widgets
//
// These are fundamental layout widgets that arrange their children horizontally (Row) or vertically (Column).
//
// ```dart
// Column(
// mainAxisAlignment: MainAxisAlignment.center, // Vertical alignment
// crossAxisAlignment: CrossAxisAlignment.start, // Horizontal alignment
// children: [
// Text('First item'),
// Text('Second item'),
// Text('Third item'),
// ],
// )
// ```
//
// ```dart
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Horizontal alignment
// crossAxisAlignment: CrossAxisAlignment.center, // Vertical alignment
// children: [
// Icon(Icons.star),
// Text('4.5'),
// Text('(123 reviews)'),
// ],
// )
// ```
//
// Key alignment properties:
// - `mainAxisAlignment`: How to place children along the main axis (horizontal for Row, vertical for Column)
// - `crossAxisAlignment`: How to place children along the cross axis (vertical for Row, horizontal for Column)
//
// ### Stack Widget
//
// Stack allows you to overlay widgets on top of each other.
//
// ```dart
// Stack(
// children: [
// Image.network(
// 'https://picsum.photos/200/300',
// width: double.infinity,
// height: 200,
// fit: BoxFit.cover,
// ),
// Positioned(
// bottom: 10,
// right: 10,
// child: Container(
// padding: EdgeInsets.all(8.0),
// color: Colors.black54,
// child: Text(
// 'Overlay Text',
// style: TextStyle(color: Colors.white),
// ),
// ),
// ),
// ],
// )
// ```
//
// The `Positioned` widget lets you precisely position children within the Stack.
//
// ## Creating Forms
//
// Forms in Flutter are created using the `Form` widget along with various form field widgets.
//
// ### Basic Form Example
//
// ```dart
// class SimpleForm extends StatefulWidget {
// @override
// _SimpleFormState createState() => _SimpleFormState();
// }
//
// class _SimpleFormState extends State<SimpleForm> {
// // Create a global key that uniquely identifies the Form widget
// final _formKey = GlobalKey<FormState>();
//
// // Controllers to retrieve the values
// final _nameController = TextEditingController();
// final _emailController = TextEditingController();
// final _passwordController = TextEditingController();
//
// @override
// void dispose() {
// // Clean up the controllers when the widget is removed
// _nameController.dispose();
// _emailController.dispose();
// _passwordController.dispose();
// super.dispose();
// }
//
// @override
// Widget build(BuildContext context) {
// return Padding(
// padding: EdgeInsets.all(16.0),
// child: Form(
// key: _formKey,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// // Name field
// TextFormField(
// controller: _nameController,
// decoration: InputDecoration(
// labelText: 'Name',
// border: OutlineInputBorder(),
// prefixIcon: Icon(Icons.person),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your name';
// }
// return null;
// },
// ),
// SizedBox(height: 16.0),
//
// // Email field
// TextFormField(
// controller: _emailController,
// decoration: InputDecoration(
// labelText: 'Email',
// border: OutlineInputBorder(),
// prefixIcon: Icon(Icons.email),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your email';
// }
// if (!value.contains('@')) {
// return 'Please enter a valid email';
// }
// return null;
// },
// keyboardType: TextInputType.emailAddress,
// ),
// SizedBox(height: 16.0),
//
// // Password field
// TextFormField(
// controller: _passwordController,
// decoration: InputDecoration(
// labelText: 'Password',
// border: OutlineInputBorder(),
// prefixIcon: Icon(Icons.lock),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter a password';
// }
// if (value.length < 6) {
// return 'Password must be at least 6 characters';
// }
// return null;
// },
// obscureText: true, // Hides the password
// ),
// SizedBox(height: 24.0),
//
// // Submit button
// Center(
// child: ElevatedButton(
// onPressed: () {
// // Validate the form
// if (_formKey.currentState!.validate()) {
// // If the form is valid, display a success message
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(content: Text('Form submitted successfully!')),
// );
//
// // Here you can process the form data
// print('Name: ${_nameController.text}');
// print('Email: ${_emailController.text}');
// print('Password: ${_passwordController.text}');
// }
// },
// child: Padding(
// padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
// child: Text('Submit', style: TextStyle(fontSize: 18)),
// ),
// ),
// ),
// ],
// ),
// ),
// );
// }
// }
// ```
//
// ### Form Elements Explained:
//
// 1. **Form Widget**: Acts as a container for form fields and provides validation functionality.
//
// 2. **TextFormField**: The standard text input field with built-in validation support.
// - `controller`: To retrieve the input value
// - `decoration`: To style the input field
// - `validator`: A function that returns an error message if validation fails
// - `obscureText`: For password fields
// - `keyboardType`: Specifies which keyboard type to show
//
// 3. **Form Validation**: Using the `_formKey.currentState!.validate()` method to validate all fields at once.
//
// 4. **Form Submission**: Processing the form data when validation passes.
//
// ## Creating Navigation Bars
//
// ### Bottom Navigation Bar
//
// ```dart
// class HomeScreen extends StatefulWidget {
// @override
// _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
// int _selectedIndex = 0;
//
// // Pages to display
// static List<Widget> _pages = <Widget>[
// Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
// Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),
// Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
// ];
//
// void _onItemTapped(int index) {
// setState(() {
// _selectedIndex = index;
// });
// }
//
// @override
// Widget build(BuildContext context) {
// return Scaffold(
// appBar: AppBar(
// title: Text('Bottom Navigation Bar Demo'),
// ),
// body: _pages[_selectedIndex], // Show the selected page
// bottomNavigationBar: BottomNavigationBar(
// items: const <BottomNavigationBarItem>[
// BottomNavigationBarItem(
// icon: Icon(Icons.home),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.search),
// label: 'Search',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.person),
// label: 'Profile',
// ),
// ],
// currentIndex: _selectedIndex,
// selectedItemColor: Colors.amber[800],
// onTap: _onItemTapped,
// ),
// );
// }
// }
// ```
//
// Key components:
// - `BottomNavigationBar`: Creates the navigation bar at the bottom of the screen
// - `BottomNavigationBarItem`: Individual items with icons and labels
// - State management to track the selected tab
// - Corresponding pages/content displayed based on the selected tab
//
// ### App Bar with Navigation
//
// ```dart
// Scaffold(
// appBar: AppBar(
// leading: IconButton(
// icon: Icon(Icons.menu),
// onPressed: () {
// // Open drawer or perform other action
// Scaffold.of(context).openDrawer();
// },
// ),
// title: Text('My App'),
// actions: [
// IconButton(
// icon: Icon(Icons.search),
// onPressed: () {
// // Handle search action
// },
// ),
// IconButton(
// icon: Icon(Icons.more_vert),
// onPressed: () {
// // Show more options
// },
// ),
// ],
// backgroundColor: Colors.blue,
// ),
// // Rest of the Scaffold...
// )
// ```
//
// The `AppBar` widget creates a top bar with:
// - `leading`: Widget at the start (typically a menu/back button)
// - `title`: App title
// - `actions`: List of widgets at the end (typically icons for actions)
//
// ### Drawer Navigation
//
// ```dart
// Scaffold(
// appBar: AppBar(
// title: Text('Drawer Navigation'),
// ),
// drawer: Drawer(
// child: ListView(
// padding: EdgeInsets.zero,
// children: [
// DrawerHeader(
// decoration: BoxDecoration(
// color: Colors.blue,
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// CircleAvatar(
// radius: 30,
// backgroundImage: NetworkImage('https://picsum.photos/200'),
// ),
// SizedBox(height: 10),
// Text(
// 'User Name',
// style: TextStyle(color: Colors.white, fontSize: 18),
// ),
// Text(
// 'user@email.com',
// style: TextStyle(color: Colors.white70, fontSize: 14),
// ),
// ],
// ),
// ),
// ListTile(
// leading: Icon(Icons.home),
// title: Text('Home'),
// onTap: () {
// // Navigate to home page
// Navigator.pop(context); // Close the drawer
// // Then navigate to the desired page
// },
// ),
// ListTile(
// leading: Icon(Icons.settings),
// title: Text('Settings'),
// onTap: () {
// // Navigate to settings page
// Navigator.pop(context); // Close the drawer
// // Then navigate to the desired page
// },
// ),
// Divider(), // Horizontal line divider
// ListTile(
// leading: Icon(Icons.logout),
// title: Text('Logout'),
// onTap: () {
// // Handle logout
// Navigator.pop(context); // Close the drawer
// // Then perform logout action
// },
// ),
// ],
// ),
// ),
// body: Center(
// child: Text('Swipe from left edge or tap menu icon to open drawer'),
// ),
// )
// ```
//
// The drawer navigation consists of:
// - `Drawer` widget: The slide-out panel
// - `DrawerHeader`: Typically contains user info or app logo
// - `ListTile` widgets: Menu items with icons and labels
//
// ## Creating Footers
//
// In Flutter, there's no specific "footer" widget, but you can create footer-like elements using various approaches:
//
// ### Fixed Footer using Bottom Navigation Bar
//
// ```dart
// Scaffold(
// appBar: AppBar(title: Text('App with Footer')),
// body: ListView(
// children: List.generate(
// 20,
// (index) => ListTile(
// title: Text('Item ${index + 1}'),
// ),
// ),
// ),
// bottomNavigationBar: Container(
// height: 60,
// padding: EdgeInsets.all(10),
// color: Colors.grey[200],
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Icon(Icons.favorite, color: Colors.red),
// Text('Support Us', style: TextStyle(fontSize: 12)),
// ],
// ),
// Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Icon(Icons.info, color: Colors.blue),
// Text('About', style: TextStyle(fontSize: 12)),
// ],
// ),
// Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Icon(Icons.contact_mail, color: Colors.green),
// Text('Contact', style: TextStyle(fontSize: 12)),
// ],
// ),
// ],
// ),
// ),
// )
// ```
//
// ### Footer as Part of Content
//
// ```dart
// Scaffold(
// appBar: AppBar(title: Text('App with In-Content Footer')),
// body: Column(
// children: [
// // Main content area with Expanded to take available space
// Expanded(
// child: ListView(
// children: List.generate(
// 15,
// (index) => ListTile(
// title: Text('Content item ${index + 1}'),
// ),
// ),
// ),
// ),
//
// // Footer area
// Container(
// padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
// color: Colors.grey[200],
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// IconButton(
// icon: Icon(Icons.facebook, color: Colors.indigo),
// onPressed: () {},
// ),
// IconButton(
// icon: Icon(Icons.self_improvement, color: Colors.pink),
// onPressed: () {},
// ),
// IconButton(
// icon: Icon(Icons.public, color: Colors.blue),
// onPressed: () {},
// ),
// ],
// ),
// SizedBox(height: 10),
// Text('© 2025 My Flutter App', style: TextStyle(color: Colors.grey[600])),
// SizedBox(height: 5),
// Text('Privacy Policy | Terms of Service', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
// ],
// ),
// ),
// ],
// ),
// )
// ```
//
// ## Styling and Theming
//
// ### Theme Configuration
//
// Flutter makes app-wide styling easy with ThemeData:
//
// ```dart
// // In your MaterialApp widget
// MaterialApp(
// title: 'Styled App',
// theme: ThemeData(
// // Color scheme
// primarySwatch: Colors.blue,
// accentColor: Colors.orange,
//
// // Text themes
// textTheme: TextTheme(
// headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
// headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
// bodyText1: TextStyle(fontSize: 16.0, height: 1.5),
// bodyText2: TextStyle(fontSize: 14.0, height: 1.5),
// ),
//
// // Button themes
// elevatedButtonTheme: ElevatedButtonThemeData(
// style: ElevatedButton.styleFrom(
// primary: Colors.blue,
// onPrimary: Colors.white,
// padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// ),
//
// // Input decoration theme
// inputDecorationTheme: InputDecorationTheme(
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// focusedBorder: OutlineInputBorder(
// borderSide: BorderSide(color: Colors.blue, width: 2),
// borderRadius: BorderRadius.circular(8),
// ),
// contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// ),
// ),
// home: MyHomePage(),
// )
// ```
//
// ### Custom Widget Styling
//
// ```dart
// Container(
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [Colors.blue.shade300, Colors.blue.shade700],
// begin: Alignment.topLeft,
// end: Alignment.bottomRight,
// ),
// borderRadius: BorderRadius.circular(12),
// boxShadow: [
// BoxShadow(
// color: Colors.black.withOpacity(0.2),
// spreadRadius: 2,
// blurRadius: 8,
// offset: Offset(0, 4),
// ),
// ],
// ),
// padding: EdgeInsets.all(16),
// child: Text(
// 'Beautifully Styled Widget',
// style: TextStyle(
// color: Colors.white,
// fontSize: 18,
// fontWeight: FontWeight.bold,
// ),
// ),
// )
// ```
//
// ## Complete App Example - Basic Contact Form
//
// Here's a complete example of a simple contact form app incorporating layouts, forms, navigation, and styling:
//
// ```dart
// import 'package:flutter/material.dart';
//
// void main() {
// runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
// @override
// Widget build(BuildContext context) {
// return MaterialApp(
// title: 'Contact Form Demo',
// theme: ThemeData(
// primarySwatch: Colors.teal,
// visualDensity: VisualDensity.adaptivePlatformDensity,
// inputDecorationTheme: InputDecorationTheme(
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10),
// ),
// focusedBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10),
// borderSide: BorderSide(color: Colors.teal, width: 2),
// ),
// contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// ),
// ),
// home: ContactFormPage(),
// );
// }
// }
//
// class ContactFormPage extends StatefulWidget {
// @override
// _ContactFormPageState createState() => _ContactFormPageState();
// }
//
// class _ContactFormPageState extends State<ContactFormPage> {
// final _formKey = GlobalKey<FormState>();
// final _nameController = TextEditingController();
// final _emailController = TextEditingController();
// final _messageController = TextEditingController();
//
// int _currentIndex = 0;
//
// @override
// void dispose() {
// _nameController.dispose();
// _emailController.dispose();
// _messageController.dispose();
// super.dispose();
// }
//
// @override
// Widget build(BuildContext context) {
// return Scaffold(
// appBar: AppBar(
// title: Text('Contact Us'),
// actions: [
// IconButton(
// icon: Icon(Icons.info_outline),
// onPressed: () {
// showAboutDialog(
// context: context,
// applicationName: 'Contact Form Demo',
// applicationVersion: '1.0.0',
// applicationLegalese: '© 2025 Flutter Demo App',
// );
// },
// ),
// ],
// ),
//
// drawer: Drawer(
// child: ListView(
// padding: EdgeInsets.zero,
// children: [
// DrawerHeader(
// decoration: BoxDecoration(
// color: Colors.teal,
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Icon(
// Icons.contact_mail,
// color: Colors.white,
// size: 48,
// ),
// SizedBox(height: 12),
// Text(
// 'Contact App',
// style: TextStyle(color: Colors.white, fontSize: 22),
// ),
// Text(
// 'Stay connected with us',
// style: TextStyle(color: Colors.white70, fontSize: 14),
// ),
// ],
// ),
// ),
// ListTile(
// leading: Icon(Icons.home),
// title: Text('Home'),
// onTap: () {
// Navigator.pop(context);
// setState(() {
// _currentIndex = 0;
// });
// },
// ),
// ListTile(
// leading: Icon(Icons.contact_page),
// title: Text('Contact Form'),
// onTap: () {
// Navigator.pop(context);
// setState(() {
// _currentIndex = 1;
// });
// },
// ),
// ListTile(
// leading: Icon(Icons.info),
// title: Text('About'),
// onTap: () {
// Navigator.pop(context);
// setState(() {
// _currentIndex = 2;
// });
// },
// ),
// ],
// ),
// ),
//
// body: _getPage(_currentIndex),
//
// bottomNavigationBar: BottomNavigationBar(
// currentIndex: _currentIndex,
// onTap: (index) {
// setState(() {
// _currentIndex = index;
// });
// },
// items: [
// BottomNavigationBarItem(
// icon: Icon(Icons.home),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.contact_page),
// label: 'Contact',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.info),
// label: 'About',
// ),
// ],
// ),
//
// // Footer-like persistent bottom content
// persistentFooterButtons: [
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text('© 2025 Flutter Demo', style: TextStyle(color: Colors.grey[600])),
// SizedBox(width: 10),
// Icon(Icons.favorite, color: Colors.red, size: 16),
// ],
// ),
// ],
// );
// }
//
// Widget _getPage(int index) {
// switch (index) {
// case 0:
// return _buildHomePage();
// case 1:
// return _buildContactForm();
// case 2:
// return _buildAboutPage();
// default:
// return _buildHomePage();
// }
// }
//
// Widget _buildHomePage() {
// return Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Icon(Icons.contact_support, size: 100, color: Colors.teal),
// SizedBox(height: 20),
// Text(
// 'Welcome to the Contact App',
// style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// ),
// SizedBox(height: 10),
// Padding(
// padding: EdgeInsets.symmetric(horizontal: 32),
// child: Text(
// 'Navigate to the Contact page to send us a message',
// textAlign: TextAlign.center,
// style: TextStyle(fontSize: 16, color: Colors.grey[700]),
// ),
// ),
// SizedBox(height: 30),
// ElevatedButton.icon(
// icon: Icon(Icons.arrow_forward),
// label: Text('Go to Contact Form'),
// style: ElevatedButton.styleFrom(
// padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// ),
// onPressed: () {
// setState(() {
// _currentIndex = 1;
// });
// },
// ),
// ],
// ),
// );
// }
//
// Widget _buildContactForm() {
// return SingleChildScrollView(
// child: Padding(
// padding: EdgeInsets.all(16.0),
// child: Form(
// key: _formKey,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Send us a message',
// style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// ),
// SizedBox(height: 20),
//
// Text('Your Name', style: TextStyle(fontWeight: FontWeight.w500)),
// SizedBox(height: 8),
// TextFormField(
// controller: _nameController,
// decoration: InputDecoration(
// hintText: 'Enter your full name',
// prefixIcon: Icon(Icons.person),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your name';
// }
// return null;
// },
// ),
// SizedBox(height: 16),
//
// Text('Email Address', style: TextStyle(fontWeight: FontWeight.w500)),
// SizedBox(height: 8),
// TextFormField(
// controller: _emailController,
// decoration: InputDecoration(
// hintText: 'Enter your email address',
// prefixIcon: Icon(Icons.email),
// ),
// keyboardType: TextInputType.emailAddress,
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your email';
// }
// if (!value.contains('@') || !value.contains('.')) {
// return 'Please enter a valid email address';
// }
// return null;
// },
// ),
// SizedBox(height: 16),
//
// Text('Your Message', style: TextStyle(fontWeight: FontWeight.w500)),
// SizedBox(height: 8),
// TextFormField(
// controller: _messageController,
// decoration: InputDecoration(
// hintText: 'Enter your message here',
// alignLabelWithHint: true,
// ),
// maxLines: 5,
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter a message';
// }
// if (value.length < 10) {
// return 'Message must be at least 10 characters';
// }
// return null;
// },
// ),
// SizedBox(height: 24),
//
// Center(
// child: ElevatedButton(
// onPressed: () {
// if (_formKey.currentState!.validate()) {
// // Process form data
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('Message sent successfully!'),
// backgroundColor: Colors.green,
// ),
// );
//
// // Clear form
// _nameController.clear();
// _emailController.clear();
// _messageController.clear();
// }
// },
// child: Padding(
// padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
// child: Text(
// 'Submit',
// style: TextStyle(fontSize: 18),
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// );
// }
//
// Widget _buildAboutPage() {
// return SingleChildScrollView(
// child: Padding(
// padding: EdgeInsets.all(20),
// child: Column(
// children: [
// Icon(
// Icons.info_outline,
// size: 70,
// color: Colors.teal,
// ),
// SizedBox(height: 16),
// Text(
// 'About This App',
// style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
// ),
// SizedBox(height: 20),
// Card(
// elevation: 4,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(16),
// ),
// child: Padding(
// padding: EdgeInsets.all(16),
// child: Column(
// children: [
// Text(
// 'Flutter Contact Form Demo',
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// ),
// SizedBox(height: 12),
// Text(
// 'This app demonstrates various Flutter UI concepts including:',
// style: TextStyle(fontSize: 16),
// ),
// SizedBox(height: 8),
// _buildFeatureItem('Form creation and validation'),
// _buildFeatureItem('Responsive layouts'),
// _buildFeatureItem('Navigation using bottom nav bar'),
// _buildFeatureItem('Navigation drawer implementation'),
// _buildFeatureItem('Styling and theming'),
// _buildFeatureItem('Creating footer-like elements'),
// ],
// ),
// ),
// ),
// SizedBox(height: 20),
// Text(
// 'Version 1.0.0',
// style: TextStyle(color: Colors.grey[600]),
// ),
// SizedBox(height: 8),
// Text(
// '© 2025 Flutter Demo App',
// style: TextStyle(color: Colors.grey[600]),
// ),
// ],
// ),
// ),
// );
// }
//
// Widget _buildFeatureItem(String text) {
// return Padding(
// padding: EdgeInsets.symmetric(vertical: 4),
// child: Row(
// children: [
// Icon(Icons.check_circle, color: Colors.teal, size: 20),
// SizedBox(width: 8),
// Expanded(
// child: Text(text),
// ),
// ],
// ),
// );
// }
// }
// ```
//
// ## Key Takeaways
//
// 1. **Layout Fundamentals**:
// - Use `Container` for simple boxes with styling
// - `Row` and `Column` for horizontal and vertical arrangements
// - `Stack` for overlapping elements
// - `ListView` for scrollable content
// - `Expanded` and `Flexible` to control how widgets use available space
//
// 2. **Forms**:
// - Use the `Form` widget to group form fields
// - `TextFormField` for input with built-in validation
// - Controllers to retrieve input values
// - Validation to ensure correct data entry
//
// 3. **Navigation**:
// - `BottomNavigationBar` for tab-based navigation
// - `Drawer` for slide-out menu navigation
// - `AppBar` for top navigation elements
//
// 4. **Styling**:
// - Use `ThemeData` for consistent app-wide styling
// - `BoxDecoration` for container styling with gradients, shadows, borders
// - `TextStyle` for text formatting
//
// 5. **Footers**:
// - Create footer-like elements with containers at the bottom
// - Use `persistentFooterButtons` for a simple footer
// - Implement footers as part of scrollable content
//
// ## Next Steps in Your Flutter Journey
//
// 1. **State Management**: Learn about more advanced state management solutions like Provider, Bloc, or Riverpod
// 2. **Navigation 2.0**: Explore Flutter's newer navigation API for more complex navigation scenarios
// 3. **Responsive Design**: Make your apps work well on different screen sizes
// 4. **Animations**: Add animations to make your UI more engaging
// 5. **Firebase Integration**: Connect your app to backend services
//
// Remember that Flutter development is about composition - building complex UIs by combining simple widgets. Start with the basics and gradually incorporate more advanced concepts as you gain confidence.