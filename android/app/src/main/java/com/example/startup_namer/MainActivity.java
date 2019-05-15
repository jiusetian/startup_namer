package com.example.startup_namer;

import android.os.Bundle;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Log.d("tag", "onCreate: 执行了mainact");
    //注册flutter插件
    GeneratedPluginRegistrant.registerWith(this);
  }
}
