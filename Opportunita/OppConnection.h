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
-(void)ReceiveData:(NSString*)responce Method:(NSString*)method_name;
@end

@interface OppConnection : NSData{
    id <OppDelegate> delegate;
    NSString *Method_name;
}
+(id)instance;
-(void)login_and_DeviceToken:(NSString*)devicetoken;
-(void)get_Timeline;
-(void)logOut;
-(void)send_Subject:(NSString*)IncertSubject MyUserID:(NSString*)user_ID;
-(void)favorite_Topics:(NSString*)Topics_ID MyUserID:(NSString*)user_ID;
-(void)join_Topics:(NSString*)Topics_ID MyUserID:(NSString*)user_ID;

@property(assign,nonatomic) id <OppDelegate> deleagte;
@property(retain,nonatomic)NSURLConnection *connect;
@property(retain,nonatomic)NSMutableURLRequest *request;
@property(retain,nonatomic)NSError *error;
@property(retain,nonatomic)NSData *responceData;
@property(retain,nonatomic)NSString *responceString;
@end
