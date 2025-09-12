import { NativeModules, Platform, NativeEventEmitter } from "react-native";

const LINKING_ERROR =
  `The package 'siprocalsdk-reactnative-plugin' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: "" }) +
  "- You rebuilt the app after installing the package\n" +
  "- You are not using Expo Go\n";

const SiprocalsdkReactnativePlugin = NativeModules.SiprocalsdkReactnativePlugin
  ? NativeModules.SiprocalsdkReactnativePlugin
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export default class SiprocalPluginModule {
  static getSdkInformation() {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.getSdkInformation();
    } else {
      return new Promise((resolve) => {
        resolve("");
      });
    }
  }

  static updateOptInStatus(value) {
    return SiprocalsdkReactnativePlugin.updateOptInStatus(value);
  }

  static setClientAttributes(clientAttributes) {
    if (Platform.OS === "ios") {
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
    return SiprocalsdkReactnativePlugin.setClientAttributes(clientAttributes);
  }

  static setCountryCodeSelected(countryCode) {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.setCountryCodeSelected(countryCode);
    } else if (Platform.OS === "ios") {
      return SiprocalsdkReactnativePlugin.createOrganisationFromCountryCode(
        countryCode
      );
    }
  }

  static getOptInStatus() {
    return SiprocalsdkReactnativePlugin.getOptInStatus();
  }

  static setSDKStatus(value) {
    return SiprocalsdkReactnativePlugin.setSDKStatus(value);
  }

  /*ANDROID METHOD */
  static invokeFCM(message) {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.invokeFCM(message);
    }
  }

  static refreshToken() {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.refreshToken();
    }
  }

  static setSensitiveDataSwitch(value) {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.setSensitiveDataSwitch(value);
    }
  }

  static setSensitivePermissionAppService(value) {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.setSensitivePermissionAppService(
        value
      );
    }
  }

  static setSensitivePermissionPhoneServices(value) {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.setSensitivePermissionPhoneServices(
        value
      );
    }
  }

  static setSensitivePermissionTelephonyServices(value) {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.setSensitivePermissionTelephonyServices(
        value
      );
    }
  }

  static getCountryCodeSelected() {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.getCountryCodeSelected();
    } else {
      return new Promise((resolve) => {
        resolve("");
      });
    }
  }

  static getFCMSenderId() {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.getFCMSenderId();
    } else {
      return new Promise((resolve) => {
        resolve("");
      });
    }
  }

  static getNotificationChannelId() {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.getNotificationChannelId();
    } else {
      return new Promise((resolve) => {
        resolve("");
      });
    }
  }

  static getNotificationChannelName() {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.getNotificationChannelName();
    } else {
      return new Promise((resolve) => {
        resolve("");
      });
    }
  }

  static requestPermissionForGL() {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.requestPermissionForGL();
    }
  }

  static showAvailableAd() {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.showAvailableAd();
    }
  }

  static sendEvent(eventName) {
    if (Platform.OS === "android") {
      return SiprocalsdkReactnativePlugin.trackInAppEvents(eventName);
    } else {
      return SiprocalsdkReactnativePlugin.sendEventWithName(eventName);
    }
  }

  /* IOS METHOD */

  static requestPushPermissioniOS() {
    if (Platform.OS === "ios") {
      return SiprocalsdkReactnativePlugin.requestPushPermission();
    }
  }

  static requestAppTrackingTransparencyPermissioniOS() {
    if (Platform.OS === "ios") {
      return SiprocalsdkReactnativePlugin.requestAppTrackingTransparencyPermission();
    }
  }
}
