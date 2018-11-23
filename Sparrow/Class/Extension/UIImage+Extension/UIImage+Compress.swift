//
//  UIImage+Compress.swift
//  Sparrow
//
//  Created by 张发政 on 2018/1/25.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    
    internal class func image(color:UIColor)->UIImage{
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor);
        context.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    internal class func image(color:UIColor,size:CGSize)->UIImage?{
        guard size.width > 0 ,size.height > 0 else {
            return nil
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height:size.height)
        UIGraphicsBeginImageContext(size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor);
        context.fill(rect);
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    internal class func IMGCompressed(sourceImage:UIImage,defineWidth:CGFloat)->UIImage?{
        var newImage:UIImage?
        let imageSize:CGSize=sourceImage.size
        let width:CGFloat = imageSize.width
        let height:CGFloat = imageSize.height
        let targetWidth:CGFloat = defineWidth
        let targetHeight:CGFloat = height / (width / targetWidth)
        let size:CGSize=CGSize(width: targetWidth, height: targetHeight)
        var scaleFactor:CGFloat = 0.0
        var scaledWidth:CGFloat = targetWidth
        var scaledHeight:CGFloat = targetHeight
        var thumbnailPoint:CGPoint = CGPoint(x: 0.0, y: 0.0)
        if !(imageSize == size){
            let widthFactor:CGFloat = targetWidth / width
            let heightFactor:CGFloat = targetHeight / height
            if widthFactor > heightFactor{
                scaleFactor = widthFactor
            }else{
                scaleFactor = heightFactor;
            }
            scaledWidth = width * scaleFactor;
            scaledHeight = height * scaleFactor;
            if widthFactor > heightFactor{
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            }else if widthFactor < heightFactor{
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
        UIGraphicsBeginImageContext(size)
        var thumbnailRect:CGRect = CGRect()
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        sourceImage.draw(in: thumbnailRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    
    internal func compress(width:CGFloat)->UIImage?{
        guard width > 0  else {
            return nil
        }
        let newSize:CGSize = CGSize(width: width, height: width * (self.size.height / self.size.width))
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: newSize.height))
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }

    //先大规模压缩，找到一个范围后再精确压缩
    internal func compressToData(length:Int,compelet:@escaping (Data)->()){
        guard length > 0 else {
            return
        }
        let globalQueue = DispatchQueue.global()
        
        globalQueue.async {
            let scale:CGFloat = 0.9
            var image:UIImage = self.copy() as! UIImage
            //let pngData:Data = UIImagePNGRepresentation(self)!
            let jpgData:Data = UIImageJPEGRepresentation(self, scale)!
            
            while jpgData.count > length{
                image = image.compress(width: image.size.width * scale)!
                var imagData = UIImageJPEGRepresentation(image, 0.0)!
                if(imagData.count<length){
                    var scale:CGFloat = 1.0
                    imagData = UIImageJPEGRepresentation(image, scale)!
                    while imagData.count > length {
                        scale -= 0.1
                        imagData = UIImageJPEGRepresentation(image, scale)!
                    }
                    
                    DispatchQueue.main.async(execute: {
                        compelet(imagData)
                    })
                    return
                }
            }
        }
        
    }

    //尝试性压缩，图片大小不变
    internal func tryCompressToData(length:Int,compelet:@escaping (Data)->()){
        let globalQueue = DispatchQueue.global()
        
        globalQueue.async {
            var scale:CGFloat = 0.9
            var jpgData:Data = UIImageJPEGRepresentation(self, scale)!
            while jpgData.count>length{
                scale -= 0.1
                if scale < 0{
                    break
                }
                jpgData = UIImageJPEGRepresentation(self, scale)!;
            }
            DispatchQueue.main.async(execute: {
                compelet(jpgData)
            })
        }
    }
    
    //图片尺寸大小压缩，图片清晰度不变
    internal func fastCompressToData(length:Int,compelet:@escaping (Data)->()){
        var scale:Float = 1.0
        var newImage:UIImage = self.copy() as! UIImage
        var newImageLength:Int = (UIImageJPEGRepresentation(newImage, 1.0)?.count)!
        
        while newImageLength > length {
            // 如果限定的大小比当前的尺寸大0.9的平方倍，就用开方求缩放倍数,减少缩放次数
            if Float(length)  / Float(newImageLength) < 0.81{
                scale = sqrtf(Float(length) / Float(length));
            }else{
                scale = 0.9
            }
            let width:CGFloat = newImage.size.width * CGFloat(scale);
            newImage = newImage.compress(width: width)!
            newImageLength = (UIImageJPEGRepresentation(newImage, 1.0)?.count)!
        }
        DispatchQueue.main.async(execute: {
            compelet(UIImageJPEGRepresentation(newImage, 1.0)!)
        })
    }
    
    
}
