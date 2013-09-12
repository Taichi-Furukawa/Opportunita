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
-(void)receiveFav_table:(NSString*)responce;
-(void)receiveJoin_table:(NSString*)responce;
-(void)receiveWait_column:(NSString*)responce;
-(void)receiveAR_field:(NSString*)responce;
@end

@interface OppConnection : NSData{
    NSString *Method_name;
}
+(id)instance;
-(void)login_and_DeviceToken:(NSString*)devicetoken;
-(void)get_Timeline;
-(void)get_Favtable;
-(void)get_Jointable;
-(void)get_Waitcolumn;
-(void)get_ARfield;
-(void)logOut;
-(void)send_Subject:(NSString*)IncertSubject MyUserID:(NSString*)user_ID;
-(void)favorite_Topics:(NSString*)Topics_ID MyUserID:(NSString*)user_ID;
-(void)join_Topics:(NSString*)Topics_ID MyUserID:(NSString*)user_ID;
-(void)leave_join_topics:(NSString*)Topics_ID MyUserID:(NSString*)user_ID;

@property(assign,nonatomic) id <OppDelegate> delegate;
@property(retain,nonatomic)NSURLConnection *connect;
@property(retain,nonatomic)NSMutableURLRequest *request;
@property(retain,nonatomic)NSError *error;
@property(retain,nonatomic)NSData *responceData;
@property(retain,nonatomic)NSString *responceString;
@end
