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
}

@property(retain,nonatomic)IBOutlet UITableView *TimeLineTable;
@property(retain,nonatomic)UIRefreshControl* refreshControl;
@property(retain,nonatomic)NSArray *jsonTimeLine;
@property(retain,nonatomic)IBOutlet UIToolbar *ToolBar;

@end
