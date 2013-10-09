//
//  OppMentionViewController.m
//  Opportunita
//
//  Created by furukawa on 2013/09/04.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppNoticeViewController.h"

@interface OppNoticeViewController ()
@end

@implementation OppNoticeViewController
@synthesize mentionTable;
int countInterval=0;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    indiCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    One_section=[NSMutableArray array];
    Two_section=[NSMutableArray array];
    One_sectionData=[[NSDictionary alloc]init];
    Two_sectionData=[NSMutableArray array];
     
    NSUserDefaults *deff=[NSUserDefaults standardUserDefaults];
    refresh=[[UIRefreshControl alloc]init];
    [refresh addTarget:self action:@selector(mentionReload)forControlEvents:UIControlEventValueChanged];
    [mentionTable addSubview:refresh];
    
    mentionTable.dataSource=self;
    mentionTable.delegate=self;
    SharedData *sh=[SharedData instance];
    NSString *Join_ID=[[NSString alloc]init];
    Join_ID=[deff objectForKey:@"join_list"];
    
    
    for (NSDictionary *dic in [sh getDataForKey:@"ar_field"]){
        if ([Join_ID isEqualToString:[dic objectForKey:@"Topics_ID"]]==YES) {
            One_sectionData=dic;
            NSMutableArray *SubjectS=[NSMutableArray arrayWithArray:[sh getDataForKey:@"timeline"]];
            for (NSDictionary *drect in SubjectS) {
                if ([Join_ID isEqualToString:[drect objectForKey:@"Topics_ID"]]==YES) {
                    indiCell.detailTextLabel.text=[drect objectForKey:@"Subject"];
                    
                    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss '+0000'"];
                    NSDate *formatterDate = [inputFormatter dateFromString:[One_sectionData objectForKey:@"Meet_limited"]];
                    NSCalendar *calendar = [NSCalendar currentCalendar];
                    NSDateComponents *diff = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date] toDate:formatterDate options:0];
                    NSInteger h = [diff hour];
                    NSInteger m = [diff minute];
                    NSInteger s = [diff second];
                    indiCell.textLabel.text =[NSString stringWithFormat:@"のこり%d時間%d分%d秒",h,m,s];
                    [One_section addObject:indiCell];
                }
            }
    NSTimer *countdown=[[NSTimer alloc]init];
    countdown=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(count_Down:) userInfo:nil repeats:YES];
        }
    }

    [mentionTable reloadData];
}


-(void)count_Down:(NSTimer*)sender{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss '+0000'"];
    NSDate *formatterDate = [inputFormatter dateFromString:[One_sectionData objectForKey:@"Meet_limited"]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *diff = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date] toDate:formatterDate options:0];
    NSInteger h = diff.hour;
    NSInteger m = diff.minute;
    NSInteger s = diff.second;
    indiCell.textLabel.text =[NSString stringWithFormat:@"のこり%d時間%d分%d秒",h,m,s];
    if (h<=0 && m<=0 &&s<=0) {
    indiCell.textLabel.text =[NSString stringWithFormat:@"この話題は解散になりました"];
    }else{
    indiCell.textLabel.text =[NSString stringWithFormat:@"のこり%d時間%d分%d秒",h,m,s];
    }
    
}

-(void)mentionReload{
    [refresh endRefreshing];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return [One_section count];
    }else if(section==1){
        return [Two_section count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return [One_section objectAtIndex:indexPath.row];
    }else if(indexPath.section==1){
        return [Two_section objectAtIndex:indexPath.row];
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 60;
    }else{
        return 40;
    }
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
