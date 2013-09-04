//
//  OppMentionViewController.m
//  Opportunita
//
//  Created by furukawa on 2013/09/04.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppMentionViewController.h"

@interface OppMentionViewController ()

@end

@implementation OppMentionViewController
@synthesize mentionTable;

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
    refresh=[[UIRefreshControl alloc]init];
    [refresh addTarget:self action:@selector(mentionReload)forControlEvents:UIControlEventValueChanged];
    [mentionTable addSubview:refresh];
	// Do any additional setup after loading the view.
}

-(void)mentionReload{
    [refresh endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
