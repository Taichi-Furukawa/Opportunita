//
//  OppViewController.h
//  Opportunita
//
//  Created by furukawa on 2013/07/04.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OppConnection.h"
#import "OppTimeLineCell.h"
@interface OppTimelineView : UIViewController<OppDelegate,UITableViewDelegate,UITableViewDataSource,OppCellDelegate,UIPopoverControllerDelegate>{
    NSMutableArray *timeLine;
    NSMutableArray *favLiat_Array;
    NSMutableArray *ar_table;
    NSMutableArray *wait_column;
    NSString *joinTopic;
    
    IBOutlet UIBarButtonItem *postSegment;
    IBOutlet UIBarButtonItem *setSegment;
    UIBarButtonItem *mentionBtn;
}

@property(retain,nonatomic)IBOutlet UITableView *TimeLineTable;
@property(retain,nonatomic)UIRefreshControl* refreshControl;
@property(retain,nonatomic)UIPopoverController *pops;

@end
