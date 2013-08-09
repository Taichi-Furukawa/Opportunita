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
    
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timeline.json"];
    NSArray *jsonArr=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    for (NSDictionary *obj in jsonArr){
        NSLog(@"ID=%@",[obj objectForKey:@"Topics_ID"]);
        NSLog(@"Sub=%@",[obj objectForKey:@"Subject"]);
        NSLog(@"AR=%@",[obj objectForKey:@"AR_tag"]);
        
    }
    
    [super viewDidLoad];
    

	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)reloadAction:(UIButton*)sender{
    OppConnection *GetTimeLines=[OppConnection instance];
    GetTimeLines.deleagte=self;
    [GetTimeLines get_Timeline];
    
}

-(void)ReceiveData:(NSString *)responce{
    //responce=[responce stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    responce=[responce stringByReplacingOccurrencesOfString:@" " withString:@""];
    responce=[responce stringByReplacingOccurrencesOfString:@"	" withString:@" "];
    responce =[responce stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    
    NSError *err;
    NSArray *jsonTimeline=[NSJSONSerialization JSONObjectWithData:[responce dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];

    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timeline.json"];
    [NSKeyedArchiver archiveRootObject:jsonTimeline toFile:filePath];
    for (NSDictionary *obj in jsonTimeline){
        NSLog(@"ID=%@",[obj objectForKey:@"Topics_ID"]);
        NSLog(@"Sub=%@",[obj objectForKey:@"Subject"]);
        NSLog(@"AR=%@",[obj objectForKey:@"AR_tag"]);
        
    }
}

-(void)Draw_A_TimeLine:(NSArray*)jsonTimeLine{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
