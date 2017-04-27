import {
  NativeModules,
} from 'react-native';

export default {
  createImage: (path, originalRotation) => new Promise((resolve, reject)=>{ 
    NativeModules.RNPixelColor.createImage(path, Number(originalRotation), (err, res) => {
      if (err) return reject(err);

      resolve(res);
    });
  }),

  getHex: (options) => new Promise((resolve, reject) => {
    NativeModules.RNPixelColor.getHex(options, (err, color) => {
      if (err) return reject(err);

      resolve(color);
      
    });
  })
};
