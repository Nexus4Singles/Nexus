// test
// const functions = require('firebase-functions');
// const admin = require('firebase-admin');
// admin.initializeApp();


// exports.sendNotification = functions.firestore
//     .document('notifications/{recipient_id}')
//     .onCreate(async (snap, context) => {

//         const data = snap.data();
//         console.log(data.title);
//      const doc = await admin.
//             firestore()
//             .collection('users')
//             .where('id', '==', data.recipient_id)
//             .get();
//         const userDoc = doc.docs[0].data();
//         // console.log(userDoc);
// console.log(userDoc['id'], 'id');
// console.log(userDoc['fcm'], 'fcm');
//     });



const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendNotification = functions.
    firestore
    .document('notifications/{recipient_id}')
    .onCreate(async (snap, _) => {
        const data = snap.data();
        const doc = await admin.
            firestore()
            .collection('users')
            .where('id', '==', data.recipient_id)
            .get();
        const userDoc = doc.docs[0].data();
        const payload = {
            notification: {
                title: 'New Notification',
                body: data.title || 'You have a new notification',
                sound: 'beep',
                priority: 'high',

            }
        }
        try {
            const response = await admin.messaging().sendToDevice(userDoc['fcm_token'], payload)
        } catch (error) {

        }
    })