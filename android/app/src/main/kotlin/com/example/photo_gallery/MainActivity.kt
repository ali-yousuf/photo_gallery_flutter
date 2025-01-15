package com.example.photo_gallery

import Album
import PhotoGalleryNativeHostApi
import android.content.ContentUris
import android.content.Context
import android.database.Cursor
import android.net.Uri
import android.provider.DocumentsContract
import android.provider.MediaStore
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity(), PhotoGalleryNativeHostApi {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        PhotoGalleryNativeHostApi.setUp(flutterEngine.dartExecutor.binaryMessenger, this)
    }

    override fun getAlbums(): List<Album> {
        val albums = mutableMapOf<String, MutableList<Long>>()
        val projection = arrayOf(
            MediaStore.Images.Media.BUCKET_DISPLAY_NAME,
            MediaStore.Images.Media._ID
        )
        val uri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        val sortOrder = "${MediaStore.Images.Media.DATE_ADDED} DESC"

        context.contentResolver.query(uri, projection, null, null, sortOrder)?.use { cursor ->
            val bucketColumn = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.BUCKET_DISPLAY_NAME)
            val idColumn = cursor.getColumnIndexOrThrow(MediaStore.Images.Media._ID)

            while (cursor.moveToNext()) {
                val bucketName = cursor.getString(bucketColumn) ?: "Unknown"
                val id = cursor.getLong(idColumn)
                albums.getOrPut(bucketName) { mutableListOf() }.add(id)
            }
        }

        val uriToAbsolutePathConverter = UriToAbsolutePathConverter(this)
        return albums.map { (name, ids) ->

            Album(
                name = name,
                thumbnail = uriToAbsolutePathConverter.convertToAbsolutePath(
                    ContentUris.withAppendedId(
                        uri,
                        ids.first()
                    )
                ),
                photoCount = ids.size.toLong(),
            )
        }
    }


}
