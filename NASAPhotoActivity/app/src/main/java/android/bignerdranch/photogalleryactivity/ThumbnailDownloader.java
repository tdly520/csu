package android.bignerdranch.photogalleryactivity;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Message;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

public class ThumbnailDownloader<T> extends HandlerThread {
    private static final String TAG = "ThumbnailDownloader";
    private static final int MESSAGE_DOWNLOAD = 0;

    private boolean mHasQuit = false;
    private Handler mRequestHandler;
    private final ConcurrentMap<T, String> mRequestMap = new ConcurrentHashMap<>();
    private final Handler mResponseHandler;
    private ThumbnailDownloadListener<T> mThumbnailDownloadListener;
    private final Context mContext;

    public interface ThumbnailDownloadListener<T> {
        void onThumbnailDownloaded(T target, Bitmap thumbnail, byte[] bytes, String url);
    }

    public void setThumbnailDownloadListener(ThumbnailDownloadListener<T> listener) {
        mThumbnailDownloadListener = listener;
    }

    public ThumbnailDownloader(Handler responseHandler, Context context) {
        super(TAG);
        mResponseHandler = responseHandler;
        mContext = context;
    }

    @Override
    protected void onLooperPrepared() {
        mRequestHandler = new Handler() {
            @Override
            public void handleMessage(Message msg) {
                if (msg.what == MESSAGE_DOWNLOAD) {
                    T target = (T) msg.obj;
                    Log.i(TAG, "Got a request for URL: " + mRequestMap.get(target));
                    handleRequest(target);
                }
            }
        };
    }

    @Override
    public boolean quit() {
        mHasQuit = true;
        return super.quit();
    }

    public void queueThumbnail(T target, String url) {
        Log.i(TAG, "Got a url: " + url);
        if (url == null) {
            mRequestMap.remove(target);
        } else {
            mRequestMap.put(target, url);
            mRequestHandler.obtainMessage(MESSAGE_DOWNLOAD, target).sendToTarget();
        }
    }

    public void clearQueue() {
        mRequestHandler.removeMessages(MESSAGE_DOWNLOAD);
        mRequestMap.clear();
    }

    private void handleRequest(final T target) {
        try {
            final String url = mRequestMap.get(target);
            if (url == null) {
                return;
            }

            Bitmap cachedBitmap = loadImageFromFile(url);
            if (cachedBitmap != null) {
                Log.i(TAG, "Loaded image from local cache");
                postToUI(target, cachedBitmap, null, url);
                return;
            }

            byte[] bitmapBytes = new FlickrFetcher().getUrlBytes(url);
            final Bitmap bitmap = BitmapFactory.decodeByteArray(bitmapBytes, 0, bitmapBytes.length);
            Log.i(TAG, "Bitmap created from network");

            saveImageToFile(url, bitmapBytes);
            postToUI(target, bitmap, bitmapBytes, url);

        } catch (IOException e) {
            Log.e(TAG, "Error downloading image: " + e);
        }
    }

    private void saveImageToFile(String url, byte[] imageBytes) {
        try {
            String fileName = String.valueOf(url.hashCode()) + ".jpg";
            File file = new File(mContext.getCacheDir(), fileName);
            FileOutputStream fos = new FileOutputStream(file);
            fos.write(imageBytes);
            fos.close();
            Log.i(TAG, "Image saved to: " + file.getAbsolutePath());
        } catch (IOException e) {
            Log.e(TAG, "Error saving image to file: " + e);
        }
    }

    private Bitmap loadImageFromFile(String url) {
        try {
            String fileName = String.valueOf(url.hashCode()) + ".jpg";
            File file = new File(mContext.getCacheDir(), fileName);
            if (file.exists()) {
                return BitmapFactory.decodeFile(file.getAbsolutePath());
            }
        } catch (Exception e) {
            Log.e(TAG, "Error loading image from file: " + e);
        }
        return null;
    }

    private void postToUI(final T target, final Bitmap bitmap, final byte[] bytes, final String url) {
        mResponseHandler.post(() -> {
            if (mRequestMap.get(target) != url || mHasQuit) {
                return;
            }
            mRequestMap.remove(target);
            if (mThumbnailDownloadListener != null) {
                mThumbnailDownloadListener.onThumbnailDownloaded(target, bitmap, bytes, url);
            }
        });
    }
}
