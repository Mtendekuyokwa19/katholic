package com.example.njirayamtanda

import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class CatholicReadingWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: android.widget.AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.content.SharedPreferences
    ) {
        context?.let { ctx ->
            // There may be multiple widgets active, so update all of them
            for (appWidgetId in appWidgetIds) {
                updateAppWidget(ctx, appWidgetManager, appWidgetId, widgetData)
            }
        }
    }

    companion object {
        fun updateAppWidget(
            context: Context,
            appWidgetManager: android.widget.AppWidgetManager,
            appWidgetId: Int,
            widgetData: android.content.SharedPreferences
        ) {
            // Construct the RemoteViews object
            val views = RemoteViews(context.packageName, R.layout.catholic_reading_widget)
            
            // Set up the widget layout and data
            // You would typically set text, images, etc. here
            
            // Instruct the widget manager to update the widget
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}