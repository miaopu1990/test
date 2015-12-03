//
//  CDViewController.m
//  切图test
//
//  Created by Tyler.Miao on 14-9-4.
//  Copyright (c) 2014年 Everbridge. All rights reserved.
//

#import "CDViewController.h"

@interface CDViewController ()

@end

@implementation CDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    sizeArray = [[NSMutableArray alloc]init];
    imageArray = [[NSMutableArray alloc]init];
    [imageArray addObject:@"app_icon_iphone"];
    
    CGSize size0 = CGSizeMake(16, 16);
    CGSize size1 = CGSizeMake(36, 36);
    CGSize size2 = CGSizeMake(48, 48);
    CGSize size3 = CGSizeMake(57, 57);
    CGSize size4 = CGSizeMake(58, 58);
    CGSize size5 = CGSizeMake(72, 72);
    CGSize size6 = CGSizeMake(80, 80);
    CGSize size7 = CGSizeMake(96, 96);
    CGSize size8 = CGSizeMake(114, 114);
    CGSize size9 = CGSizeMake(144, 144);
    CGSize size10 = CGSizeMake(120, 120);
    CGSize size11 = CGSizeMake(180, 180);
    CGSize size12 = CGSizeMake(29, 29);
    CGSize size13 = CGSizeMake(40, 40);
    CGSize size14 = CGSizeMake(50, 50);
    CGSize size15 = CGSizeMake(100, 100);
    CGSize size16 = CGSizeMake(76, 76);
    CGSize size17 = CGSizeMake(152, 152);
    CGSize size18 = CGSizeMake(24, 24);
    CGSize size19 = CGSizeMake(196, 196);

    
    [sizeArray addObject:[NSValue valueWithCGSize:size0]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size1]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size2]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size3]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size4]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size5]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size6]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size7]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size8]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size9]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size10]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size11]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size12]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size13]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size14]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size15]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size16]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size17]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size18]  ];
    [sizeArray addObject:[NSValue valueWithCGSize:size19]  ];
    
    

    
    
    [self imagePicke];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

- (void)imagePicke {
    
    for (NSString *str  in imageArray) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",str]];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *filePath = [paths objectAtIndex:0];
        NSError *error;
      
        filePath = [filePath stringByAppendingPathComponent:str];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        
        for (int i =0; i<sizeArray.count; i++) {
            
            
            CGSize size =  [[sizeArray objectAtIndex:i]CGSizeValue];
            int width = size.width;
            int height = size.height;
            
            UIImage *newImage = [self OriginImage:image scaleToSize:CGSizeMake(width,height)];
            NSString *pngImage = [NSString stringWithFormat:@"%@/%@ %d*%d.png",filePath,str,width,height];
            NSLog(@"%@",pngImage);
            BOOL success = [UIImagePNGRepresentation(newImage) writeToFile:pngImage atomically:YES] ;
            
        }
    }
}

    

@end
