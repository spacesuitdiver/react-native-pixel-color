import {
  NativeModules,
} from 'react-native';

export default {
  getHex: (path, options) => new Promise((resolve, reject) => {
    NativeModules.RNPixelColor.getHex(path, options, (err, color) => {
  createImage: (path, originalRotation) => new Promise((resolve, reject)=>{ 
    NativeModules.RNPixelColor.createImage(path, Number(originalRotation), (err, res) => {
      if (err) return reject(err);

      resolve(res);
    });
  }),
      if (err) return reject(err);

      resolve(color);
    });
  })
};
