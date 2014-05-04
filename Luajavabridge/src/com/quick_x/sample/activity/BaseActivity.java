package com.quick_x.sample.activity;

import org.cocos2dx.lib.Cocos2dxActivity;

import android.annotation.SuppressLint;
import android.app.NotificationManager;
import android.content.Context;
import android.view.Gravity;
import android.view.View;
import android.widget.Toast;

@SuppressLint("NewApi")
public class BaseActivity extends Cocos2dxActivity {

	public void showToast(View view, String text) {
		Toast toast = new Toast(getApplicationContext());
		toast.setGravity(Gravity.CENTER_VERTICAL, 0, 0);
		toast.setDuration(Toast.LENGTH_LONG);
		toast.setView(view);
		toast.setText(text);
		toast.show();
	}

	public NotificationManager getNotificationManager() {
		NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
		return notificationManager;
	}

}
