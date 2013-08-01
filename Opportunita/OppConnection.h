//
//  OppConnection.h
//  Opportunita
//
//  Created by furukawa on 2013/07/11.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OppDelegate <NSObject>
@optional
-(void)ReceiveData:(NSString*)responce;
@end

@interface OppConnection : NSData{
    id <OppDelegate> delegate;
}
+(id)instance;
-(void)login_and_DeviceToken:(NSString*)devicetoken;
-(void)logOut;

@property(assign,nonatomic) id <OppDelegate> deleagte;
@property(retain,nonatomic)NSURLConnection *connect;
@property(retain,nonatomic)NSMutableURLRequest *request;
@property(retain,nonatomic)NSError *error;
@property(retain,nonatomic)NSData *responceData;
@property(retain,nonatomic)NSString *responceString;
@end
