//
//  ViewController.m
//  JXPickerView
//
//  Created by 王加祥 on 16/4/25.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "ViewController.h"
#import "JXProvincesModel.h"
@interface ViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

/**
 *  生日选择器
 */
@property (nonatomic,strong) UIDatePicker * birthdayPickerView;
/**
 *  地址选择器
 */
@property (nonatomic,strong) UIPickerView * addressPickerView;
/**
 *  格式化日期
 */
@property (nonatomic,strong) NSDateFormatter * dateFormatter;

/**
 *  省份数组
 */
@property (nonatomic,strong) NSArray * provincesArray;

/**
 *  省份模型
 */
@property (nonatomic,assign) NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.birthdayTextField.delegate = self;
    self.addressTextField.delegate = self;
    
    [self setupBirthdayPickerView];
    [self setupAddressPickerView];
}


#pragma mark - setupBirthday
- (void)setupBirthdayPickerView {
    
    [self.birthdayPickerView addTarget:self action:@selector(birthdayPickerViewChanged:) forControlEvents:UIControlEventValueChanged];
    self.birthdayTextField.inputView = self.birthdayPickerView;
}

- (void)birthdayPickerViewChanged:(UIDatePicker *)datePicker {
    NSString * string = [self.dateFormatter stringFromDate:datePicker.date];
    self.birthdayTextField.text = string;
}

#pragma mark - setupAddress
- (void)setupAddressPickerView {
    self.addressTextField.inputView = self.addressPickerView;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return NO;
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.birthdayTextField) {
        [self birthdayPickerViewChanged:self.birthdayPickerView];
    } else if (textField == self.addressTextField) {
        [self pickerView:self.addressPickerView didSelectRow:0 inComponent:0];
    }
    return YES;
}


#pragma mark - 懒加载
- (UIDatePicker *)birthdayPickerView {
    if (_birthdayPickerView == nil) {
        _birthdayPickerView = [[UIDatePicker alloc] init];
        _birthdayPickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _birthdayPickerView.datePickerMode = UIDatePickerModeDate;
    }
    return _birthdayPickerView;
}

- (UIPickerView *)addressPickerView {
    if (_addressPickerView == nil) {
        _addressPickerView = [[UIPickerView alloc] init];
        _addressPickerView.delegate = self;
        _addressPickerView.dataSource = self;
    }
    return _addressPickerView;
}

- (NSDateFormatter *)dateFormatter {
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormatter;
}

- (NSArray *)provincesArray {
    if (_provincesArray == nil) {
        
        // 读取文件路劲
        NSString * path = [[NSBundle mainBundle] pathForResource:@"provinces.plist" ofType:nil];
        NSArray * array = [NSArray arrayWithContentsOfFile:path];
        // 创建数组，将读取文件中数组模型加入到数组中
        NSMutableArray * provincesArray = [NSMutableArray array];
        for (NSDictionary * dict in array) {
            JXProvincesModel * model = [JXProvincesModel provincesWithDict:dict];
            [provincesArray addObject:model];
        }
        _provincesArray = provincesArray;
        
    }
    return _provincesArray;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provincesArray.count;
    } else {
        JXProvincesModel * model = self.provincesArray[self.index];
        return model.cities.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        JXProvincesModel * model = self.provincesArray[row];
        return model.name;
    } else {
        JXProvincesModel * model = self.provincesArray[self.index];
        return model.cities[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.index = [pickerView selectedRowInComponent:0];
        [pickerView reloadComponent:1];
    }
    
    JXProvincesModel * model = self.provincesArray[self.index];
    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    self.addressTextField.text = [NSString stringWithFormat:@"%@-%@",model.name,model.cities[cityIndex]];
}
#pragma mark - UIPickerViewDelegate 

@end
