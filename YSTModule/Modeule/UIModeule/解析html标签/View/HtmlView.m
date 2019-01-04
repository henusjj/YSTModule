//
//  HtmlView.m
//  YSTModule
//
//  Created by 冯亮亮 on 2018/6/27.
//  Copyright © 2018年 zhubiao. All rights reserved.
//

#import "HtmlView.h"
#import <WebKit/WebKit.h>
//屏幕的宽高
//#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
//#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)

#define SCALE_WIDTH  kScreenWidth/375.f //适配比例
#define SCALE_HEIGHT  kScreenHeight/667.f //适配比例
@interface  HtmlView()

@property(nonatomic,strong)WKWebView *webView;

@end

@implementation HtmlView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(10 * SCALE_WIDTH,0, kScreenWidth - 20 * SCALE_WIDTH, kScreenHeight)];
    }
    return _webView;
}

-(void)initUI
{
    [self addSubview:self.webView];
}

-(void)setStr:(NSString *)str
{
    
    [self.webView loadHTMLString:[self fileHtmlString:str] baseURL:nil];
}

- (NSString *)fileHtmlString:(NSString *)html {
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"&" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@";" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding),
                               NSFontAttributeName:[UIFont systemFontOfSize:14]
                               };
    
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSAttributedString *attriStr1 = [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    
    return [self attriToStrWithAttri:attriStr1];
    
}

/**
 *  富文本转html字符串
 */
- (NSString *)attriToStrWithAttri:(NSAttributedString *)attri{
    NSDictionary *tempDic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    NSData *htmlData = [attri dataFromRange:NSMakeRange(0, attri.length)
                         documentAttributes:tempDic
                                      error:nil];
    return [[NSString alloc] initWithData:htmlData
                                 encoding:NSUTF8StringEncoding];
}





//
//-(NSString *)filterHTML:(NSString *)html
//{
//    NSScanner * scanner = [NSScanner scannerWithString:html];
//    NSString * text = nil;
//    while([scanner isAtEnd]==NO)
//    {
//        //找到标签的起始位置
//        [scanner scanUpToString:@"&" intoString:nil];
//        //找到标签的结束位置
//        [scanner scanUpToString:@";" intoString:&text];
//        //替换字符
//        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
//    }
//    //    NSString * regEx = @"<([^>]*)>";
//    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
//    return html;
//}
////将HTML字符串转化为NSAttributedString富文本字符串
//- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
//{
//    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
//                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding),
//                               };
//    
//    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
//    
//    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
//}
////将 &lt 等类似的字符转化为HTML中的“<”等
//- (NSString *)htmlEntityDecode:(NSString *)string
//{
//    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
//    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
//    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
//    
//    return string;
//}

@end
