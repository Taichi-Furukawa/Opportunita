//
//  OppMentionViewController.h
//  Opportunita
//
//  Created by furukawa on 2013/09/04.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
@interface OppNoticeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UIRefreshControl *refresh;
    NSMutableArray *One_section;
    NSMutableArray *Two_section;
    NSDictionary *One_sectionData;
    NSMutableArray *Two_sectionData;
    
    UITableViewCell *indiCell;
}
@property(retain,nonatomic)IBOutlet UITableView *mentionTable;

@end
