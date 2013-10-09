//
//  Texture.m
//  Opportunita
//
//  Created by furukawa on 2013/10/03.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "Texture.h"

@interface Texture (PrivateMethods)
- (BOOL)copyImageDataForOpenGL:(CFDataRef)imageData;
@end

@implementation Texture

@synthesize width, height, textureID, pngData;


- (id)init
{
    self = [super init];
    pngData = NULL;
    
    return self;
}


- (BOOL)loadImage:(NSInteger)filename
{
    BOOL ret = NO;
    
    // Build the full path of the image file
    //NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    //NSString* fullPath = [resourcePath stringByAppendingPathComponent:filename];
    
    // Create a UIImage with the contents of the file
    //UIImage* uiImage = [UIImage imageWithContentsOfFile:fullPath];
    UIImage *uiImage;
    if (filename == 0) {
        uiImage =[self imageWithColor:[UIColor redColor]];
    }else if (filename==1){
         uiImage =[self imageWithColor:[UIColor blueColor]];
    }else if (filename==2){
        uiImage =[self imageWithColor:[UIColor whiteColor]];
    }else if (filename==3){
        uiImage =[self imageWithColor:[UIColor greenColor]];
    }else if (filename==4){
                uiImage =[self imageWithColor:[UIColor orangeColor]];
    }else if (filename==5){
                uiImage =[self imageWithColor:[UIColor grayColor]];
    }else if (filename==6){
                uiImage =[self imageWithColor:[UIColor yellowColor]];
    }
    if (uiImage) {
        // Get the inner CGImage from the UIImage wrapper
        CGImageRef cgImage = uiImage.CGImage;
        
        // Get the image size
        width = CGImageGetWidth(cgImage);
        height = CGImageGetHeight(cgImage);
        
        // Record the number of channels
        channels = CGImageGetBitsPerPixel(cgImage)/CGImageGetBitsPerComponent(cgImage);
        
        // Generate a CFData object from the CGImage object (a CFData object represents an area of memory)
        CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(cgImage));
        
        // Copy the image data for use by Open GL
        ret = [self copyImageDataForOpenGL: imageData];
        CFRelease(imageData);
    }
    
    return ret;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



@end


@implementation Texture (TexturePrivateMethods)

- (BOOL)copyImageDataForOpenGL:(CFDataRef)imageData
{
    if (pngData) {
        delete[] pngData;
    }
    
    pngData = new unsigned char[width * height * channels];
    const int rowSize = width * channels;
    const unsigned char* pixels = (unsigned char*)CFDataGetBytePtr(imageData);
    
    // Copy the row data from bottom to top
    for (int i = 0; i < height; ++i) {
        memcpy(pngData + rowSize * i, pixels + rowSize * (height - 1 - i), width * channels);
    }
    
    return YES;
}

@end
