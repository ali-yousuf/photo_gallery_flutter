import Foundation
import Flutter
import Photos

class PhotoGalleryApiHandler: NSObject, PhotoGalleryNativeHostApi {
    func getAlbums() throws -> [Album] {
        var albums = [Album]()

        // Fetch albums from the photo library
        let fetchOptions = PHFetchOptions()
        let fetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)

        let dispatchGroup = DispatchGroup() // To wait for all async calls
        fetchResult.enumerateObjects { (collection, _, _) in
            dispatchGroup.enter() // Enter the group before processing

            let assetsFetchResult = PHAsset.fetchAssets(in: collection, options: nil)
            if assetsFetchResult.count > 0 {
                if let firstAsset = assetsFetchResult.firstObject {
                    self.getThumbnailForAsset(firstAsset) { thumbnail in
                        let album = Album(name: collection.localizedTitle ?? "Unknown", thumbnail: thumbnail)
                        albums.append(album)
                        dispatchGroup.leave() // Leave the group after processing
                    }
                } else {
                    albums.append(Album(name: collection.localizedTitle ?? "Unknown", thumbnail: "No thumbnail"))
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.wait() // Wait for all async calls to finish
        return albums
    }

    private func getThumbnailForAsset(_ asset: PHAsset, completion: @escaping (String) -> Void) {
        let imageManager = PHImageManager.default()
        let targetSize = CGSize(width: 100, height: 100) // Define the size of the thumbnail
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true

        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { image, _ in
            if let image = image {
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    let base64String = imageData.base64EncodedString()
                    completion(base64String)
                } else {
                    completion("Error: Unable to convert image to base64")
                }
            } else {
                completion("Error: Unable to fetch thumbnail")
            }
        }
    }
}
