package com.example.activitylifecycle;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.method.ScrollingMovementMethod;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

public class A extends AppCompatActivity {


    private static final String ID = "A";
    private TextView mLifecycleMethodList;
    private TextView mActivityStates;
    private Handler mHandler;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_a);

        mLifecycleMethodList = (TextView) findViewById(R.id.lifecycle_method_list);
        mLifecycleMethodList.setMovementMethod(ScrollingMovementMethod.getInstance());
        mActivityStates = (TextView) findViewById(R.id.activity_status);
        mActivityStates.setMovementMethod(ScrollingMovementMethod.getInstance());




        Activities.setButtonsBackground(findViewById(R.id.buttons), getResources().getColor(R.color.AButton));


        if (getIntent().getStringExtra(Activities.EXTRA_CALLER) == null) {

            getSharedPreferences(Activities.PREFERENCES_NAME, MODE_PRIVATE).edit()
                    .putString("A", "null")
                    .putString("B", "null")
                    .putString("C", "null")
                    .apply();
        }

        // 指定 Handler 对消息的处理
        mHandler = new Handler() {
            @Override
            public void handleMessage(@NonNull Message msg) {
                super.handleMessage(msg);
                if (msg.what == Activities.UPDATE_VIEWS) {
                    updateViews();
                }
            }
        };

        // 定义并启动工作线程
        new Thread() {
            @Override
            public void run() {
                while (true) {
                    try {
                        Thread.sleep(Activities.WAIT_TIME);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    Message msg = Message.obtain();
                    msg.what = Activities.UPDATE_VIEWS;
                    mHandler.sendMessage(msg);
                }
            }
        }.start();

        saveCurrentState("created", "onCreate");
    }

    /**
     * 更新当前 Views 中的信息
     */
    private void updateViews() {
        // 从 ShredPreferences 中获取当前各 Activities 的状态，并更新对应 View
        SharedPreferences preferences = getSharedPreferences(Activities.PREFERENCES_NAME, MODE_PRIVATE);
        String initStatuses = "";
        initStatuses = initStatuses + preferences.getString("A", "null") + '\n';
        initStatuses = initStatuses + preferences.getString("B", "null") + '\n';
        initStatuses = initStatuses + preferences.getString("C", "null") + '\n';
        mActivityStates.setText(initStatuses);

        // 更新 Log 信息到给定的 View
        Activities.updateLogToView(mLifecycleMethodList);
    }

    /**
     * 保存当前的状态和方法调用信息
     * @param state 当前的状态
     * @param methodName 调用的方法名
     */
    private void saveCurrentState(String state, String methodName) {
        // 存入当前状态到 SharedPreferences 内
        SharedPreferences preferences = getSharedPreferences(Activities.PREFERENCES_NAME, MODE_PRIVATE);
        SharedPreferences.Editor editor = preferences.edit();
        editor.putString(ID, ID + ": " + state);
        editor.apply();

        // 将函数调用写入 Log 信息
        Log.d(Activities.TAG, "Activity " + ID + "." + methodName + "()");

    }

    /**
     * Callback 函数，调用 Activity B
     * @param view 与函数绑定在一起的 View
     */
    public void startBByA(View view) {
        Intent intent = new Intent(this, B.class).putExtra(Activities.EXTRA_CALLER, ID);
        startActivity(intent);
    }

    /**
     * Callback 函数，调用 Activity C
     * @param view 与函数绑定在一起的 View
     */
    public void startCByA(View view) {
        Intent intent = new Intent(this, C.class).putExtra(Activities.EXTRA_CALLER, ID);
        startActivity(intent);
    }

    /**
     * Callback 函数，调用 finish()
     * @param view 与函数绑定在一起的 View
     */
    public void finishA(View view) {
        finish();
    }

    /**
     * Callback 函数，调用一个 MyDialog
     * @param view 与函数绑定在一起的 View
     */
    public void startDialog(View view) {
        startActivity(new Intent(getApplicationContext(), MyDialog.class));
    }

    @Override
    protected void onStart() {
        super.onStart();
        saveCurrentState("started", "onStart");
    }

    @Override
    protected void onResume() {
        super.onResume();
        saveCurrentState("resumed", "onResume");
    }

    @Override
    protected void onPause() {
        super.onPause();
        saveCurrentState("paused", "onPause");
    }

    @Override
    protected void onStop() {
        super.onStop();
        saveCurrentState("stopped", "onStop");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        saveCurrentState("destroyed", "onDestroy");
    }
}