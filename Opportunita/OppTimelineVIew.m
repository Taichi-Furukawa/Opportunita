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
    
    NSArray *ArchiveArr=[NSArray new];
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timeline.arr"];
    ArchiveArr=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    timeLine=[NSMutableArray arrayWithArray:ArchiveArr];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadAction)forControlEvents:UIControlEventValueChanged];
    [TimeLineTable addSubview:refreshControl];
    
    TimeLineTable.allowsSelection=NO;
    TimeLineTable.delegate=self;
    TimeLineTable.dataSource=self;
    ToolBar.translucent=YES;

    if([timeLine count]==0){
        [self reloadAction];
    }
//    [TimeLineTable reloadData];

}

-(void)viewDidAppear:(BOOL)animated{
    [self reloadAction];
}


-(void)reloadAction{
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
    
    NSMutableArray *refreshArr=[NSMutableArray array];
    int diff=[jsonTimeLine count]-[timeLine count];
    int index=0;
    for (NSDictionary *obj in jsonTimeLine) {
        OppTimeLineCell *addTimeLineCell=[OppTimeLineCell initTimeLineCell];
        addTimeLineCell.subjectlabel.text=[obj objectForKey:@"Subject"];
        addTimeLineCell.topicsID=[obj objectForKey:@"Topics_ID"];
        if (index<diff) {
            [timeLine insertObject:addTimeLineCell atIndex:index];
        }
        index++;
    }
    //int diff=[refreshArr count]-[timeLine count];
    NSLog(@"diff=%d",diff);
    for (int i=[refreshArr count]-diff;i<[refreshArr count];i++) {
        NSLog(@"loop=%d",i);
        OppTimeLineCell *Cell=[OppTimeLineCell initTimeLineCell];
        Cell=[refreshArr objectAtIndex:i];
        [timeLine addObject:Cell];
        
    }
    
    [refreshControl endRefreshing];
    
    [TimeLineTable reloadData];
    NSArray *ArchiveArr=[NSArray new];
    ArchiveArr=[timeLine copy];
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"timeline.arr"];
    [NSKeyedArchiver archiveRootObject:ArchiveArr toFile:filePath];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [timeLine count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"loading!");
    
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
