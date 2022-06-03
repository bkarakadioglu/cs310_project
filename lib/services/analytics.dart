import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void setLogEvent(FirebaseAnalytics analytics) {
  analytics.logEvent(
    name: 'log event',
    parameters: <String, dynamic>{
      'string': 'string',
      'int': 310,
      'long': 123212421,
      'double': 12.24123,
      'bool' : true,
    }
  );
}



void setuserId(FirebaseAnalytics analytics, String userId){
  analytics.setUserId();
}
void setCurrentScreen(FirebaseAnalytics analytics, String screenName){
  analytics.setCurrentScreen(screenName: screenName);
}