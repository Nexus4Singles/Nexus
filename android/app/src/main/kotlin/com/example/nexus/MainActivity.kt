package com.nexusapptest.app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle

class MainActivity: FlutterActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createNotificationChannel() // Call the method to create the notification channel
    }

    private fun createNotificationChannel() {
        // This will only run on Android 8.0 (API level 26) and above
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelId = "NEXUS"
            val channelName = "Nexus Notifications"
            val channelDescription = "Channel for Nexus app notifications"
            
            // Create a sound URI for default notification sound
            val soundUri: Uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)

            // Set the importance of the channel
            val importance = NotificationManager.IMPORTANCE_HIGH

            // Create the NotificationChannel
            val channel = NotificationChannel(channelId, channelName, importance).apply {
                description = channelDescription
                setSound(soundUri, null) // Set the sound for this channel
            }

            // Register the channel with the system
            val notificationManager: NotificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }
}
