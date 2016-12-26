import {
  NativeModules,
} from 'react-native';

export default {
  getPixelColor: (path, x, y) => new Promise((resolve, reject) => {
      NativeModules.RNPixelColor.getPixelColor(path, x, y, (err, color) => {
        if (err) {
          return reject(err);
        }

        resolve(color);
      });
    });
  },
};
