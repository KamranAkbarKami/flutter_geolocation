# flutter_geolocation

A Flutter Project that Helps Understand Geolocator Plugin. It helps find Latitude and Longitude of
User.

#Android Settings:

1: Add the following to your "gradle.properties" file:

android.useAndroidX=true android.enableJetifier=true

2: Make sure you set the compileSdkVersion in your "android/app/build.gradle" file to 33:

android { compileSdkVersion 33 }

3: Android Manifest

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

#iOS Settings

<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location when in the background.</string>