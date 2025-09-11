package com.iu.reactlibrary;

import android.os.Bundle;

import amazonia.iu.com.amlibrary.activities.DRComplianceActivity;


public class HostComplianceActivity extends DRComplianceActivity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_host_compliance);
    }
}