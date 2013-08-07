//
//  OppViewController.m
//  Opportunita
//
//  Created by furukawa on 2013/07/04.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppTimelineView.h"

@interface OppTimelineView ()

@end

@implementation OppTimelineView

- (void)viewDidLoad
{
    [super viewDidLoad];
    

	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)reloadAction:(UIButton*)sender{
    OppConnection *GetTimeLines=[OppConnection instance];
    GetTimeLines.deleagte=self;
    [GetTimeLines get_Timeline];
    
}

-(void)ReceiveData:(NSString *)responce{
    NSError *err;
    NSDictionary *jsonTimeline=[NSJSONSerialization JSONObjectWithData:[responce dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&err];
    
    NSLog(@"%@",jsonTimeline);
}

-(void)Draw_A_TimeLine:(NSDictionary*)jsonTimeLine{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
