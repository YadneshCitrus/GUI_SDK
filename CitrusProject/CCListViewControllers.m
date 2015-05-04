//
//  CCListViewControllers.m
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import "CCListViewControllers.h"
#import "AddCardController.h"
#import "ResultController.h"
#import "HomeViewController.h"
#import "EnterCVVViewController.h"

@interface CCListViewControllers ()

@end

@implementation CCListViewControllers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Environment option:" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:
                            @"Using SandBox",
                            @"Using Production",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}


- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) { return; }
    switch (buttonIndex) {
        case 0:
        {
            dispatch_async(dispatch_get_main_queue(), ^(){
                HomeViewController *addCard = [[HomeViewController alloc]initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:addCard animated:YES];
            });
            break;
        }
        case 1:
        {
            dispatch_async(dispatch_get_main_queue(), ^(){
                HomeViewController *addCard = [[HomeViewController alloc]initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:addCard animated:YES];
            });
            break;
        }
    }
}



- (NSArray *)demoTitles
{
    return @[
             @"Add Card",
             @"Error",
             @"Payment Successfull",
             @"Home",
             @"CVV"
             ];
}

- (NSString *)textForDemoAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.demoTitles[indexPath.row];
    text = [NSString stringWithFormat:@"%@. %@", @(indexPath.row + 1), text];
    return text;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.demoTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil]; // not bothering to reuse cells here
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self textForDemoAtIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            dispatch_async(dispatch_get_main_queue(), ^(){
                AddCardController *addCard = [[AddCardController alloc]initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:addCard animated:YES];
            });
           
        }
        break;
        case 1:
        {
            dispatch_async(dispatch_get_main_queue(), ^(){
               
                ResultController *addCard = [[ResultController alloc]initWithNibName:nil bundle:nil  isSuccessFul:NO];
                addCard.resultIdValueLbl.text = @"1122552256" ;
                addCard.messageValueLbl.text = @"Couldn't reach to the server"  ;
                
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:addCard];
                [self.navigationController presentViewController:nav animated:YES completion:nil];
            });
            
        }
            break;
        case 2:
        {
            dispatch_async(dispatch_get_main_queue(), ^(){
                ResultController *addCard = [[ResultController alloc]initWithNibName:nil bundle:nil  isSuccessFul:YES];
                addCard.resultIdValueLbl.text = @"2323232" ;
                addCard.messageValueLbl.text = @"Rs. 1200" ;

                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:addCard];
                [self.navigationController presentViewController:nav animated:YES completion:nil];
            });
            
        }
            break;
        case 3:
        {
            dispatch_async(dispatch_get_main_queue(), ^(){
                HomeViewController *addCard = [[HomeViewController alloc]initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:addCard animated:YES];
            });
        }
            break;
        case 4:
        {
            dispatch_async(dispatch_get_main_queue(), ^(){
                EnterCVVViewController *cvv = [[EnterCVVViewController alloc]initWithNibName:nil bundle:nil amount:@"Rs 1200"];
                [self.navigationController pushViewController:cvv animated:YES];
            });
        }
            break;

        default:
        break;
    }
   
    
}
@end
