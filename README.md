

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
      DropdownItem(
        label: 'add',
        value: User(
          id: 3,
          selected: false,
          name: 'add',
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
              Container(
                color: Colors.red,
                child: MultiDropdown<User>(
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
                    return item.label == "add"
                        ? OutlinedButton(
                            onPressed: () {
                              controller.clearAll();
                              for (int i = 0; i < sele.length; i++) {
                                if (sele[i] == true) {
                                  item.copyWith(selected: true);
                                  controller.selectAtIndex(i);
                                } else {
                                  item.copyWith(selected: false);
                                  controller.unselectWhere(
                                    (ite) => item.value.name == ite.value.name,
                                  );
                                }
                              }
                            },
                            child: null,
                          )
                        : ListTile(
                            onTap: () {
                              // int? index1 = controller.selectedItems.indexWhere(
                              //     (element) =>
                              //         element.value.name == item.value.name);
                              // if (index1 == -1) {
                              // controller.selectAtIndex(index);
                              // item.copyWith(
                              //   value: User(
                              //     name: item.value.name,
                              //     id: item.value.id,
                              //     icon: item.value.icon,
                              //     selected: true,
                              //   ),
                              // );

                              // sele[index] = true;
                              // selected.copyWith(selected: true);
                              // } else {
                              // item.copyWith(
                              //   value: User(
                              //     name: item.value.name,
                              //     id: item.value.id,
                              //     icon: item.value.icon,
                              //     selected: false,
                              //   ),
                              // );
                              // sele[index] = false;
                              // item.copyWith(selected: false);
                              // controller.unselectWhere(
                              //     (ite) => item.label == ite.label);
                              // }
                              sele[index] = !sele[index];
                              setState(() {});
                            },
                            leading: item.value.icon,
                            title: Text(item.value.name),
                            trailing: sele[index] == true
                                ? const Icon(Icons.check_box)
                                : const Icon(
                                    Icons.check_box_outline_blank_rounded),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  List sele = [false, false, false, false];
}
