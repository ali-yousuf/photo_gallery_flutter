package com.example.photo_gallery

import android.content.Context
import android.database.Cursor
import android.net.Uri
import android.provider.DocumentsContract
import android.provider.MediaStore

class UriToAbsolutePathConverter(private val context: Context) {

    fun convertToAbsolutePath(uri: Uri): String {
        val column = "_data"  // The column name to retrieve the file path
        val projection = arrayOf(column)
        var cursor: Cursor? = null
        try {
            // Check if the Uri is a document Uri (e.g., from storage provider)
            if (DocumentsContract.isDocumentUri(context, uri)) {
                // Handle external storage document Uri
                if (isExternalStorageDocument(uri)) {
                    val docId = DocumentsContract.getDocumentId(uri)
                    val split = docId.split(":")
                    val type = split[0]
                    if ("primary".equals(type, ignoreCase = true)) {
                        // Return the absolute path
                        return "${android.os.Environment.getExternalStorageDirectory()}/${split[1]}"
                    }
                }
                // Handle other cases (e.g., media store content)
                else if (isMediaDocument(uri)) {
                    val docId = DocumentsContract.getDocumentId(uri)
                    val split = docId.split(":")
                    val type = split[0]
                    val selection = "_id=?"
                    val selectionArgs = arrayOf(split[1])
                    val contentUri: Uri = when (type) {
                        "image" -> MediaStore.Images.Media.EXTERNAL_CONTENT_URI
                        "video" -> MediaStore.Video.Media.EXTERNAL_CONTENT_URI
                        "audio" -> MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
                        else -> return ""
                    }
                    cursor = context.contentResolver.query(contentUri, projection, selection, selectionArgs, null)
                }
            } else if ("content".equals(uri.scheme, ignoreCase = true)) {
                // Handle content URIs like images, videos, etc.
                cursor = context.contentResolver.query(uri, projection, null, null, null)
            }

            // If the cursor is valid, extract the file path
            cursor?.let {
                val columnIndex = cursor.getColumnIndexOrThrow(column)
                if (cursor.moveToFirst()) {
                    return cursor.getString(columnIndex)
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        } finally {
            cursor?.close()
        }
        return ""
    }

    // Helper function to check if the Uri is an external storage document
    private fun isExternalStorageDocument(uri: Uri): Boolean {
        return "com.android.externalstorage.documents" == uri.authority
    }

    // Helper function to check if the Uri is a media document (e.g., for images, audio, video)
    private fun isMediaDocument(uri: Uri): Boolean {
        return "com.android.providers.media.documents" == uri.authority
    }
}