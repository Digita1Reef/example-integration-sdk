package com.example.empty_example

import android.app.Application
import com.siprocal.sdk.client.SiprocalSDK

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        SiprocalSDK.init(this)
    }
}