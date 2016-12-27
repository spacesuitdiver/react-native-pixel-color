#include "RNPixelColor.h"
#import "RCTImageLoader.h"

@implementation RNPixelColor

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(getHex:(NSString *)path
                  coords:(NSDictionary *)coords
                  callback:(RCTResponseSenderBlock)callback)
{
    NSInteger *x = [RCTConvert NSInteger:coords[@"x"]];
    NSInteger *y= [RCTConvert NSInteger:coords[@"y"]];

    [_bridge.imageLoader loadImageWithURLRequest:[RCTConvert NSURLRequest:path] callback:^(NSError *error, UIImage *image) {
        if (error || image == nil) { // if couldn't load from bridge create a new UIImage
            if ([path hasPrefix:@"data:"] || [path hasPrefix:@"file:"]) {
                NSURL *imageUrl = [[NSURL alloc] initWithString:path];
                image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            } else {
                image = [[UIImage alloc] initWithContentsOfFile:path];
            }

            if (image == nil) {
                callback(@[@"Could not create image from given path.", @""]);
                return;
            }
        }
        
        UIColor *color = pixelColorInImage(image, x, y);
        callback(@[[NSNull null], hexStringForColor(color)]);
     
    }];
}

UIColor * pixelColorInImage( UIImage* image, int x, int y ) {
    int foo = image.size.width;
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((image.size.width * y) + x ) * 4; // 4 bytes per pixel
    
    UInt8 red   = data[pixelInfo + 0];
    UInt8 green = data[pixelInfo + 1];
    UInt8 blue  = data[pixelInfo + 2];
    UInt8 alpha = data[pixelInfo + 3];
    CFRelease(pixelData);
    
    return [UIColor colorWithRed:red  /255.0f
                           green:green/255.0f
                            blue:blue /255.0f
                           alpha:alpha/255.0f];
}

NSString * hexStringForColor( UIColor* color ) {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"#%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];

    return hexString;
}

@end
