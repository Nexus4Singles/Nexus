const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

/**
 * Helper function to send FCM notification using the v1 API.
 *
 * @param {string} token - The FCM token of the recipient device.
 * @param {Object} payload - The notification payload containing title, body,
 * sound, and other details.
 * @return {Promise<void>} - A promise that resolves when the
 * notification is sent successfully.
 */
async function sendFCMNotification(token, payload) {
  const message = {
    token: token,
    notification: {
      title: payload.notification.title,
      body: payload.notification.body,
    },
    android: {
      notification: {
    
        channel_id: payload.notification.channel_id,
        icon: payload.notification.icon,
      },
    },
    apns: { // This is for iOS notifications
      payload: {
        aps: {
        }
      } 
    },
    data: payload.data, // Add custom data if needed
  };

  try {
    await admin.messaging().send(message);
    console.log("Notification sent successfully");
  } catch (error) {
    console.error("Error sending notification:", error);
  }
}

exports.sendMessageNotification = functions.firestore
    .document("conversations/{conversationId}/messages/{messageId}")
    .onCreate(async (snap, context) => {
      const message = snap.data();
      const rcpId = message.recipientId;
      const senderId = message.sentBy;


      const payload = {
        notification: {
          title: "New Message",
          body: "", // To be set dynamically
          channel_id: "NEXUS",
          android_channel_id: "NEXUS",
          priority: "high",
          icon: "ic_stat_ic_launcher_nbg",
        },
        data: {
          rcpId: rcpId,
          senderId: senderId,
          conversationId: context.params.conversationId,
          messageId: context.params.messageId,
        },
      };

      try {
        const senderRef = admin.firestore().collection("users").doc(senderId);
        const senderDoc = await senderRef.get();
        if (!senderDoc.exists) {
          console.error("Sender document not found:", senderId);
          return;
        }
        const senderName = senderDoc.data().username;

        payload.notification.body = `${senderName} sent you a message`;

        const recipientRef = admin.firestore().collection("users").doc(rcpId);
        const recipientDoc = await recipientRef.get();
        if (!recipientDoc.exists) {
          console.error("Recipient document not found:", rcpId);
          return;
        }
        const recipientToken = recipientDoc.data().fcm_token;

        if (recipientToken) {
          try {
            await sendFCMNotification(recipientToken, payload);
            console.log("Notification sent successfully");
          } catch (error) {
            console.error("Error sending notification:", error);
          }
        } else {
          console.log("No FCM token for recipient:", rcpId);
        }
      } catch (error) {
        console.error("Error sending notification:", error);
      }
    });


// Match Notification
exports.sendMatchNotification = functions.firestore
    .document("matches/{matchId}")
    .onCreate(async (snap, context) => {
      const matchData = snap.data();
      const userIds = matchData.matchedUsers;

      try {
        const userDocs = [];
        for (const userId of userIds) {
          const userCol = await admin.firestore().collection("users");
          const userDoc = await userCol.doc(userId).get();
          userDocs.push(userDoc);
        }

        const userTokens = [];
        for (const userDoc of userDocs) {
          const token = userDoc.data().fcm_token;
          if (token) {
            userTokens.push(token);
          }
        }

        const payload = {
          notification: {
            title: "New Match!",
            body: "You have a new match😍😍😍",
            channel_id: "NEXUS",
            android_channel_id: "NEXUS",
            priority: "high",
            icon: "ic_stat_ic_launcher_nbg",

          },
        };

        try {
          await sendFCMNotification(userTokens[0], payload);
          console.log("1st Match notification sent successfully");
        } catch (error) {
          console.error("Error sending 1st match notification:", error);
        }
        try {
          await sendFCMNotification(userTokens[1], payload);
          console.log("2nd Match notification sent successfully");
        } catch (error) {
          console.error("Error sending 2nd match notification:", error);
        }
        try {
         await admin.firestore().collection("matches").doc(matchId).delete();
         console.log(`Match document with ID ${matchId} deleted successfully`);
       } catch (deleteError) {
         console.error("Error deleting match document:", deleteError);
       }
      } catch (error) {
        console.error("Error sending match notification:", error);
      }
    });

// Likes Notification
exports.sendLikeNotification = functions.firestore
    .document("/users/{userId}")
    .onUpdate(async (change, context) => {
      const before = change.before.data();
      const after = change.after.data();
      // Check if a new like was added
      if (before.likeMe.length < after.likeMe.length) {
        const userId = context.params.userId;
        console.log(userId);
        const newLikeId = after.likeMe[after.likeMe.length - 1];
        console.log(newLikeId);

        try {
          // Get the liker document
          const likerDoc = await admin.firestore()
              .collection("users").doc(newLikeId).get();
          if (!likerDoc.exists) {
            console.error("Liker document not found:", newLikeId);
            return null;
          }
          const likerName = likerDoc.data().username;

          const payload = {
            notification: {
              title: "New Like",
              body: `${likerName} liked your profile.`,
              
              channel_id: "NEXUS",
              android_channel_id: "NEXUS",
              priority: "high",
              icon: "ic_stat_ic_launcher_nbg",
            },
          };

          // Get the recipient document
          const recipientDoc = await admin.firestore()
              .collection("users").doc(userId).get();
          if (!recipientDoc.exists) {
            console.error("Recipient document not found:", userId);
            return null;
          }
          const recipientToken = recipientDoc.data().fcm_token;

          if (recipientToken) {
            // Send notification
            await sendFCMNotification(recipientToken, payload);
            console.log("Like notification sent successfully");
          } else {
            console.log("No FCM token for recipient:", userId);
          }
        } catch (error) {
          console.error("Error sending like notification:", error);
        }
      }
      return null;
    });
