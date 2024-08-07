const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

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
          sound: "beep",
          channel_id: "HUNGRY",
          android_channel_id: "HUNGRY",
          priority: "high",
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
        console.log("e work joo!!");

        if (recipientToken) {
          await admin.messaging().sendToDevice(recipientToken, payload);
          console.log("Notification sent successfully");
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
            sound: "beep",
            channel_id: "HUNGRY",
            android_channel_id: "HUNGRY",
            priority: "high",
          },
        };


        await admin.messaging().sendToDevice(userTokens[0], payload);
        await admin.messaging().sendToDevice(userTokens[1], payload);


        console.log("Match notification sent successfully");
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

      if (before.myLikes.length < after.myLikes.length) {
        const userId = context.params.userId;
        const newLikeId = after.myLikes[after.myLikes.length - 1];

        const likerCol = await admin.firestore().collection("users");
        const likerDoc = likerCol.doc(newLikeId).get();
        if (!likerDoc.exists) {
          console.error("Liker document not found:", newLikeId);
          return;
        }
        const likerName = likerDoc.data().username;


        const payload = {
          notification: {
            title: "New Like",
            body: `${likerName} liked your profile.`,
            sound: "beep",
            channel_id: "HUNGRY",
            android_channel_id: "HUNGRY",
            priority: "high",
          },
        };

        const rcpCol = await admin.firestore().collection("users");
        const rcpDoc = rcpCol.doc(userId).get();
        if (!rcpDoc.exists) {
          console.error("Recipient document not found:", userId);
          return;
        }
        const recipientToken = rcpDoc.data().fcm_token;

        if (recipientToken) {
          await admin.messaging().sendToDevice(recipientToken, payload);
          console.log("Like notification sent successfully");
        } else {
          console.log("No FCM token for recipient:", userId);
        }
      }
    });
