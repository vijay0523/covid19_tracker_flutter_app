# flutter_app

## About the app
This app connects to my server hosted on 000webhosting and runs a script on it which gathers data from www.MoHFW.gov.in
This app will work as long as the Government website does not change its format. It also automatically fetches data with a refresh button.
This Flutter App was built on the AndriodX platform using Android Studio

## Getting Started
Release APK is on the Build folder , you can try it out without any other changes.
Note: Allow Installation from unknown sources and Install Anyway for Google Play Protect.
For iOS devices , it should run with minimal changes (as far as i know have built compatible for iOS) and
you will have to build it manually with provided main.dart file.
I have provided the Local Saved website so incase the website changes it's format you can link to this.

## Import into Android Studio
-Make a new project - make sure its AndroidX compatible
-Copy the lib folder to your project directory
-Copy the pubpec.yaml file to project directory
-Change the both the gradle.properties (Android/app dir and %Projectdir%)
-Copy the Androidmanifest.xml file in %projectdir%/Android/App/src/main
-Copy the proguard-rules.pro file in %projectdir%/Android/App/
-Disable signing of apps (Check Documentation)

And that's it , you should be good to go.

## How it works?
It uses the Simple Html Dom library for PHP for web scraping.
Note: Only works on websites that do not have .noscript. tag
All the PHP extract files are located on the web server and outputs as JSON format and retrieved by the app from JSON reader
