//
//  OppSettingViewController.m
//  Opportunita
//
//  Created by furukawa on 2013/09/06.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppSettingViewController.h"
#import "OppFrontViewController.h"

@interface OppSettingViewController ()

@end

@implementation OppSettingViewController

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
	// Do any additional setup after loading the view.
}

-(IBAction)user_out:(id)sender{
    NSUserDefaults *deff=[NSUserDefaults standardUserDefaults];
    NSString *user_id=[deff stringForKey:@"My_user_ID"];
    OppConnection *logouting=[OppConnection instance];
    logouting.delegate=self;
    [logouting logOut:user_id];
    
}
-(void)ReceiveData:(NSString*)responce Method:(NSString*)method_name;{
    if ([responce isEqualToString:@"ok"]==YES) {
                NSUserDefaults *deff=[NSUserDefaults standardUserDefaults];
        [deff removeObjectForKey:@"My_user_ID"];
        [deff removeObjectForKey:@"fav_list"];
        [deff removeObjectForKey:@"join_list"];
        [deff synchronize];
        
        OppFrontViewController *View=[[OppFrontViewController alloc]init];
        View=[self.storyboard instantiateViewControllerWithIdentifier:@"FrontView"];
        [self presentViewController:View animated:YES completion:nil];
        

        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"エラー発生"
                                  message:@"サーバー管理者に問い合わせて下さい" delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil
                                  ];
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
