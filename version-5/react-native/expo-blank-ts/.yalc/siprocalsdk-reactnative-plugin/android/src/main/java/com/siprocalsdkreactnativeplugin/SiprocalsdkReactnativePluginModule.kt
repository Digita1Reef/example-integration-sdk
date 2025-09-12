package com.siprocalsdkreactnativeplugin

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.facebook.react.modules.core.DeviceEventManagerModule
import com.siprocal.sdk.client.SiprocalSDK
import com.siprocal.sdk.client.EnumManager
import com.siprocal.sdk.client.notificationcenter.NotificationData
import com.siprocal.sdk.client.notificationcenter.NotificationDataListener
import com.siprocal.sdk.client.notificationcenter.NotificationEventListener
import com.siprocal.sdk.client.notificationcenter.NotificationEventType
import com.siprocal.sdk.ui.permission.SiprocalPermissionsSettings
import org.json.JSONException
import org.json.JSONObject
import com.google.gson.Gson;

import android.app.Activity;

import android.util.Log

private const val TAG = "SiprocalsdkReactnative"

class SiprocalsdkReactnativePluginModule(private val reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext)  {

  override fun getName(): String {
    return NAME
  }

  companion object {
    const val NAME = "SiprocalsdkReactnativePlugin"
  }

  @ReactMethod
  fun invokeFCM(message:String) {
     try {
          val payload=message.replace("\\\"","\"").replace("\"{","{").replace("}\"","}")
          val json=  JSONObject(payload)
    
          val fcmData = json.optJSONObject("fcmData")
          val isCampaign = fcmData?.optBoolean("adAvailable")

          SiprocalSDK.handleFCMMessage(payload.toString())
        } catch (ex : JSONException) {
          ex.message?.let { Log.e(TAG,it) }
        }
    
  }

  @ReactMethod
  fun refreshToken() {
    try{
      SiprocalSDK.refreshFCMToken(reactContext)
    } catch (ex : Exception) {
      ex.message?.let { Log.e(TAG,it) }
    }
    
  }

  @ReactMethod
  fun setSensitiveDataSwitch(isAccepted: Boolean) {
    SiprocalSDK.setSensitiveData(isAccepted)
  }

  @ReactMethod
  fun updateOptInStatus(isAccepted: Boolean) {
    SiprocalSDK.updateOptInStatus(reactContext,isAccepted)
  }

  @ReactMethod
  fun setSDKStatus(sdkStatus: Boolean) {
    SiprocalSDK.setSDKStatus(sdkStatus)
  }

  @ReactMethod
  fun setSensitivePermissionAppService(value: Boolean) {
    SiprocalSDK.setSensitivePermissionAppService(value)
  }

  @ReactMethod
  fun setSensitivePermissionPhoneServices(value: Boolean) {
    SiprocalSDK.setSensitivePermissionPhoneServices(value)
  }

  @ReactMethod
  fun setSensitivePermissionTelephonyServices(value: Boolean) {
    SiprocalSDK.setSensitivePermissionTelephonyServices(value)
  }

  @ReactMethod
  fun setClientAttributes(clientAttributes: String) {
    try{
      val jsonClientAttributes=  JSONObject(clientAttributes)
      SiprocalSDK.setClientAttributes(jsonClientAttributes)
    } catch (ex : Exception) {
      ex.message?.let { Log.e(TAG,it) }
    }
   
  }

  @ReactMethod
  fun trackInAppEvents(event: String) {
    try{
      SiprocalSDK.trackInAppEvents(reactContext, event)
    } catch (ex : Exception) {
      ex.message?.let { Log.e(TAG,it) }
    }
   
  }

 @ReactMethod
fun getSdkInformation(promise: Promise) {
    val sdkInformation = JSONObject().apply {
        put("SDK_VERSION", SiprocalSDK.getSdkInformation(EnumManager.SdkInformation.SDK_VERSION))
        put("BASE_ORG", SiprocalSDK.getSdkInformation(EnumManager.SdkInformation.BASE_ORG))
        put("ORG", SiprocalSDK.getSdkInformation(EnumManager.SdkInformation.ORG))
        put("ORG_ID", SiprocalSDK.getSdkInformation(EnumManager.SdkInformation.ORG_ID))
        put("TYPE_ORG", SiprocalSDK.getSdkInformation(EnumManager.SdkInformation.TYPE_ORG))
        put("COUNTRY_CODE", SiprocalSDK.getSdkInformation(EnumManager.SdkInformation.COUNTRY_CODE))
        put("STATE_SDK", SiprocalSDK.getSdkInformation(EnumManager.SdkInformation.STATE_SDK))
        put("CLIENT_ID", SiprocalSDK.getSdkInformation(EnumManager.SdkInformation.CLIENT_ID))
        put("SENSITIVE_DATA", SiprocalSDK.getSdkInformation(EnumManager.SdkInformation.SENSITIVE_DATA))
    }

    promise.resolve(sdkInformation.toString())
}


  @ReactMethod
  fun setCountryCodeSelected(countryCode: String) {
    SiprocalSDK.setCountryCodeSelected(reactContext,countryCode)
  }

  @ReactMethod
  fun getCountryCodeSelected(promise: Promise) {
    promise.resolve(SiprocalSDK.getCountryCodeSelected())
  }

  @ReactMethod
  fun getFCMSenderId(promise: Promise) {
    promise.resolve(SiprocalSDK.getFCMSenderId())
  }

  @ReactMethod
  fun getNotificationChannelId(promise: Promise) {
    promise.resolve(SiprocalSDK.getNotificationChannelId())
  }

  @ReactMethod
  fun getNotificationChannelName(promise: Promise) {
    promise.resolve(SiprocalSDK.getNotificationChannelName())
  }

  @ReactMethod
  fun getOptInStatus(promise: Promise) {
    promise.resolve(SiprocalSDK.getOptInStatus())
  }

  @ReactMethod
  fun requestPermissionForGL() {
    val activity = getCurrentActivity();
    if(reactContext!=null && activity!=null){
      SiprocalSDK.requestPermissionForGL(activity)
    }
  }
  
  @ReactMethod
  fun showAvailableAd() {
    val activity = getCurrentActivity();
    if(reactContext!=null && activity!=null){
      SiprocalSDK.showAvailableAd(activity)
    }
  }
  
}
