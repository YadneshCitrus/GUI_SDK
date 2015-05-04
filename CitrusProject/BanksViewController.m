//
//  BanksViewController.m
//  CitrusProject
//
//  Created by Mukesh Patil on 04/05/15.
//  Copyright (c) 2015 Nirma Garg. All rights reserved.
//

#import "BanksViewController.h"
#import "CustomTableView.h"

@interface BanksViewController ()

@end

@implementation BanksViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Select Bank to Pay";
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
}


#pragma TableView Delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return [your array count];
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"Bank-Kotak"];
    
    cell.textLabel.text = @"XXXX XXXXX XXXX 3334";
    cell.textLabel.font = [UIFont customLightFontWithSize:16];
    
    cell.detailTextLabel.text = @"Kotak Mahindra BANK";
    cell.detailTextLabel.font = [UIFont customLightFontWithSize:12];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath Tapped %ld",(long)indexPath.row);
    
    dispatch_async(dispatch_get_main_queue(), ^(){
        [delegate payWithOtherNetBanking];
    });

    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
