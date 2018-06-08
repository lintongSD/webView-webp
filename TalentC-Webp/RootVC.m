//
//  RootVC.m
//  TalentC-Webp
//
//  Created by chuliangliang on 2017/4/6.
//  Copyright © 2017年 chuliangliang. All rights reserved.
//

#import "RootVC.h"
#import "WebVC.h"
#import "UIImage+WebP.h"

@interface RootVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:index];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idf = @"cell-idf";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idf];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *text_cell = @"";
    switch (indexPath.row) {
        case 0:
        {
            text_cell = @"UIImageView load webp";
        }
            break;
        case 1:
        {
            text_cell = @"UIWebView load webp";
        }
            break;
        case 2:
        {
            text_cell = @"WKWebView load webp";
        }
            break;
        case 3:
        {
            text_cell = @"WKWebView load webp With JS";
        }
            break;
        case 4:
        {
            text_cell = @"UIWebView load webp With JS";
        }
            break;

        default:
            break;
    }
    cell.textLabel.text = text_cell;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WebVC *web = [[WebVC alloc] initWithWebType:WEBType_WKweb];
    [self.navigationController pushViewController:web animated:YES];
}
@end
