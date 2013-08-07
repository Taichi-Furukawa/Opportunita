//
//  OppConnection.m
//  Opportunita
//
//  Created by furukawa on 2013/07/11.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppConnection.h"

@implementation OppConnection
@synthesize connect,request,responceData,responceString,deleagte;
BOOL login;
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

-(void)login_and_DeviceToken:(NSString*)devicetoken{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=login&devicetoken=%@",devicetoken];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/login.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}

-(void)get_Timeline{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=getTimeline"];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/main.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}


-(void)logOut{
    
}

-(void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)res{
    /*
    NSLog(@"expectedContentLength:%lld",[res expectedContentLength]);
    NSLog(@"MIMEType:%@",[res MIMEType]);
    NSLog(@"suggestedFilename:%@",[res suggestedFilename]);
    NSLog(@"textEncodingName:%@",[res textEncodingName]);
    NSLog(@"URL:%@",[res URL]);
     */
}

-(void)connection:( NSURLConnection *) connection didReceiveData:( NSData *) resdata{
    responceString = [[NSString alloc] initWithData:resdata encoding:NSUTF8StringEncoding];
    NSLog(@"res=%@",responceString);
    [deleagte ReceiveData:responceString];
    connect=nil;
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"サーバーと接続できません"message:@"接続を確立して下さい" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
    [alertView show];
}


@end
