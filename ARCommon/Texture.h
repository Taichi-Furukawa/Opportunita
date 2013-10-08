//
//  Texture.h
//  Opportunita
//
//  Created by furukawa on 2013/10/03.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Texture : NSObject {
    int width;
    int height;
    int channels;
    int textureID;
    unsigned char* pngData;
}

@property (nonatomic, readonly) int width;
@property (nonatomic, readonly) int height;
@property (nonatomic) int textureID;
@property (nonatomic, readonly) unsigned char* pngData;

- (BOOL)loadImage:(NSInteger)filename;

@end
