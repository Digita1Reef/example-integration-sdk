'use strict'

import { NativeModules, NativeEventEmitter, Platform } from 'react-native';

const RCTDigitalReefSDK = NativeModules.IuLibraryModule;
const myModuleEvt = new NativeEventEmitter(RCTDigitalReefSDK);

export default class IuLibraryModule {

	static invokeFCM(message: string) {
        if (Platform.OS == 'android') RCTDigitalReefSDK.invokeFCM(message);
    }
    static refreshToken() {
        if (Platform.OS == 'android') RCTDigitalReefSDK.refreshToken();
    }

    static initiOS() {
        if (Platform.OS == 'ios') RCTDigitalReefSDK.initiOS();
    }
    static requestPushPermission() {
        if (Platform.OS == 'ios') RCTDigitalReefSDK.requestPushPermission();
    }
    static addListener(name: any, callback: Function) {
        myModuleEvt.addListener(name, callback);
    }

    static sendEventWithName(eventName: string){
      
        RCTDigitalReefSDK.sendEventWithName(eventName);
    }

    static requestAppTrackingTransparencyPermission(){
        if (Platform.OS == 'ios') RCTDigitalReefSDK.requestAppTrackingTransparencyPermission();
    }
    static setClientAttributes(clientAttributes: any){
        if (Platform.OS == "ios") {
            // If it's iOS and string, JSON.parse() and send to SDK
            // If it's iOS and object, send to SDK
            if (typeof clientAttributes === "string") {
                clientAttributes = JSON.parse(clientAttributes);
            }            
        } else {
            // If it's Android and object, JSON.stringify
            // If it's Android and string, send to SDK
            if (typeof clientAttributes === "object") {
                clientAttributes = JSON.stringify(clientAttributes);
            }
        }
        RCTDigitalReefSDK.setClientAttributes(clientAttributes);
    }
    static updateOptInStatusForEngagement(optIn: boolean){
        RCTDigitalReefSDK.updateOptInStatusForEngagement(optIn)
    }
    static updateOptInStatus(optIn: boolean){
        RCTDigitalReefSDK.updateOptInStatus(optIn)
    }
    static getOptInStatusForEngagement(callback: any){
        RCTDigitalReefSDK.getOptInStatusForEngagement(callback)
    }
    static getOptInStatus(callback: any){
        RCTDigitalReefSDK.getOptInStatus(callback)
    }

    static setAppPermissionStatus(appPermissionsStatus: boolean){
     if (Platform.OS == 'android') {
        RCTDigitalReefSDK.setAppPermissionStatus(appPermissionsStatus)
        }
    }
	
    static getAppPermissionStatus(callback: any){
     if (Platform.OS == 'android') {
        RCTDigitalReefSDK.getAppPermissionStatus(callback)
      }
    }

    static createOrganisationFromCountryCode(countryCode: string){
	
       RCTDigitalReefSDK.createOrganisationFromCountryCode(countryCode);
    }
    
    static setSensitiveDataSwitch(sensitiveData: boolean){
         if (Platform.OS == 'android') {
          RCTDigitalReefSDK.setSensitiveDataSwitch(sensitiveData)
         }
    }

    static saveFCMToken(hostAppFCMToken: boolean){
     if (Platform.OS == 'android') {
        RCTDigitalReefSDK.saveFCMToken(hostAppFCMToken)
      }
    }

    static requestNotificationPermission(){
        if (Platform.OS == 'android')  {
           RCTDigitalReefSDK.requestNotificationPermission()
        }
    }

    static launchPendingPermissions(){
        if (Platform.OS == 'android')  {
           RCTDigitalReefSDK.launchPendingPermissions()
        }
    }
	
    static addOTAPromotionReceiverListener(){
        if (Platform.OS == 'android')  {
           RCTDigitalReefSDK.addOTAPromotionReceiverListener()
        }
    }

    static addNotificationListener(){
        if (Platform.OS == 'android')  {
           RCTDigitalReefSDK.addNotificationListener()
        }
    }

    static removeOTAPromotionReceiverListener(){
        if (Platform.OS == 'android')  {
           RCTDigitalReefSDK.removeOTAPromotionReceiverListener()
        }
    }

    static removeNotificationListener(){
        if (Platform.OS == 'android')  {
           RCTDigitalReefSDK.removeNotificationListener()
        }
    }

    static syncOTAWithHost(){
        if (Platform.OS == 'android')  {
           RCTDigitalReefSDK.syncOTAWithHost()
        }
    }

    static async getStatus () {
        if (Platform.OS === 'android') {
          try {
            const status = await RCTDigitalReefSDK.getSDKstatus();
            return status;
          } catch (error) {
            console.error(error);
            return 'no data';
          }
        }
        return 'Platform not supported';
      }

}