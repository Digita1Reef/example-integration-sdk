import { StyleSheet } from "react-native";

export const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#1E3A8A", // Deep blue
    justifyContent: "center",
    alignItems: "center",
  },
  backgroundGradient: {
    position: "absolute",
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: "#1E3A8A",
    opacity: 0.9,
  },
  content: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    paddingHorizontal: 40,
    width: "100%",
  },
  logoContainer: {
    alignItems: "center",
    marginBottom: 60,
  },
  logoIcon: {
    fontSize: 80,
    marginBottom: 20,
  },
  logoText: {
    fontSize: 32,
    fontWeight: "bold",
    color: "#FFFFFF",
    marginBottom: 10,
    textAlign: "center",
  },
  logoSubtext: {
    fontSize: 16,
    color: "#E2E8F0",
    textAlign: "center",
    opacity: 0.8,
  },
  progressContainer: {
    width: "100%",
    alignItems: "center",
    marginBottom: 40,
  },
  statusText: {
    fontSize: 18,
    color: "#FFFFFF",
    marginBottom: 20,
    textAlign: "center",
    fontWeight: "500",
  },
  progressBarBackground: {
    width: "100%",
    height: 6,
    backgroundColor: "rgba(255, 255, 255, 0.2)",
    borderRadius: 3,
    marginBottom: 15,
    overflow: "hidden",
  },
  progressBarFill: {
    height: "100%",
    backgroundColor: "#10B981", // Green
    borderRadius: 3,
  },
  progressText: {
    fontSize: 16,
    color: "#E2E8F0",
    fontWeight: "600",
  },
  loadingContainer: {
    marginBottom: 60,
  },
  loadingDots: {
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
  },
  loadingDot: {
    width: 12,
    height: 12,
    borderRadius: 6,
    backgroundColor: "#10B981",
    marginHorizontal: 6,
  },
  footer: {
    position: "absolute",
    bottom: 50,
    alignItems: "center",
  },
  footerText: {
    fontSize: 14,
    color: "#E2E8F0",
    marginBottom: 5,
    fontWeight: "500",
  },
  versionText: {
    fontSize: 12,
    color: "#94A3B8",
    opacity: 0.7,
  },
});
