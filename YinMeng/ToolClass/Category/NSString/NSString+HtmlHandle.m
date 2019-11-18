//
//  NSString+HtmlHandle.m
//  TestByDuWenLiang
//
//  Created by ZZCN77 on 2018/6/5.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "NSString+HtmlHandle.h"

@implementation NSString (HtmlHandle)

+ (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"img src=&quot;" withString:@"img src=&quot;http://ld.tt.100help.net"];
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    //    string  = [string stringByReplacingOccurrencesOfString:@"KaiTi" withString:@"经典楷体简" options:NSRegularExpressionSearch range:NSMakeRange(0, string.length)];
    
    string = [NSString stringWithFormat:@"<html> \n"
                      "<head> \n"
                      "<style type=\"text/css\"> \n"
                      "body {font-size:15px;}\n"
                      "</style> \n"
                      "</head> \n"
                      "<body>"
                      "<script type='text/javascript'>"
                      "window.onload = function(){\n"
                      "var $img = document.getElementsByTagName('img');\n"
                      "for(var p in  $img){\n"
                      " $img[p].style.width = '100%%';\n"
                      "$img[p].style.height ='auto'\n"
                      "}\n"
                      "}"
                      "</script>%@"
                      "</body>"
                      "</html>", string];
    return string;
}

@end
