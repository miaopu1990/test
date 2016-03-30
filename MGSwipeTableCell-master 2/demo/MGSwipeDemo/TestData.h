/*
 * MGSwipeTableCell is licensed under MIT licensed. See LICENSE.md file for more information.
 * Copyright (c) 2014 Imanol Fernandez @MortimerGoro
 */

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "MGSwipeTableCell.h"

@interface TestData : NSObject

@property (nonatomic) MGSwipeTransition transition;
@property (nonatomic) int leftButtonsCount;
@property (nonatomic) int rightButtonsCount;
@property (nonatomic) int leftExpandableIndex;
@property (nonatomic) int rightExpandableIndex;


-(NSString *) title;
-(NSString *) detailTitle;

+(NSMutableArray*) data;


@end
