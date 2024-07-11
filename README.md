# test
builder: (context, child) {
                            return Theme(
                              data: ThemeData(
                                useMaterial3: false,
                                primarySwatch: Colors.grey,
                                splashColor: Colors.black,
                                // textTheme: const TextTheme(
                                //   subtitle1: TextStyle(color: Colors.white),
                                //   button: TextStyle(color: Colors.amber),
                                // ),
                                colorScheme: const ColorScheme.light(
                                  primary: Colors.pink,
                                  onSecondary: Colors.black,
                                  onPrimary: Colors.white,
                                  surface: Colors.black,
                                  onSurface: Colors.black,
                                  secondary: Colors.black,
                                ),
                                //  const ColorScheme.dark(
                                //   primary: Colors.black,
                                //   surface: Colors.black,
                                //   onSurface: Colors.white, //txt
                                //   onSecondary: Colors.white,
                                //   onPrimary: Colors.white,
                                //   secondary: Colors.white,
                                // ),
                              ),
                              child: child!,
                            );
