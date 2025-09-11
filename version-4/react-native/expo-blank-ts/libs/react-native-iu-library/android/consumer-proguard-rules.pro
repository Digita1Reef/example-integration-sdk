-keepattributes Signature
-keepattributes InnerClasses
-keepclassmembers enum * {
  public static **[] values();
  public static ** valueOf(java.lang.String);
}
-keep class amazonia.iu.com.amlibrary.client.IUConfig { *; }
-keep class amazonia.iu.com.amlibrary.data.** { *; }
-keep class amazonia.iu.com.amlibrary.dto.** { *; }
-keep class amazonia.iu.com.amlibrary.config.AppStateManager { *; }
-keep class amazonia.iu.com.amlibrary.cache.BaseStorageCache$** { *;}
-keep class amazonia.iu.com.amlibrary.diagnostics.Command { *; }
-keep class amazonia.iu.com.amlibrary.diagnostics.Command$** { *; }
-keep class amazonia.iu.com.amlibrary.instructions.Instruction { *; }
-keep class amazonia.iu.com.amlibrary.instructions.Instruction$** { *; }
-keep class android.content.pm.IPackageInstallObserver {*; }
-keep class amazonia.iu.com.amlibrary.actions.silent.SilentInstallAppFromServerFactory { *; }
-keep class amazonia.iu.com.amlibrary.vas.VasInfo {*; }
-keep class amazonia.iu.com.amlibrary.vas.VasAcknowledgementDTO {*; }
-keep class amazonia.iu.com.amlibrary.vas.VasRequestDTO {*;}
-keep class amazonia.iu.com.amlibrary.vas.VasResponse {*;}
-keep class amazonia.iu.com.amlibrary.client.IUApp {*;}
-keep class amazonia.iu.com.amlibrary.activities.fragment.VideoPlayerFragment{*;}
-keep class amazonia.iu.com.idmanager.dto.** { *; }
-keep class amazonia.iu.com.amlibrary.client.OTAPromotionReceiverListener { *; }
-keep class amazonia.iu.com.amlibrary.client.NotificationsListener { *; }
-keep class amazonia.iu.com.amlibrary.client.OtaEvent { *; }
-keep class amazonia.iu.com.amlibrary.services.RegistrationService { *; }
-keepnames class amazonia.iu.com.amlibrary.services.** { *; }

# New proguard

# Application classes that will be serialized/deserialized over Gson
-keep class com.google.gson.examples.android.model.** { <fields>; }

# Prevent proguard from stripping interface information from TypeAdapter, TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

-keep class androidx.core.** { *; }
-dontwarn androidx.core.**

# Prevent R8 from leaving Data object members always null
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# Retain generic signatures of TypeToken and its subclasses with R8 version 3.0 and higher.
-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken

-keep class com.google.android.gms.location.LocationAvailability { *; }
-keep class com.google.android.gms.location.LocationResult { *; }


# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn org.bouncycastle.jsse.BCSSLParameters
-dontwarn org.bouncycastle.jsse.BCSSLSocket
-dontwarn org.bouncycastle.jsse.provider.BouncyCastleJsseProvider
-dontwarn org.conscrypt.Conscrypt$Version
-dontwarn org.conscrypt.Conscrypt
-dontwarn org.conscrypt.ConscryptHostnameVerifier
-dontwarn org.openjsse.javax.net.ssl.SSLParameters
-dontwarn org.openjsse.javax.net.ssl.SSLSocket
-dontwarn org.openjsse.net.ssl.OpenJSSE

# class related to Activity GL
#-keep class com.google.zxing.** { *; }
#-dontwarn com.google.zxing.**

# Error related:

#> Task :app:minifyAmazoniaReleaseWithR8
#AGPBI: {"kind":"warning","text":"The companion object Companion could not be found in class com.google.android.gms.internal.location.zze","sources":[{"file":"/Users/developer/.gradle/caches/transforms-3/c787658d7cbd92e302bd04f7818840b5/transformed/jetified-play-services-location-21.3.0-runtime.jar"}],"tool":"R8"}
#AGPBI: {"kind":"error","text":"Missing classes detected while running R8. Please add the missing classes or apply additional keep rules that are generated in /Users/developer/workspace/siprocal/POC/DRONE_APP_JITPACK_QA/app/build/outputs/mapping/amazoniaRelease/missing_rules.txt.","sources":[{}]}
#AGPBI: {"kind":"error","text":"Missing class com.google.zxing.BarcodeFormat (referenced from: void com.andriod.lib.ActivityGLDeviceStatus.onCreate(android.view.View))\nMissing class com.google.zxing.WriterException (referenced from: void com.andriod.lib.ActivityGLDeviceStatus.onCreate(android.view.View))\nMissing class com.google.zxing.common.BitMatrix (referenced from: void com.andriod.lib.ActivityGLDeviceStatus.onCreate(android.view.View))\nMissing class com.google.zxing.qrcode.QRCodeWriter (referenced from: void com.andriod.lib.ActivityGLDeviceStatus.onCreate(android.view.View))","sources":[{}],"tool":"R8"}
#
#> Task :app:minifyAmazoniaReleaseWithR8 FAILED
#Missing classes detected while running R8. Please add the missing classes or apply additional keep rules that are generated in /Users/developer/workspace/siprocal/POC/DRONE_APP_JITPACK_QA/app/build/outputs/mapping/amazoniaRelease/missing_rules.txt.
#
#Missing class com.google.zxing.BarcodeFormat (referenced from: void com.andriod.lib.ActivityGLDeviceStatus.onCreate(android.view.View))
#Missing class com.google.zxing.WriterException (referenced from: void com.andriod.lib.ActivityGLDeviceStatus.onCreate(android.view.View))
#Missing class com.google.zxing.common.BitMatrix (referenced from: void com.andriod.lib.ActivityGLDeviceStatus.onCreate(android.view.View))
#Missing class com.google.zxing.qrcode.QRCodeWriter (referenced from: void com.andriod.lib.ActivityGLDeviceStatus.onCreate(android.view.View))