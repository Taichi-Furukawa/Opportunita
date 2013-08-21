//
//  OppViewController.m
//  Opportunita
//
//  Created by furukawa on 2013/07/04.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppTimelineView.h"
#import "OppTimeLineCell.h"

@interface OppTimelineView ()

@end

@implementation OppTimelineView
@synthesize TimeLineTable,refreshControl,jsonTimeLine,ToolBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    timeLine=[NSMutableArray array];
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timeline.json"];
    jsonTimeLine=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    
    [self Draw_A_TimeLine:jsonTimeLine];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadAction)forControlEvents:UIControlEventValueChanged];
    [TimeLineTable addSubview:refreshControl];
    
    TimeLineTable.allowsSelection=NO;
    TimeLineTable.delegate=self;
    TimeLineTable.dataSource=self;
    ToolBar.translucent=YES;

    if (!jsonTimeLine) {
    [self reloadAction];
    }

}

-(void)viewDidAppear:(BOOL)animated{
    [self reloadAction];
}

-(void)reloadAction{
    OppConnection *GetTimeLines=[OppConnection instance];
    GetTimeLines.deleagte=self;
    [GetTimeLines get_Timeline];
    
}

-(void)ReceiveData:(NSString *)responce Method:(NSString *)method_name{
    responce=[responce stringByReplacingOccurrencesOfString:@"	" withString:@" "];
    responce =[responce stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    NSError *err;
    jsonTimeLine=[NSJSONSerialization JSONObjectWithData:[responce dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];

    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timeline.json"];
    [NSKeyedArchiver archiveRootObject:jsonTimeLine toFile:filePath];
    
    [self Draw_A_TimeLine:jsonTimeLine];
    
}

-(void)Draw_A_TimeLine:(NSArray*)jsonS{
    [refreshControl endRefreshing];
    for (NSDictionary *obj in jsonS) {
        OppTimeLineCell *TimeLineCell=[OppTimeLineCell initTimeLineCell];
        TimeLineCell.subjectlabel.text=[obj objectForKey:@"Subject"];
        TimeLineCell.topicsID=[obj objectForKey:@"Topics_ID"];
        [timeLine addObject:TimeLineCell];
    }
    
    
    [TimeLineTable reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [timeLine count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"loading!");
    //OppTimeLineCell *TimeLineCell=[[OppTimeLineCell alloc]init];
    /*
    OppTimeLineCell *TimeLineCell=[OppTimeLineCell initTimeLineCell];
    TimeLineCell.subjectlabel.text=[[jsonTimeLine objectAtIndex:indexPath.row] objectForKey:@"Subject"];
    TimeLineCell.topicsID=[[jsonTimeLine objectAtIndex:indexPath.row] objectForKey:@"Topics_ID"];
    */
    OppTimeLineCell *Cell=[OppTimeLineCell initTimeLineCell];
    Cell=[timeLine objectAtIndex:indexPath.row];
    
    return Cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //OppTimeLineCell *Cells;
    
    return 111.0;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
