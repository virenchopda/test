https://pub.dev/packages/call_log_new
import 'package:call_log/call_log.dart';

try {
	await Permission.contacts.request();
	await Permission.phone.request();
	final logs = await CallLog.fetchCallLogs();
	for (var element in logs) {
		log("ELE:---> ${element.number} ${element.name}");
	}
} catch (e) {
	print("Error fetching call logs: $e");
}

<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.READ_CALL_LOG"/>
<uses-permission android:name="android.permission.WRITE_CALL_LOG"/>
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
