# react-native-ios-file-opener

[![npm version](https://img.shields.io/npm/v/react-native-ios-file-opener.svg?style=flat)](https://www.npmjs.com/package/react-native-ios-file-opener)

This is a file opener helper(iOS only). It supports:
   1. open ios File App.
   2. use other file open.

## install
 use yarn 
 ```
yarn add react-native-ios-file-opener
 ```
 
 ## iOS Environment

podfile add 
```
  pod 'react-native-ios-file-opener', :podspec => '../node_modules/react-native-ios-file-opener/react-native-ios-file-opener.podspec'
```

info.plist add permission
```
  <key>UIFileSharingEnabled</key>
  <true
  <key>LSSupportsOpeningDocumentsInPlace</key>
  <true/>
  
```



## How to use
```
  import Helper from 'react-native-ios-file-opener';
  
  ... 
    // open ios file app
   Helper.openIOSFileApp();
  
  
   // open it with another application
   const filePath = '';
   Helper.openWithFilePath(filePath);
  ...
  
```
