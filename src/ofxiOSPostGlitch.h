//
//  ofxiOSPostGlitch.h
//  
//
//  Created by Ryota Katoh on 2014/08/07.
//
//  Heavily modified by Tomas Jasevicius.
//  Modifications were due to ability to use Fbo instead of image or camera.
//


#pragma once

#include "ofMain.h"
#include "ofxiOS.h"

const int Num_Shaders = 9;


class ofxiOSPostGlitch{
public:

    void setupFBO(ofFbo *buffer_);
    void update(ofFbo *buffer_);
    void draw(int x, int y);
    void changeEffectPattern();
    void setShaderOn(int n);
    void setShaderOff(int n);
    
    ofFbo       layoutBuffer;   // layoutBuffer is for layouting some shader effects.
    ofFbo       shadingBuffer; // shaderBuffer is just effect a shader.
    
    // shader variables
    ofShader    shaders[Num_Shaders];
    bool        bUseShader[Num_Shaders];
    int         effectPatternNumber;
    
};



