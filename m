better_player_plus:


buildscript {
    ext.kotlin_version = '1.9.10'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.1.2'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        classpath 'com.google.gms:google-services:4.3.13'
    }
}

class BetterPlayerExample extends StatefulWidget {
  const BetterPlayerExample({super.key});

  @override
  _BetterPlayerExampleState createState() => _BetterPlayerExampleState();
}

class _BetterPlayerExampleState extends State<BetterPlayerExample> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();

    // Create configuration for BetterPlayer
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
      looping: false,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        enablePlayPause: true,
        enableProgressBar: true,
        enableMute: true,
        enableFullscreen: true,
        progressBarPlayedColor: Colors.red,
        progressBarHandleColor: Colors.redAccent,
        progressBarBackgroundColor: Colors.grey,
      ),
    );

    // Create a data source for the video
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "https://file-examples.com/storage/fee7a7e285671bd4a9d4d9d/2017/04/file_example_MP4_640_3MG.mp4",
    );

    // Initialize BetterPlayerController with configuration and data source
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(betterPlayerDataSource);
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Better Player Plus Example")),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer(controller: _betterPlayerController),
        ),
      ),
    );
  }
}
