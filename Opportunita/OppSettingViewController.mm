//
//  OppSettingViewController.m
//  Opportunita
//
//  Created by furukawa on 2013/09/06.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppSettingViewController.h"

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
    [deff removeObjectForKey:@"My_user_ID"];
    [deff removeObjectForKey:@"LoginState"];
    [deff removeObjectForKey:@"fav_list"];
    [deff removeObjectForKey:@"join_list"];
    [deff synchronize];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
