//
//  OppFrontViewController.m
//  Opportunita
//
//  Created by furukawa on 2013/10/09.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppFrontViewController.h"
#import "OppFrontNavigation.h"

@interface OppFrontViewController ()

@end

@implementation OppFrontViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [login_btn setEnabled:NO];
    NSUserDefaults *userdeff=[NSUserDefaults standardUserDefaults];
    NSString *loginStr=[userdeff stringForKey:@"My_user_ID"];
    [login_btn addTarget:self action:@selector(login_action:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"login = %@",loginStr);
    if (!loginStr) {
        NSLog(@"ログインしてない");
        countdown=[[NSTimer alloc]init];
        countdown=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(count_Down:) userInfo:nil repeats:YES];
        
    }else{
        NSLog(@"ログイン中");
        OppFrontNavigation *View=[[OppFrontNavigation alloc]init];
        View=[self.storyboard instantiateViewControllerWithIdentifier:@"FrontNavigation"];
        [self presentViewController:View animated:YES completion:nil];
    }
}

-(void)count_Down:(id)sender{
    deff=[NSUserDefaults standardUserDefaults];
    date=[deff objectForKey:@"device_token"];
    if (!date) {
    }else{
        [countdown invalidate];
        dev_token=[deff objectForKey:@"device_token"];
        [login_btn setEnabled:YES];
        
    }
    
}

-(void)ReceiveData:(NSString *)responce Method:(NSString *)method_name{
    if([responce isEqualToString:@"cantlogin"]==YES){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"エラー発生"
                                  message:@"サーバー管理者に問い合わせて下さい" delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil
                                  ];
        [alertView show];
        [login_btn setEnabled:YES];
        
    }else{
        NSUserDefaults *user_def = [NSUserDefaults standardUserDefaults];
        NSLog(@"getID=%@",responce);
        [user_def setObject:responce forKey:@"My_user_ID"];
        [user_def setBool:YES forKey:@"LoginState"];
        [user_def synchronize];
        NSLog(@"login");
        OppFrontNavigation *View=[[OppFrontNavigation alloc]init];
        View=[self.storyboard instantiateViewControllerWithIdentifier:@"FrontNavigation"];
        [self presentViewController:View animated:YES completion:nil];

    }
    
}

-(void)login_action:(id)sender{
    NSLog(@"loginAction");
    OppConnection *session=[[OppConnection alloc]init];
    session.delegate=self;
    [session login_and_DeviceToken:dev_token];
    [sender setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
