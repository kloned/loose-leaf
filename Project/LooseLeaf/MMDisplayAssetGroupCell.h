//
//  MMAlbumCell.h
//  LooseLeaf
//
//  Created by Adam Wulf on 3/2/15.
//  Copyright (c) 2015 Milestone Made, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPhotoAlbum.h"

@interface MMDisplayAssetGroupCell : UICollectionViewCell

@property (nonatomic, strong) MMPhotoAlbum* album;
@property (readonly) NSArray* bufferedImageViews;

-(void) loadedPreviewPhotos;

-(void) updatePhotoRotation;

-(void) adjustForDelete:(CGFloat)adjustment;

@end
