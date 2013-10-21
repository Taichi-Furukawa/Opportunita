//
//  Texture.m
//  Opportunita
//
//  Created by furukawa on 2013/10/03.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "Texture.h"
#import "SharedData.h"

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
    UIImage *uiImage=[[UIImage alloc]init];
    
    SharedData *sh=[SharedData instance];
    NSArray *ar_array=[sh getDataForKey:@"ar_field"];
    NSString *topics_id=[[ar_array objectAtIndex:filename] objectForKey:@"Topics_ID"];
    NSArray *topics_array=[NSArray array];
    topics_array=[sh getDataForKey:@"timeline"];
    NSString *topics=[[NSString alloc]init];
    for (NSDictionary *dic in topics_array){
        if ([topics_id isEqualToString:[dic objectForKey:@"Topics_ID"]]==YES) {
            topics=[dic objectForKey:@"Subject"];
            NSLog(@"topics=%@",topics);
        }
    }
    NSLog(@"hello %@",topics);
    UILabel *label=[[UILabel alloc]init];
    UIView *vi=[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 256.0, 256.0)];
    label.frame=CGRectMake(vi.center.x, vi.center.y, 100.0f, 230.0f);
    [vi setBackgroundColor:[UIColor whiteColor]];
    [vi addSubview:label];
    label.text=topics;
    label.font =[UIFont systemFontOfSize:15];
    uiImage=[self imageFromView:vi];
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
- (UIImage *)imageFromView:(UIView *)view{
UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0);
CGContextRef context = UIGraphicsGetCurrentContext();
CGContextTranslateCTM(context, -view.frame.origin.x, -view.frame.origin.y);
[view.layer renderInContext:context];
UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

return renderedImage;
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
