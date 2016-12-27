# React Pixel Color

Returns the pixel color from a graphic at a given corrdinate.

## Setup

Install the package:

React-Native 0.29.2+

```
npm install --save react-native-pixel-color
react-native link react-native-pixel-color
```

React-Native < 0.29.2
```
npm install rnpm -g
rnpm install react-native-pixel-color
```

### Android

Note: on latest versions of React Native, you may have an error during the Gradle build on Android (`com.android.dex.DexException: Multiple dex files define Landroid/support/v7/appcompat/R$anim`). Run `cd android && ./gradlew clean` to fix this.

## Usage example

```javascript
import PixelColor from 'react-native-pixel-color';

PixelColor.getHex(imageUriOrData, x, y).then((color) => {
  // #000000
}).catch((err) => {
  // Oops, something went wrong. Check that the filename is correct and
  // inspect err to get more details.
});
```

### Sample app

Examples are found in the [the `examples` folder](https://github.com/bamlab/react-native-pixel-color/tree/master/examples).

## API

### `promise getHex(path, coords)`

The promise resolves with a string containing the uri of the new file.

Option | Description
------ | -----------
path | Path of image file, or a base64 encoded image string prefixed with 'data:image/imagetype' where `imagetype` is jpeg or png.
coords | { x: int, y: int }
