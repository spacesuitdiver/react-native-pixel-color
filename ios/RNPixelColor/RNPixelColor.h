#import <React/RCTBridge.h>
#import "UIImage+ColorAtPixel.h"

@interface RNPixelColor : NSObject <RCTBridgeModule>
    @property (nonatomic, strong) UIImage *image;
@end
