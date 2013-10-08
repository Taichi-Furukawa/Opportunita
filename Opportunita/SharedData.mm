//
//  SharedData.m
//  koara2
//
//  Created by sp2lc on 2013/04/24.
//  Copyright (c) 2013年 sp2lc. All rights reserved.
//

#import "SharedData.h"

@implementation SharedData {
    NSMutableDictionary* dictionary;
}

// 初期化  
- (id)init
{
    self =  [super init];
    if(self) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

// インスタンスの取得（外部のクラスからはこちらを呼ぶ）
+ (id)instance
{
    static id _instance = nil;
    @synchronized(self) {
        if(!_instance) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

// データをキーとともに追加します
- (void)setData:(id) anObject forKey:(id) aKey
{
    @synchronized(dictionary) {
        [dictionary setObject:anObject forKey:aKey];
    }
}

// 指定したキーに対応するデータを返します
- (id)getDataForKey:(id)aKey
{
    id retval = [dictionary objectForKey:aKey];
    return retval != [NSNull null] ? retval : nil;
}

// 指定したキーと、それに対応するデータを、辞書から削除します
- (void)removeDataForKey:(id)aKey
{
    @synchronized(dictionary) {
        [dictionary removeObjectForKey:aKey];
    }
}

@end
