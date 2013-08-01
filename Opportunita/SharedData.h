//
//  SharedData.h
//  koara2
//
//  Created by sp2lc on 2013/04/24.
//  Copyright (c) 2013年 sp2lc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedData : NSObject

+ (id)instance;

// データをキーとともに追加します
- (void)setData:(id)anObject forKey:(id) aKey;

// 指定したキーに対応するデータを返します
- (id)getDataForKey:(id)aKey;

// 指定したキーと、それに対応するデータを、辞書から削除します
- (void)removeDataForKey:(id)aKey;

@end
