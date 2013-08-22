//
//  OppViewController.h
//  Opportunita
//
//  Created by furukawa on 2013/07/04.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OppConnection.h"
@interface OppTimelineView : UIViewController<OppDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *timeLine;
    NSMutableArray *favLiat_Array;
    NSMutableArray *joinList_Array;
}

@property(retain,nonatomic)IBOutlet UITableView *TimeLineTable;
@property(retain,nonatomic)UIRefreshControl* refreshControl;
@property(retain,nonatomic)IBOutlet UIToolbar *ToolBar;

@end
