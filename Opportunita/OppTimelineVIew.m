//
//  OppViewController.m
//  Opportunita
//
//  Created by furukawa on 2013/07/04.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppTimelineView.h"
#import "OppNoticeViewController.h"
#import "SharedData.h"

@interface OppTimelineView ()

@end

@implementation OppTimelineView
@synthesize TimeLineTable,refreshControl,pops;

- (void)viewDidLoad
{
    [super viewDidLoad];
    timeLine=[NSMutableArray array];
    ar_table=[NSMutableArray array];
    wait_column=[NSMutableArray array];

    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadAction)forControlEvents:UIControlEventValueChanged];
    [TimeLineTable addSubview:refreshControl];
    
    TimeLineTable.allowsSelection=NO;
    TimeLineTable.delegate=self;
    TimeLineTable.dataSource=self;
    mentionBtn=[[UIBarButtonItem alloc]initWithTitle:@"Notise" style:UIBarButtonItemStyleBordered target:self action:@selector(mention_View:)];
    mentionBtn.title=@"Notice";
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:postSegment,mentionBtn, nil];
    //[self reloadAction];

}

-(void)viewDidAppear:(BOOL)animated{
    [self reloadAction];
}


-(void)reloadAction{
    
    NSUserDefaults *Deff=[NSUserDefaults standardUserDefaults];
    favLiat_Array=[NSMutableArray arrayWithArray:[Deff objectForKey:@"fav_list"]];
    joinTopic=[Deff stringForKey:@"join_list"];
    
    OppConnection *GetTimeLines=[[OppConnection alloc]init];
    GetTimeLines.delegate=self;
    [GetTimeLines get_Timeline];
    /*
    OppConnection *GetFavtable=[[OppConnection alloc]init];
    GetFavtable.delegate=self;
    [GetFavtable get_Favtable];
    
    OppConnection *GetJointable=[[OppConnection alloc]init];
    GetJointable.delegate=self;
    [GetJointable get_Jointable];
    */
    OppConnection *GetWaittable=[[OppConnection alloc]init];
    GetWaittable.delegate=self;
    [GetWaittable get_Waitcolumn];
    
    OppConnection *GetARtable=[[OppConnection alloc]init];
    GetARtable.delegate=self;
    [GetARtable get_ARfield];
    
}
-(void)ReceiveData:(NSString *)responce Method:(NSString *)method_name{//リロード後データが届くと呼び出される
    NSRange rangeTest = [responce rangeOfString:@"["];
    if (rangeTest.location==NSNotFound) {
        NSLog(@"notfound");
    }else{
    responce=[responce substringWithRange:NSMakeRange(rangeTest.location, [responce length]-rangeTest.location)];
        NSLog(@"lineresponce = %@",responce);
    NSArray *jsonTimeLine=[[NSArray alloc]init];
    jsonTimeLine=[NSArray array];
    jsonTimeLine=[self jSON_to_Array:responce];
    SharedData *sh=[SharedData instance];
    [sh setData:jsonTimeLine forKey:@"timeline"];
    [timeLine removeAllObjects];
    for (NSDictionary *obj in jsonTimeLine) {
        OppTimeLineCell *addTimeLineCell=[OppTimeLineCell initTimeLineCell];
        addTimeLineCell.subjectlabel.text=[obj objectForKey:@"Subject"];
        addTimeLineCell.topicsID=[obj objectForKey:@"Topics_ID"];
        addTimeLineCell.delegate=self;
        [timeLine addObject:addTimeLineCell];
    }
    }
    [refreshControl endRefreshing];
    
    [TimeLineTable reloadData];
}
/*-(void)receiveFav_table:(NSString *)responce{//FavTableが受け渡されるデリゲート
    SharedData *sh=[SharedData instance];
    [sh setValue:[self jSON_to_Array:responce] forKey:@"fav_table"];
    [refreshControl endRefreshing];
}
-(void)receiveJoin_table:(NSString *)responce{//joinTableが受け渡されるデリゲート
    SharedData *sh=[SharedData instance];
    [sh setValue:[self jSON_to_Array:responce] forKey:@"join_table"];
     [refreshControl endRefreshing];
}*/
-(void)receiveWait_column:(NSString *)responce{//waitColumnが受け渡されるデリゲード
    NSRange rangeTest = [responce rangeOfString:@"["];
    if (rangeTest.location==NSNotFound) {
        NSLog(@"notfound");
    }else{
    responce=[responce substringWithRange:NSMakeRange(rangeTest.location, [responce length]-rangeTest.location)];
    
    NSLog(@"Waitresponce = %@",responce);
    NSArray *jsonTimeLine=[[NSArray alloc]init];
    jsonTimeLine=[NSArray array];
    jsonTimeLine=[self jSON_to_Array:responce];
    SharedData *sh=[SharedData instance];
    [sh setData:jsonTimeLine forKey:@"wait_column"];
    for (NSDictionary *dic in jsonTimeLine) {
        [wait_column addObject:[dic objectForKey:@"Topics_ID"]];
    }
    }
     [refreshControl endRefreshing];
}
-(void)receiveAR_field:(NSString *)responce{//ARのや
    NSRange rangeTest = [responce rangeOfString:@"["];
    NSLog(@"range=%d--%d",rangeTest.location,rangeTest.length);
    if (rangeTest.location==NSNotFound) {
        NSLog(@"notfound");
    }else{
    
    responce=[responce substringWithRange:NSMakeRange(rangeTest.location, [responce length]-rangeTest.location)];
        NSLog(@"Waitresponce = %@",responce);
    NSArray *jsonTimeLine=[[NSArray alloc]init];
    jsonTimeLine=[NSArray array];
    jsonTimeLine=[self jSON_to_Array:responce];
    SharedData *sh=[SharedData instance];
    [sh setData:jsonTimeLine forKey:@"ar_field"];
    for (NSDictionary *dic in jsonTimeLine) {
        [ar_table addObject:[dic objectForKey:@"Topics_ID"]];
    }
    }
     [refreshControl endRefreshing];
}

