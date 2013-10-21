//
//  EAGLView.m
//  Opportunita
//
//  Created by furukawa on 2013/10/03.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "EAGLView.h"
#import "Texture.h"
#import "QCARutils.h"
#import <QCAR/Renderer.h>
#import <QCAR/VideoBackgroundConfig.h>
#import <QCAR/Marker.h>
#import <QCAR/MarkerResult.h>

#import "ShaderUtils.h"
#import "object.h"
#import "SharedData.h"

#define MAKESTRING(x) #x

@implementation EAGLView

namespace {
    // Letter object scale factor and translation
    const float kLetterScale = 25.0f;
    const float kLetterTranslate = 25.0f;
    
};

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        sh=[SharedData instance];
        AR_array=[NSArray array];
        AR_array=[sh getDataForKey:@"ar_field"];
        NSNumber *num;
        for (int i=0; i<[AR_array count];i++) {
            num=[NSNumber numberWithInt:i];
            [textureList addObject:num];
        }
    }
    return self;
}


- (void) add3DObjectWith:(int)numVertices ofVertices:(const float *)vertices normals:(const float *)normals texcoords:(const float *)texCoords with:(int)numIndices ofIndices:(const unsigned short *)indices usingTextureIndex:(NSInteger)textureIndex
{
    Object3D *obj3D = [[Object3D alloc] init];
    
    obj3D.numVertices = numVertices;
    obj3D.vertices = vertices;
    obj3D.normals = normals;
    obj3D.texCoords = texCoords;
    
   // obj3D.numIndices = numIndices;
   // obj3D.indices = indices;
    
    obj3D.texture = [textures objectAtIndex:textureIndex];
    
    [objects3D addObject:obj3D];
    obj3D=nil;
}

- (void)setup3dObjects
{
    
    for (int i=0;i<[AR_array count]; i++) {
    [self add3DObjectWith:objectNumVerts ofVertices:objectVerts normals:objectNomals texcoords:objectTexCoords with:nil ofIndices:nil usingTextureIndex:i];
        
    }
}

- (void)renderFrameQCAR
{
    if (APPSTATUS_CAMERA_RUNNING == qUtils.appStatus) {
        [self setFramebuffer];
        
        // Clear colour and depth buffers
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        
        // Retrieve tracking state and render video background and
        QCAR::State state = QCAR::Renderer::getInstance().begin();
        QCAR::Renderer::getInstance().drawVideoBackground();
        
        glEnable(GL_DEPTH_TEST);
        // We must detect if background reflection is active and adjust the culling direction.
        // If the reflection is active, this means the pose matrix has been reflected as well,
        // therefore standard counter clockwise face culling will result in "inside out" models.
        glEnable(GL_CULL_FACE);
        glCullFace(GL_BACK);
        if(QCAR::Renderer::getInstance().getVideoBackgroundConfig().mReflection == QCAR::VIDEO_BACKGROUND_REFLECTION_ON)
            glFrontFace(GL_CW);  //Front camera
        else
            glFrontFace(GL_CCW);   //Back camera
        
        // Did we find any trackables this frame?
        for(int i = 0; i < state.getNumTrackableResults(); ++i) {
            // Get the trackable
            const QCAR::TrackableResult* trackableResult = state.getTrackableResult(i);
            QCAR::Matrix44F modelViewMatrix = QCAR::Tool::convertPose2GLMatrix(trackableResult->getPose());
            
            // Check the type of the trackable:
            assert(trackableResult->getType() == QCAR::TrackableResult::MARKER_RESULT);
            const QCAR::MarkerResult* markerResult = static_cast<
            const QCAR::MarkerResult*>(trackableResult);
            const QCAR::Marker& marker = markerResult->getTrackable();
            
            // Choose the object and texture based on the marker ID
            int textureIndex = marker.getMarkerId();
            assert(textureIndex < [textures count]);
            
            Object3D *obj3D = [objects3D objectAtIndex:textureIndex];
            
            // Render with OpenGL 2
            QCAR::Matrix44F modelViewProjection;
            ShaderUtils::translatePoseMatrix(-kLetterTranslate, -kLetterTranslate, 0.f, &modelViewMatrix.data[0]);
            ShaderUtils::scalePoseMatrix(kLetterScale, kLetterScale, kLetterScale, &modelViewMatrix.data[0]);
            ShaderUtils::multiplyMatrix(&qUtils.projectionMatrix.data[0], &modelViewMatrix.data[0], &modelViewProjection.data[0]);
            
            glUseProgram(shaderProgramID);
            
            glVertexAttribPointer(vertexHandle, 3, GL_FLOAT, GL_FALSE, 0, obj3D.vertices);
            glVertexAttribPointer(normalHandle, 3, GL_FLOAT, GL_FALSE, 0, obj3D.normals);
            glVertexAttribPointer(textureCoordHandle, 2, GL_FLOAT, GL_FALSE, 0, obj3D.texCoords);
            
            glEnableVertexAttribArray(vertexHandle);
            glEnableVertexAttribArray(normalHandle);
            glEnableVertexAttribArray(textureCoordHandle);
            
            glActiveTexture(GL_TEXTURE0);
            glBindTexture(GL_TEXTURE_2D, [obj3D.texture textureID]);
            glUniformMatrix4fv(mvpMatrixHandle, 1, GL_FALSE, (GLfloat*)&modelViewProjection.data[0]);
            glUniform1i(texSampler2DHandle, 0 /*GL_TEXTURE0*/);
            //glDrawElements(GL_TRIANGLES, obj3D.numIndices, GL_UNSIGNED_SHORT, obj3D.indices);
            glDrawArrays(GL_TRIANGLES, 0, obj3D.numVertices);
            ShaderUtils::checkGlError("FrameMarkers renderFrameQCAR");
        }
        
        glDisable(GL_DEPTH_TEST);
        glDisable(GL_CULL_FACE);
        glDisableVertexAttribArray(vertexHandle);
        glDisableVertexAttribArray(normalHandle);
        glDisableVertexAttribArray(textureCoordHandle);
        
        QCAR::Renderer::getInstance().end();
        [self presentFramebuffer];
    }
}

@end
