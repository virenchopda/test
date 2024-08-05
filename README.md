
class User {
  final int id;
  final Icon icon;
  final String name;
  final bool selected;

  User({
    required this.name,
    required this.id,
    required this.icon,
    required this.selected,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = MultiSelectController<User>();

  @override
  Widget build(BuildContext context) {
    var items = [
      DropdownItem(
        label: 'Nepal',
        value: User(
          name: 'Nepal',
          id: 1,
          selected: false,
          icon: const Icon(Icons.account_balance),
        ),
      ),
      DropdownItem(
        label: 'Australia',
        value: User(
          name: 'Australia',
          id: 6,
          selected: false,
          icon: const Icon(Icons.app_blocking_outlined),
        ),
      ),
      DropdownItem(
        label: 'India',
        value: User(
          name: 'India',
          id: 2,
          icon: const Icon(Icons.abc),
          selected: false,
        ),
      ),
      DropdownItem(
        label: 'China',
        value: User(
          id: 3,
          selected: false,
          name: 'China',
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              MultiDropdown<User>(
                items: items,
                controller: controller,
                enabled: true,
                searchEnabled: false,
                chipDecoration: const ChipDecoration(
                  backgroundColor: Colors.yellow,
                  wrap: true,
                  runSpacing: 2,
                  spacing: 10,
                ),
                fieldDecoration: FieldDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                  ),
                  hintText: 'Countries',
                  hintStyle: const TextStyle(color: Colors.black87),
                  prefixIcon: const Icon(CupertinoIcons.flag),
                  showClearIcon: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.black87,
                    ),
                  ),
                ),
                dropdownDecoration: const DropdownDecoration(
                  marginTop: 0,
                  maxHeight: 200,
                ),
                itemBuilder: (
                  DropdownItem<User> item,
                  int index,
                  VoidCallback onTap,
                ) {
                  return ListTile(
                    onTap: () {
                      int? index1 = controller.selectedItems.indexWhere(
                          (element) => element.value.name == item.value.name);
                      if (index1 == -1) {
                        controller.selectAtIndex(index);
                        item.copyWith(selected: true);
                      } else {
                        item.copyWith(selected: false);
                        controller
                            .unselectWhere((ite) => item.label == ite.label);
                      }
                      setState(() {});
                    },
                    leading: item.value.icon,
                    title: Text(item.value.name),
                    trailing: item.selected
                        ? const Icon(Icons.check_box)
                        : const Icon(Icons.check_box_outline_blank_rounded),
                  );
                },
                dropdownItemDecoration: DropdownItemDecoration(
                  selectedIcon:
                      const Icon(Icons.check_box, color: Colors.green),
                  disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a country';
                  }
                  return null;
                },
                onSelectionChange: (selectedItems) {
                  debugPrint("OnSelectionChange: $selectedItems");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

