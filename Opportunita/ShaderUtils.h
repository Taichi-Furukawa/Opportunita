//
//  File.h
//  Opportunita
//
//  Created by furukawa on 2013/10/03.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//


#ifndef __SHADERUTILS_H__
#define __SHADERUTILS_H__


#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>


namespace ShaderUtils
{
    // Print a 4x4 matrix
    void printMatrix(const float* matrix);
    
    // Print GL error information
    void checkGlError(const char* operation);
    
    // Set the rotation components of a 4x4 matrix
    void setRotationMatrix(float angle, float x, float y, float z,
                           float *nMatrix);
    
    // Set the translation components of a 4x4 matrix
    void translatePoseMatrix(float x, float y, float z,
                             float* nMatrix = NULL);
    
    // Apply a rotation
    void rotatePoseMatrix(float angle, float x, float y, float z,
                          float* nMatrix = NULL);
    
    // Apply a scaling transformation
    void scalePoseMatrix(float x, float y, float z,
                         float* nMatrix = NULL);
    
    // Multiply the two matrices A and B and write the result to C
    void multiplyMatrix(float *matrixA, float *matrixB,
                        float *matrixC);
    
    // Initialise a shader
    int initShader(GLenum nShaderType, const char* pszSource, const char* pszDefs = NULL);
    
    // Create a shader program
    int createProgramFromBuffer(const char* pszVertexSource,
                                const char* pszFragmentSource,
                                const char* pszVertexShaderDefs = NULL,
                                const char* pszFragmentShaderDefs = NULL);
    
    void setOrthoMatrix(float nLeft, float nRight, float nBottom, float nTop,
                        float nNear, float nFar, float *nProjMatrix);
}

#endif  // __SHADERUTILS_H__

