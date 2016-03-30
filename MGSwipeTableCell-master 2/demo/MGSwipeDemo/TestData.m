/*
 * MGSwipeTableCell is licensed under MIT licensed. See LICENSE.md file for more information.
 * Copyright (c) 2014 Imanol Fernandez @MortimerGoro
 */

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "TestData.h"
 
@implementation TestData


-(NSString *) title
{
    
    
    return @"22";
}

-(NSString *) detailTitle
{
    return @"Not expandable";
}


+(NSMutableArray *) data
{
    NSMutableArray * tests = [NSMutableArray array];
    
              for (int z = 0; z < 5; ++z) {
                TestData * data = [[TestData alloc] init];
                data.rightButtonsCount = 1;
                data.transition = MGSwipeTransitionStatic;
                data.rightExpandableIndex = 0;
                [tests addObject:data];
            
        
    }
    return tests;
}

@end