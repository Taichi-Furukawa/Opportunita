//
//  OppConnection.m
//  Opportunita
//
//  Created by furukawa on 2013/07/11.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppConnection.h"

@implementation OppConnection
@synthesize connect,request,responceData,responceString,delegate;
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
    Method_name=@"login_and_DeviceToken";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=login&devicetoken=%@",devicetoken];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/login.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setTimeoutInterval:20];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}

-(void)get_Timeline{
    
    Method_name=@"get_Timeline";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=getTimeline"];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/main.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setTimeoutInterval:20];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}

-(void)get_Favtable{
    Method_name=@"get_Favtable";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=getFavTable"];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/main.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setTimeoutInterval:20];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}

-(void)get_Jointable{
    Method_name=@"get_Jointable";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=getJoinTable"];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/main.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setTimeoutInterval:20];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void)get_Waitcolumn{
    Method_name=@"get_WaitColumn";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=getWaitColumn"];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/main.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setTimeoutInterval:20];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void)get_ARfield{
    Method_name=@"get_ARfield";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=getARfield"];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/main.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setTimeoutInterval:20];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void)favorite_Topics:(NSString*)Topics_ID MyUserID:(NSString*)user_ID{
    Method_name=@"Fav";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=Fav&Topics_ID=%@&User_ID=%@",Topics_ID,user_ID];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/main.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setTimeoutInterval:20];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void)leave_join_topics:(NSString*)Topics_ID MyUserID:(NSString*)user_ID{
    Method_name=@"Join_leave";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=Join_leave&User_ID=%@",user_ID];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/main.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setTimeoutInterval:20];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}

-(void)join_Topics:(NSString*)Topics_ID MyUserID:(NSString*)user_ID{
    Method_name=@"Join";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=Join&Topics_ID=%@&User_ID=%@",Topics_ID,user_ID];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/main.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setTimeoutInterval:20];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}

-(void)send_Subject:(NSString*)IncertSubject MyUserID:(NSString*)user_ID{
    Method_name=@"send_Subject";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=TopicsPost&topics=%@&User_ID=%@",IncertSubject,user_ID];
    NSURL *url=[NSURL URLWithString:@"http://opp.sp2lc.salesio-sp.ac.jp/main.php"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setTimeoutInterval:20];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}


-(void)logOut{
    
}

-(void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)res{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    /*
    NSLog(@"expectedContentLength:%lld",[res expectedContentLength]);
    NSLog(@"MIMEType:%@",[res MIMEType]);
    NSLog(@"suggestedFilename:%@",[res suggestedFilename]);
    NSLog(@"textEncodingName:%@",[res textEncodingName]);
    NSLog(@"URL:%@",[res URL]);
     */
}

-(void)connection:( NSURLConnection *) connections didReceiveData:( NSData *) resdata{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    responceString = [[NSString alloc] initWithData:resdata encoding:NSUTF8StringEncoding];
    NSLog(@"res=%@",responceString);
    
    if([Method_name isEqualToString:@"get_Favtable"]==YES){//favtableの受け渡しデリゲート
        [delegate receiveFav_table:responceString];
    }else if([Method_name isEqualToString:@"get_Jointable"]==YES){//ジョインテーブルの受け渡しデリゲート
        [delegate receiveJoin_table:responceString];
    }else if([Method_name isEqualToString:@"get_WaitColumn"]==YES){//waitcolumnの受け渡しデリゲート
        [delegate receiveWait_column:responceString];
    }else if([Method_name isEqualToString:@"get_ARfield"]==YES){//arfieldの受け渡しデリゲート
        [delegate receiveAR_field:responceString];
    }else{//それ以外はreceiveDataをデリゲート
            [delegate ReceiveData:[responceString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] Method:Method_name];
    }

    connect=nil;
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"サーバーと接続できません"message:@"接続を確立して下さい" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
    [alertView show];
}


@end
