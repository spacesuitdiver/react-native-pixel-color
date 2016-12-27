import {
  NativeModules,
} from 'react-native';

export default {
  getHex: (path, coords) => new Promise((resolve, reject) => {
    NativeModules.RNPixelColor.getHex(path, coords, (err, color) => {
      if (err) return reject(err);

      resolve(color);
    });
  })
};
