https://we.tl/t-ZpaWr8l38e

sleek_circular_slider:
  path: packages/sleek_circular_slider/

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? timer;
  double currentValue = 0;
  double extra = 0;
  double max = 10;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            SleekCircularSlider(
              onChangeEnd: null,
              onChangeStart: null,
              initialValue: currentValue,
              appearance: CircularSliderAppearance(
                size: 200.0,
                customColors: CustomSliderColors(
                  hideShadow: true,
                  shadowMaxOpacity: 0,
                  dynamicGradient: false,
                  trackColor: Colors.grey,
                  dotColor: Colors.redAccent,
                  progressBarColor: Colors.blue,
                ),
                startAngle: 270,
                angleRange: 360,
                customWidths: CustomSliderWidths(
                  trackWidth: 20,
                  handlerSize: 10.0,
                  progressBarWidth: 20,
                ),
                spinnerDuration: 2,
                spinnerMode: false,
                animationEnabled: false,
              ),
              innerWidget: (value) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$currentValue"),
                    if (currentValue >= max && extra > 0)
                      Text(
                        "${"$extra"} ",
                        style: const TextStyle(color: Colors.green),
                      )
                    else if (currentValue < max &&
                        timer != null &&
                        timer?.isActive == false)
                      Text(
                        "${"-${max - currentValue}"} ",
                        style: const TextStyle(color: Colors.red),
                      )
                  ],
                );
              },
              min: 0,
              max: max,
              onChange: null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("currentValue:-------> $currentValue");
                timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                  if (currentValue >= max) {
                    extra++;
                    // timer.cancel();
                  } else {
                    currentValue = timer.tick.toDouble();
                  }
                  setState(() {});
                });
                // generateRandomValue();
              },
              child: Text(currentValue.toString()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("currentValue:-------> $currentValue");
                if (timer != null) {
                  timer?.cancel();
                  setState(() {});
                } else {
                  print("ELSE");
                }
              },
              child: Text("END".toString()),
            ),
          ],
        ),
      ),
    );
  }
}
