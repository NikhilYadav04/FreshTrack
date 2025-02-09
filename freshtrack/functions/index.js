const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(); // Initialize Firebase Admin SDK

exports.sendBackgroundNotification = functions.https.onCall(
  async (data, context) => {
    const { title, body, fcmToken } = data;

    if (!fcmToken) {
      return { success: false, error: "Missing FCM Token" };
    }

    const payload = {
      notification: {
        title: title || "Default Title",
        body: body || "Default Body",
      },
      token: fcmToken,
    };

    try {
      await admin.messaging().send(payload);
      return { success: true };
    } catch (error) {
      console.error("Error sending FCM:", error);
      return { success: false, error: error.message };
    }
  }
);
