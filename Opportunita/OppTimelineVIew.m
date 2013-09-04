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
@synthesize TimeLineTable,refreshControl,ToolBar,mention;

- (void)viewDidLoad
{
    [super viewDidLoad];
    timeLine=[NSMutableArray array];

    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadAction)forControlEvents:UIControlEventValueChanged];
    [TimeLineTable addSubview:refreshControl];
    
    TimeLineTable.allowsSelection=NO;
    TimeLineTable.delegate=self;
    TimeLineTable.dataSource=self;
    ToolBar.translucent=YES;
    
    [self reloadAction];
//    [TimeLineTable reloadData];

}

-(void)viewDidAppear:(BOOL)animated{
    mention.hidden=YES;
    [self reloadAction];
}


-(void)reloadAction{
    
    NSUserDefaults *Deff=[NSUserDefaults standardUserDefaults];
    favLiat_Array=[NSMutableArray arrayWithArray:[Deff objectForKey:@"fav_list"]];
    joinTopic=[Deff stringForKey:@"join_list"];
    
    OppConnection *GetTimeLines=[[OppConnection alloc]init];
    GetTimeLines.deleagte=self;
    [GetTimeLines get_Timeline];
    
}

-(void)ReceiveData:(NSString *)responce Method:(NSString *)method_name{
    
    NSArray *jsonTimeLine=[[NSArray alloc]init];
    responce=[responce stringByReplacingOccurrencesOfString:@"	" withString:@" "];
        responce=[responce stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    responce =[responce stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    NSError *err;
    jsonTimeLine=[NSJSONSerialization JSONObjectWithData:[responce dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    NSLog(@"%@",err);
    
    [timeLine removeAllObjects];
    for (NSDictionary *obj in jsonTimeLine) {
        OppTimeLineCell *addTimeLineCell=[OppTimeLineCell initTimeLineCell];
        addTimeLineCell.subjectlabel.text=[obj objectForKey:@"Subject"];
        addTimeLineCell.topicsID=[obj objectForKey:@"Topics_ID"];
        addTimeLineCell.delegate=self;
        [timeLine addObject:addTimeLineCell];
        
    }
    
    [refreshControl endRefreshing];
    
    [TimeLineTable reloadData];
    /*
    NSArray *ArchiveArr=[NSArray new];
    ArchiveArr=[timeLine copy];
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timeline.arr"];
    [NSKeyedArchiver archiveRootObject:ArchiveArr toFile:filePath];
     */

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [timeLine count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OppTimeLineCell *Cell=[OppTimeLineCell initTimeLineCell];
    
    Cell=[timeLine objectAtIndex:indexPath.row];
    
    if ([favLiat_Array containsObject:Cell.topicsID]==YES) {
        [Cell.favbutton setEnabled:NO];
    }
    if([joinTopic isEqualToString:Cell.topicsID]==YES){
        [Cell.Joinbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return Cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 111.0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cellAction:(NSString *)actionName{
    [self reloadAction];
    NSLog(@"%@",actionName);
}
-(IBAction)mention_View:(id)sender{
    if (mention.hidden==YES) {
        mention.hidden=NO;
    }else if (mention.hidden==NO){
        mention.hidden=YES;
    }
    
}


@end
