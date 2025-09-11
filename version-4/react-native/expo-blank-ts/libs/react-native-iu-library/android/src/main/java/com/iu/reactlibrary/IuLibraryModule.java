package com.iu.reactlibrary;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.google.gson.Gson;

import android.app.Application;
import android.content.Context;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import amazonia.iu.com.amlibrary.client.IUApp;
import amazonia.iu.com.amlibrary.client.NotificationsListener;
import amazonia.iu.com.amlibrary.client.OTAPromotionReceiverListener;
import amazonia.iu.com.amlibrary.client.OtaEvent;
import amazonia.iu.com.amlibrary.data.OtaPromotion;

public class IuLibraryModule extends ReactContextBaseJavaModule
        implements OTAPromotionReceiverListener, NotificationsListener {

    private final String TAG = IuLibraryModule.class.getName();
    private final boolean IS_DEBUG = false;
    private static final String EVENT_NAME = "EVENT_NAME";
    // DO NOT CHANGE THE MODULE NAME
    private final String IU_LIBRARY_MODULE = "IuLibraryModule";

    private final ReactApplicationContext reactContext;
    private OtaPromotion localOtaPromotion = null;

    public IuLibraryModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        // Llama directo al SDK (no a un @ReactMethod)
        IUApp.launch(reactContext);
    }

    // Estos constructores extra no los usa RN normalmente, se conservan por compatibilidad
    public IuLibraryModule(Application application, ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        IUApp.init(application, HostComplianceActivity.class);
    }

    public IuLibraryModule(Application application, ReactApplicationContext reactContext, Class<?> hostActivity) {
        super(reactContext);
        this.reactContext = reactContext;
        IUApp.init(application, hostActivity);
    }

    @Override
    public String getName() {
        return IU_LIBRARY_MODULE;
    }

    /** ----------- FIX: versiones sin parámetros (tipos bridgeables) ----------- */

    @ReactMethod
    public void initSDK() {
        Context app = getReactApplicationContext().getApplicationContext();
        IUApp.init((Application) app, HostComplianceActivity.class);
    }

    @ReactMethod
    public void initSDKManually() {
        // Si tu SDK tiene la variante manual, descomenta esto:
        // Context app = getReactApplicationContext().getApplicationContext();
        // IUApp.init((Application) app, HostComplianceActivity.class, true);
    }

    @ReactMethod
    public void launchSDK() {
        IUApp.launch(getReactApplicationContext());
    }

    /** ----------- Permanece igual el resto de API pública ----------- */

    @ReactMethod
    public void invokeFCM(String message) {
        if (IS_DEBUG) Log.e(TAG, "FCM Received in Module " + message);
        try {
            JSONObject jsonObject = new JSONObject(message);
            if (IS_DEBUG) {
                Log.d(TAG, "JSon from : " + jsonObject.getString("from") +
                        "   IU Sender : " + IUApp.getFCMSenderId());
            }
            if (jsonObject.getString("from").equals(IUApp.getFCMSenderId())) {
                IUApp.handleFCMMessage(reactContext, jsonObject);
            }
        } catch (JSONException ex) {
            if (IS_DEBUG) ex.printStackTrace();
        }
    }

    @ReactMethod
    public void refreshToken() {
        if (IS_DEBUG) Log.e(TAG, "FCM Token refresh in Module");
        try {
            IUApp.refreshFCMToken(reactContext);
        } catch (Exception ex) {
            if (IS_DEBUG) ex.printStackTrace();
        }
    }

    // TIM - Opt In related
    @ReactMethod
    public void updateOptInStatus(boolean optInStatus) {
        try {
            if (IS_DEBUG) Log.e(TAG, "OptIn -> " + optInStatus);
            IUApp.updateOptInStatus(reactContext, optInStatus);
        } catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @ReactMethod
    public void getOptInStatus(Callback booleanCallback) {
        try {
            booleanCallback.invoke(IUApp.getOptInStatus(reactContext));
        } catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    // Set Client Attributes
    @ReactMethod
    public void setClientAttributes(String string) {
        try {
            JSONObject jsonObject = new JSONObject(string);
            if (IS_DEBUG) Log.e(TAG, "Client Attributes : " + jsonObject);
            IUApp.setClientAttributes(reactContext, jsonObject);
        } catch (JSONException ex) { if (IS_DEBUG) ex.printStackTrace(); }
          catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @ReactMethod
    public void getFCMSenderId(Callback callback) {
        try { callback.invoke(IUApp.getFCMSenderId()); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @ReactMethod
    public void getSDKStatus(Callback callback) {
        try { callback.invoke(IUApp.getSDKStatus(reactContext)); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    // Alias para tu JS: getSDKstatus() (s minúscula)
    @ReactMethod
    public void getSDKstatus(Promise promise) {
        try { promise.resolve(IUApp.getSDKStatus(reactContext)); }
        catch (Exception e) { promise.reject("Error", e); }
    }

    // In App Events
    @ReactMethod
    public void sendEventWithName(String eventName) {
        try {
            if (eventName != null) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put(EVENT_NAME, eventName);
                IUApp.trackInAppEvents(getReactApplicationContext(), jsonObject);
            }
        } catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    // Opt In - Opt Out Engagement
    @ReactMethod
    public void updateOptInStatusForEngagement(boolean optInStatus) {
        try { IUApp.updateOptInStatusForEngagement(reactContext, optInStatus); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @ReactMethod
    public void getOptInStatusForEngagement(Callback booleanCallback) {
        try { booleanCallback.invoke(IUApp.getOptInStatusForEngagement(reactContext)); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    // New Methods
    @ReactMethod
    public void setAppPermissionStatus(boolean appPermissionsStatus) {
        try { IUApp.setAppPermissionStatus(reactContext, appPermissionsStatus); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @ReactMethod
    public void getAppPermissionStatus(Callback callback) {
        try { callback.invoke(IUApp.getAppPermissionStatus(reactContext)); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @ReactMethod
    public void createOrganisationFromCountryCode(String countryCode) {
        try { IUApp.createOrganisationFromCountryCode(reactContext, countryCode); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @ReactMethod
    public void getCurrentOrganizationName(Callback callback) {
        try { callback.invoke(IUApp.getCurrentOrganizationName(reactContext)); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @ReactMethod
    public void setSensitiveDataSwitch(boolean sensitiveData) {
        try { IUApp.setSensitiveDataSwitch(reactContext, sensitiveData); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @ReactMethod
    public void saveFCMToken(String hostAppFCMToken) {
        try { IUApp.saveFCMToken(reactContext, hostAppFCMToken); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    /** Android 13 Notification permission */
    @ReactMethod
    public void requestNotificationPermission() {
        IUApp.requestNotificationPermission(reactContext, granted -> {
            if (IS_DEBUG) Log.e(TAG, "RequestNotificationPermission: " + (granted ? "GRANTED" : "NO PERMISSION"));
        });
    }

    // COTA - OTA
    @ReactMethod
    public void addOTAPromotionReceiverListener() {
        try { IUApp.addOTAPromotionReceiverListener(this); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @Override
    public void onOTAPromotionReceived(OtaPromotion otaPromotion) {
        String json = serializeToJson(otaPromotion);
        if (json != null) {
            if (localOtaPromotion != null &&
                localOtaPromotion.getId().equalsIgnoreCase(otaPromotion.getId())) {
                return;
            } else {
                localOtaPromotion = otaPromotion;
            }
            reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                    .emit("OtaPromotionData", json);
        }
    }

    @ReactMethod
    public void addNotificationListener() {
        try { IUApp.addNotificationListener(this); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @ReactMethod
    public void removeOTAPromotionReceiverListener() {
        IUApp.removeOTAPromotionReceiverListener(this);
    }

    @ReactMethod
    public void removeNotificationListener() {
        IUApp.removeNotificationListener(this);
    }

    @Override
    public void onNotificationActionDismiss(String otaId, OtaEvent.Type type) {
        if (type == null) return;
        try {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("type", type.toString());
            jsonObject.put("otaId", otaId);
            reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                    .emit("OTAEventData", jsonObject.toString());
        } catch (JSONException ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    @ReactMethod
    public void syncOTAWithHost() {
        try { IUApp.syncOTAWithHost(reactContext); }
        catch (Exception ex) { if (IS_DEBUG) ex.printStackTrace(); }
    }

    public String serializeToJson(OtaPromotion data) {
        Gson gson = new Gson();
        return gson.toJson(data);
    }

    @ReactMethod
    public void getStatus(Promise promise) {
        try { promise.resolve(IUApp.getSDKStatus(getReactApplicationContext())); }
        catch (Exception e) { promise.reject("Error", e); }
    }
}