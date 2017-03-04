package eu.crowtec.rnpixelcolor;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;

import java.io.File;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import fr.bamlab.rnimageresizer.ImageResizer;

import java.io.IOException;


class RNPixelColorModule extends ReactContextBaseJavaModule {
    private Context context;

    public RNPixelColorModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.context = reactContext;
    }

    @Override
    public String getName() {
        return "RNPixelColor";
    }

    @ReactMethod
    public void getHex(String path, ReadableMap options, final Callback callback) {
        Bitmap image;
        if (path.startsWith("data:") || path.startsWith("file:")) {
          image = ImageResizer.loadBitmapFromBase64(path);
        } else {
          Uri imageUrl = Uri.parse(path);
          File file = ImageResizer.getFileFromUri(this.context, imageUrl);
          BitmapFactory.Options bitmapOptions = new BitmapFactory.Options();
          bitmapOptions.inJustDecodeBounds = true;
          try {
            image = ImageResizer.loadBitmap(this.context, file.getPath(), bitmapOptions);
          } catch(IOException e){
            callback.invoke("Error parsing bitmap. Error: " + e.getMessage(), null);
            return;
          }
        }

        if (image == null) {
          callback.invoke("Could not create image from given path.", null);
          return;
        }

        int x = (int) options.getDouble("x");
        int y = (int) options.getDouble("y");

        if (options.hasKey("width") && options.hasKey("height")) {
          int scaledWidth = options.getInt("width");
          int scaledHeight = options.getInt("height");

          int originalWidth = image.getWidth();
          int originalHeight = image.getHeight();

          x = x * (originalWidth / scaledWidth);
          y = y * (originalHeight / scaledHeight);

        }

        int color = colorAtPixel(image, x, y);

        callback.invoke(null, colorToHexString(color));
    }

    private int colorAtPixel(Bitmap bitmap, int x, int y) {
      return bitmap.getPixel(x, y);
    }

    private String colorToHexString(int color) {
        return String.format("#%06X", (0xFFFFFF & color));
    }


}
