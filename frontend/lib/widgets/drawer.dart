import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.changeScreen});

  final void Function(String, BuildContext) changeScreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      // width: 200,
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 60),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListTile(
              onTap: () {
                changeScreen("dashboard", context);
              },
              leading: Icon(Icons.home,
                  color: Theme.of(context).colorScheme.primaryContainer),
              title: Text(
                "DashBoard",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primaryContainer),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Data",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          ListTile(
            onTap: () {
              changeScreen("dataset", context);
            },
            leading: Icon(Icons.data_array,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            title: Text(
              "DataSets",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          ListTile(
            onTap: () {
              changeScreen("piechart", context);
            },
            leading: Icon(Icons.pie_chart,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            title: Text(
              "Pie Chart",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          ListTile(
            onTap: () {
              changeScreen("barchart", context);
            },
            leading: Icon(Icons.bar_chart,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            title: Text(
              "Bar Chart",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          ListTile(
            onTap: () {
              changeScreen("confusion_matrix", context);
            },
            leading: Icon(Icons.airline_stops_sharp,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            title: Text(
              "Confusion Matrix",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          ListTile(
            onTap: () {
              changeScreen("confusion_matrix_multiclass", context);
            },
            leading: Icon(Icons.airline_stops_outlined,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            title: Text(
              "Confusion Matrix Multiclass",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            title: Text(
              "Management User",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              changeScreen("manage_users", context);
            },
            leading: Icon(Icons.person,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            title: Text(
              "Users",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            leading: const Icon(Icons.exit_to_app),
            title: Text(
              "Logout",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
