package com.quick_x.sample.activity;

import android.os.Bundle;

public class MainActivity extends BaseActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		// showToast(findViewById(R), "Main");
		initView();
	}

	private void initView() {
		getWindow().setBackgroundDrawableResource(R.drawable.loading);
	}

}
