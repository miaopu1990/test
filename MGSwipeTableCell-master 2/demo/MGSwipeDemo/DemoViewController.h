//
//  DemoViewController.h
//  MGSwipeDemo
//
//  Created by Imanol Fernandez Gorostizag on 09/08/14.
//  Copyright (c) 2014 Imanol Fernandez Gorostizaga. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface DemoViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, UIActionSheetDelegate>

@property (nonatomic, assign) BOOL testingStoryboardCell;

@end