-(NSArray*)jSON_to_Array:(NSString*)jSON_string{
    NSArray *jSONarr=[[NSArray alloc]init];
    jSONarr=[NSArray array];
    jSON_string=[jSON_string stringByReplacingOccurrencesOfString:@"	" withString:@" "];
    jSON_string=[jSON_string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    jSON_string=[jSON_string stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    NSError *err;
    jSONarr=[NSJSONSerialization JSONObjectWithData:[jSON_string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    NSLog(@"%@",err);
    return jSONarr;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{//tableView関連
    
    return [timeLine count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OppTimeLineCell *Cell=[OppTimeLineCell initTimeLineCell];
    Cell=[timeLine objectAtIndex:indexPath.row];
    
    if ([wait_column containsObject:Cell.topicsID]==YES || [ar_table containsObject:Cell.topicsID]==YES) {
        [Cell.favbutton setEnabled:NO];
        [Cell.Joinbutton setEnabled:YES];
    }else{
        [Cell.favbutton setEnabled:YES];
        [Cell.Joinbutton setEnabled:NO];
    }
    
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

-(void)cellAction:(NSString *)actionName{//cell上のボタンが押されたときなどに呼び出される
    [self reloadAction];
    NSLog(@"%@",actionName);
}

//mentionView関連
-(void)mention_View:(id)sender{
    if (pops) {
        if ([pops isPopoverVisible]) {
            [pops dismissPopoverAnimated:YES];
            pops=nil;
            setSegment.enabled=YES;
            postSegment.enabled=YES;
        }
    }else{
        OppNoticeViewController *mention=[self.storyboard instantiateViewControllerWithIdentifier:@"NoticeView"];
        pops=[[UIPopoverController alloc]initWithContentViewController:mention];
        pops.delegate=self;
        [pops presentPopoverFromBarButtonItem:mentionBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        setSegment.enabled=NO;
        postSegment.enabled=NO;
        
    }
    }
- (void)popoverControllerDidDismissPopover: popoverController{
    setSegment.enabled=YES;
    postSegment.enabled=YES;
    pops=nil;
}

@end
