import {
  NativeModules,
} from 'react-native';

export default {
  getHex: (path, options) => new Promise((resolve, reject) => {
    NativeModules.RNPixelColor.getHex(path, options, (err, color) => {
      if (err) return reject(err);

      resolve(color);
    });
  })
};
