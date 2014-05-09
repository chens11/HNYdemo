//
//  HNYTAFNetworkingViewController.m
//  Demo
//
//  Created by chenzq on 5/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTAFNetworkingViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"

@interface HNYTAFNetworkingViewController ()

@end

@implementation HNYTAFNetworkingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 7; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = i;
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        button.layer.borderWidth = 1;
        button.frame = CGRectMake(20,self.navigationController.navigationBar.frame.size.height + 20 + 60*i, self.view.frame.size.width - 40, 40);
        [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (void)touchButton:(UIButton*)sender{
    //App Key：1374530391
    //App Secret：2c191a24e33bd3a0157ddfd64b7608e6

    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2.00ZBZoQCBJ5BVB4593075aac2uyBgE",@"access_token", @"1374530391",@"source",nil];

    if (sender.tag == 0) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [param setObject:[NSNumber numberWithInt:2080738077] forKey:@"id"];
        
        [manager GET:@"https://api.weibo.com/2/comments/show.json" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else if (sender.tag == 1) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [param setObject:@"的" forKey:@"tags"];

        [manager POST:@"https://api.weibo.com/2/tags/create.json" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else if (sender.tag == 2){
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

        NSURL *filePath = [NSURL fileURLWithPath:@"http://pic.qiushibaike.com/system/pictures/7126/71260439/medium/app71260439.jpg"];
        
        /*
         source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
         access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
         status	false	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
         visible	false	int	微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
         list_id	false	string	微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
         url	false	string	图片的URL地址，必须以http开头。
         pic_id	false	string	已经上传的图片pid，多个时使用英文半角逗号符分隔，最多不超过9个。
         lat	false	float	纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
         long	false	float	经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
         annotations	false	string	元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
         rip	false	string	开发者上报的操作用户真实IP，形如：211.156.0.1。
         */
        [param setObject:@"fdlsj" forKey:@"status"];
        [param setObject:[NSNumber numberWithInt:0] forKey:@"visible"];
        [param setObject:@"3509133959630679" forKey:@"list_id"];
        [param setObject:@"http://pic.qiushibaike.com/system/pictures/7126/71260439/medium/app71260439.jpg" forKey:@"url"];

        NSLog(@"param = %@",param);
        [manager POST:@"https://api.weibo.com/2/statuses/upload_url_text.json" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:filePath name:@"app71260439" error:nil];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else if (sender.tag == 3){
        //Creating a Download Task
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL *URL = [NSURL URLWithString:@"http://aihdownload.adobe.com/bin/live/AdobeFlashPlayerInstaller_13_ltrosxd_aaa_aih.dmg"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            NSLog(@"File downloaded to: %@", filePath);
        }];
        [downloadTask resume];
    }
    else if (sender.tag == 4){
        //Creating an Upload Task
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSLog(@"Success: %@ %@", response, responseObject);
            }
        }];
        [uploadTask resume];
    }
    else if (sender.tag == 5){
        //Creating an Upload Task for a Multi-Part Request, with Progress
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
        } error:nil];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSProgress *progress = nil;
        
        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSLog(@"%@ %@", response, responseObject);
            }
        }];
        
        [uploadTask resume];

    }
    else if (sender.tag == 5){
        //Creating a Data Task
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSLog(@"%@ %@", response, responseObject);
            }
        }];
        [dataTask resume];
        
    }
    else if (sender.tag == 5){
        
    }
    else if (sender.tag == 5){
        
    }
}
@end
