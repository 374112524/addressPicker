//
//  addressPickerView.m
//  bullfighting
//
//  Created by JZY on 16/9/20.
//  Copyright © 2016年 JZY. All rights reserved.
//

#import "addressPickerView.h"

#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface addressPickerView ()

@property (nonatomic,strong)UIPickerView * pickerView;

@property (nonatomic,strong)NSMutableArray * provinceArray;
@property (nonatomic,strong)NSMutableArray * currentCityArray;
@property (nonatomic,strong)NSMutableArray * currentAreaArray;
@property (nonatomic,strong)NSMutableArray * dataArray;


@end

@implementation addressPickerView

- (id)initWithFrame:(CGRect)frame selectedBlock:(SureSelect)sureSelect hiddenSelf:(HiddenView)hiddenView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.sureSelect = sureSelect;
        self.hiddenView = hiddenView;
        [self createViews];
        [self loadAddressData];
    }
    return self;
}

-(void)loadAddressData{
    
    NSError*error;
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"list"ofType:@"json"];
    NSData *jdata = [[NSData alloc]initWithContentsOfFile:filePath];
    
    self.dataArray = [NSMutableArray array];
    self.provinceArray = [NSMutableArray array];
    self.currentCityArray = [NSMutableArray array];
    self.currentAreaArray = [NSMutableArray array];
    NSArray * array = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
    for (NSDictionary * addDic in array) {
        AddressInfoModel * model = [[AddressInfoModel alloc]init];
        [model setValuesForKeysWithDictionary:addDic];
        [self.dataArray addObject:model];
        if (model.addressID%10000 == 0) {
            [self.provinceArray addObject:model];
        }
        if (self.provinceArray.count) {
            AddressInfoModel * defaultProvince = [self.provinceArray firstObject];
            if (model.parentsID == defaultProvince.addressID) {
                [self.currentCityArray addObject:model];
            }
            if (self.currentCityArray.count) {
                AddressInfoModel * defaultCity = [self.currentCityArray firstObject];
                if (model.parentsID == defaultCity.addressID) {
                    [self.currentAreaArray addObject:model];
                }
            }
        }
    }
    [self.pickerView reloadAllComponents];
}

-(void)createViews{
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-240, self.frame.size.width, 240)];
    pickerView.delegate = self;
    pickerView.backgroundColor = ColorFromRGB(0xf8f8f8);
    pickerView.dataSource = self;
    [self addSubview:pickerView];
    self.pickerView = pickerView;
    
    UIView * titleBack = [[UIView alloc]initWithFrame:CGRectMake(0, pickerView.frame.origin.y, self.frame.size.width, 40)];
    titleBack.backgroundColor = [UIColor orangeColor];
    [self addSubview:titleBack];
    
    UILabel *btn = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width/2, titleBack.frame.size.height)];
    btn.textColor = ColorFromRGB(0xffffff);
    btn.text = @"取消";
    btn.textAlignment = NSTextAlignmentLeft;
    btn.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnCancelAction)];
    [btn addGestureRecognizer:tap];
    [titleBack addSubview:btn];
    
    UILabel *btn2 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-15, 0, self.frame.size.width/2, 40)];
    btn2.textColor = ColorFromRGB(0xffffff);
    btn2.text = @"确定";
    btn2.textAlignment = NSTextAlignmentRight;
    btn2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnAction)];
    [btn2 addGestureRecognizer:tap2];
    [titleBack addSubview:btn2];
}

- (void)btnAction{
    
    self.sureSelect([self.provinceArray objectAtIndex:[self.pickerView selectedRowInComponent:0]],[self.currentCityArray objectAtIndex:[self.pickerView selectedRowInComponent:1]],[self.currentAreaArray objectAtIndex:[self.pickerView selectedRowInComponent:2]]);
    self.hiddenView();
}
- (void)btnCancelAction{
    self.hiddenView();
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 20;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/3, 15)];
    label.textColor = ColorFromRGB(0x333333);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    if (component == 0) {
        AddressInfoModel * model = [self.provinceArray objectAtIndex:row];
        label.text = model.addressName;
    }else if (component == 1){
        AddressInfoModel * model = [self.currentCityArray objectAtIndex:row];
        label.text = model.addressName;
    }else if (component == 2){
        AddressInfoModel * model = [self.currentAreaArray objectAtIndex:row];
        label.text = model.addressName;
    }
    return label;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        AddressInfoModel * model = [self.provinceArray objectAtIndex:row];
        return model.addressName;
    }else if (component == 1){
        AddressInfoModel * model = [self.currentCityArray objectAtIndex:row];
        return model.addressName;
    }else if (component == 2){
        AddressInfoModel * model = [self.currentAreaArray objectAtIndex:row];
        return model.addressName;
    }
    return @"";
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArray.count;
    }else if (component == 1){
        return self.currentCityArray.count;
    }else if (component == 2){
        return self.currentAreaArray.count;
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        [self.currentCityArray removeAllObjects];
        [self.currentAreaArray removeAllObjects];
        AddressInfoModel * province = self.provinceArray[row];
        for (AddressInfoModel * model in self.dataArray) {
            if (model.parentsID == province.addressID) {
                [self.currentCityArray addObject:model];
            }
        }
        
        AddressInfoModel * city = [self.currentCityArray objectAtIndex:0];
        for (AddressInfoModel * model in self.dataArray) {
            if (model.parentsID == city.addressID) {
                [self.currentAreaArray addObject:model];
            }
        }
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else if (component == 1){
        [self.currentAreaArray removeAllObjects];
        AddressInfoModel * city = [self.currentCityArray objectAtIndex:row];
        for (AddressInfoModel * model in self.dataArray) {
            if (model.parentsID == city.addressID) {
                [self.currentAreaArray addObject:model];
            }
        }
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else if (component == 2){
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.hiddenView();
}

@end
