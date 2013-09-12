//
//  OppSubjectPostVIewViewController.m
//  Opportunita
//
//  Created by furukawa on 2013/08/09.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppSubjectPostViewController.h"
#import "OppTimelineView.h"

@interface OppSubjectPostViewController ()

@end

@implementation OppSubjectPostViewController
@synthesize InsertText;
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
//    InsertText=[[UITextView alloc]init];
    InsertText.editable=YES;
    InsertText.delegate=self;
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [InsertText becomeFirstResponder];
}

-(IBAction)PostBtn:(id)sender{
    if ([InsertText hasText]==NO) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"何も入力されていません"message:@"送れません" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alertView show];
    }else{
        NSUserDefaults *ID_Default=[NSUserDefaults standardUserDefaults];
        OppConnection *SendConnection=[OppConnection instance];
        SendConnection.delegate=self;
        [SendConnection send_Subject:InsertText.text MyUserID:[ID_Default stringForKey:@"My_user_ID"]];
    }
    
}
-(void)ReceiveData:(NSString *)responce Method:(NSString *)method_name{

        [InsertText resignFirstResponder];
    if ([responce isEqualToString:@"ok"]==YES) {
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"送信に問題が発生しました"message:@"時間をおいてやりなおしてね" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alertView show];
    }
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    OppTimelineView *timeLineView=[storyboard instantiateViewControllerWithIdentifier:@"TimelineView"];
    [self presentViewController:timeLineView animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
