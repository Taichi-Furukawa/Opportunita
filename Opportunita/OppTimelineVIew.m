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
@synthesize TimeLineTable,refreshControl,ToolBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    timeLine=[NSMutableArray array];
    
    /*
    NSArray *ArchiveArr=[NSArray new];
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timeline.arr"];
    ArchiveArr=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    timeLine=[NSMutableArray arrayWithArray:ArchiveArr];
    */
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
    [self reloadAction];
}


-(void)reloadAction{
    OppConnection *GetTimeLines=[[OppConnection alloc]init];
    GetTimeLines.deleagte=self;
    [GetTimeLines get_Timeline];
    
    NSUserDefaults *Deff=[NSUserDefaults standardUserDefaults];
    favLiat_Array=[NSMutableArray arrayWithArray:[Deff objectForKey:@"fav_list"]];
    joinList_Array=[NSMutableArray arrayWithArray:[Deff objectForKey:@"join_list"]];
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
    if([joinList_Array containsObject:Cell.topicsID]==YES){
        [Cell.Joinbutton setEnabled:NO];
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

@end
