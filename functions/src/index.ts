//import firebase functions modules
const functions = require('firebase-functions');
//import admin module
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

exports.sendNotification = functions.firestore
  .document('chats/{chatId}/messages/{messageId}')
  .onCreate((snapshot, context) => {
    const messageData = snapshot.data();

       const payload = {
          notification: {
            title: 'New Message',
            body: messageData.text,
            clickAction: 'FLUTTER_NOTIFICATION_CLICK',
          },
        };

    //Create an options object that contains the time to live for the notification and the priority
    const options = {
        priority: "high",
        timeToLive: 60 * 60 * 24
    };

    return admin.messaging().sendToTopic(messageData.receiverId, payload, options);
});