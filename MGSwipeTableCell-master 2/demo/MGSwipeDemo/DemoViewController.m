//
//  DemoViewController.m
//  MGSwipeDemo
//
//  Created by Imanol Fernandez Gorostizag on 09/08/14.
//  Copyright (c) 2014 Imanol Fernandez Gorostizaga. All rights reserved.
//


// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "DemoViewController.h"
#import "TestData.h"

#define TEST_USE_MG_DELEGATE 1

@implementation DemoViewController
{
    NSMutableArray * tests;
    UIBarButtonItem * prevButton;
    UITableViewCellAccessoryType accessory;
}


-(void) cancelTableEditClick: (id) sender
{
    [self.tableView setEditing: NO animated: YES];
    self.navigationItem.rightBarButtonItem = prevButton;
    prevButton = nil;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    if (buttonIndex == 1) {
        tests = [TestData data];
        [self.tableView reloadData];
    }
    else if (buttonIndex == 2) {
        self.tableView.allowsMultipleSelectionDuringEditing = YES;
        [self.tableView setEditing: YES animated: YES];
        prevButton = self.navigationItem.rightBarButtonItem;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelTableEditClick:)];
    }
    else if (buttonIndex == 3) {
        accessory++;
        if (accessory >=4) {
            accessory = 0;
        }
        [self.tableView reloadData];
    }
    else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"autolayout_test" bundle:nil];
        DemoViewController *vc = [sb instantiateInitialViewController];
        vc.testingStoryboardCell = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void) actionClick: (id) sender
{
    
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"Select action" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    [sheet addButtonWithTitle:@"Reload test"];
    [sheet addButtonWithTitle:@"Multiselect test"];
    [sheet addButtonWithTitle:@"Change accessory button"];
    if (!_testingStoryboardCell) {
        [sheet addButtonWithTitle:@"Storyboard test"];
    }
    [sheet showInView:self.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tests = [TestData data];
    self.title = @"MGSwipeCell";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionClick:)];
}


-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
   
    for (int i = 0; i < number; ++i)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor blackColor];
        [button setTitle:@"AA" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button sizeToFit];
        CGRect frame = button.frame;
        frame.size.width += 10; //padding
        frame.size.width = MAX(50, frame.size.width); //initial min size
        button.frame = frame;
        [result addObject:button];
    }
    return result;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return tests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGSwipeTableCell * cell;
    
    if (_testingStoryboardCell) {
        /**
         * Test using storyboard and prototype cell that uses autolayout
         **/
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"prototypeCell"];
    }
    else {
        /**
         * Test using programmatically created cells
         **/
        static NSString * reuseIdentifier = @"programmaticCell";
        cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        }
    }
    
    TestData * data = [tests objectAtIndex:indexPath.row];
    
    cell.textLabel.text = data.title;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.text = data.detailTitle;
    cell.accessoryType = accessory;
    cell.delegate = self;

    
#if !TEST_USE_MG_DELEGATE
    cell.leftSwipeSettings.transition = data.transition;
    cell.rightSwipeSettings.transition = data.transition;
    cell.leftExpansion.buttonIndex = data.leftExpandableIndex;
    cell.leftExpansion.fillOnTrigger = NO;
    cell.rightExpansion.buttonIndex = data.rightExpandableIndex;
    cell.rightExpansion.fillOnTrigger = YES;
    cell.leftButtons = [self createLeftButtons:data.leftButtonsCount];
    cell.rightButtons = [self createRightButtons:data.rightButtonsCount];
#endif
    
    return cell;
}

#if TEST_USE_MG_DELEGATE
-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings;
{
    TestData * data = [tests objectAtIndex:[self.tableView indexPathForCell:cell].row];
  
        expansionSettings.buttonIndex = data.rightExpandableIndex;
        expansionSettings.fillOnTrigger = YES;
        return [self createRightButtons:data.rightButtonsCount];
 }
#endif


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    NSLog(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@",
          direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        NSIndexPath * path = [self.tableView indexPathForCell:cell];
        [tests removeObjectAtIndex:path.row];
        [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
    return YES;
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tapped accessory button");
}

@end
