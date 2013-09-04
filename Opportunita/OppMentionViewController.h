//
//  OppMentionViewController.h
//  Opportunita
//
//  Created by furukawa on 2013/09/04.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OppMentionViewController : UIViewController{
    UIRefreshControl *refresh;
}
@property(retain,nonatomic)IBOutlet UITableView *mentionTable;

@end
