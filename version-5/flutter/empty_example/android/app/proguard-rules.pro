-dontwarn org.slf4j.impl.StaticLoggerBinder

# Keep all classes that are marked as @Serializable
-keep @kotlinx.serialization.Serializable class * { *; }

# Keep all generated serializer companions
-keepclassmembers class * {
    kotlinx.serialization.KSerializer serializer(...);
}

-dontwarn java.lang.management.ManagementFactory
-dontwarn java.lang.management.RuntimeMXBean
-dontwarn java.lang.reflect.AnnotatedType
-dontwarn org.slf4j.impl.StaticMDCBinder
-dontwarn org.slf4j.impl.StaticMarkerBinder