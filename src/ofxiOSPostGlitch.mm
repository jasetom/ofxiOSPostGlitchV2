//
//  ofxiOSPostGlitch.cpp
//  
//
//  Created by Ryota Katoh on 2014/08/07.
//
//  Heavily modified by Tomas Jasevicius.
//  Modifications were due to ability to use Fbo instead of image or camera.

#include "ofxiOSPostGlitch.h"

//--------------------------------------------------------------
void ofxiOSPostGlitch::setupFBO(ofFbo *buffer_){
    
    // setup shadingBuffer.
    // shadingBuffer is glitched Fbo.
    layoutBuffer.allocate(buffer_->getWidth(), buffer_->getHeight());
    shadingBuffer.allocate(buffer_->getWidth(), buffer_->getHeight());
    
    // load shader
    shaders[0].load("shaders/convergence");
    shaders[1].load("shaders/glow");
    shaders[2].load("shaders/shaker");
    shaders[3].load("shaders/cut_slider");
    shaders[4].load("shaders/twist");
    shaders[5].load("shaders/outline");
    shaders[6].load("shaders/slitscan");
    shaders[7].load("shaders/swell");
    shaders[8].load("shaders/invert");
    
    
    // initialize with No.0 pattern
    effectPatternNumber = 0;
    for(int i=0;i<Num_Shaders;i++){
        bUseShader[i] = 0;
    }
    
}

//--------------------------------------------------------------
void ofxiOSPostGlitch::update(ofFbo *buffer_){
    
    // reset layoutBuffer
    layoutBuffer.begin();
    ofClear(0,0,0,0);
    buffer_->draw(0,0);
    layoutBuffer.end();
    
    
    // rand, v, val is variales for Shader
    float rand = ofRandom(1.0);
    float v[2];
    v[0] = ofRandom(3); v[1] = ofRandom(3);
    
    static int      step = ofRandom(4, 15);
    static float    val[4];
    if(ofGetFrameNum() % step == 0){
        
        val[0] = ofRandom(100);
        val[1] = ofRandom(100);
        val[2] = ofRandom(100);
        val[3] = ofRandom(100);
        
    }
    
    // shader effect
    for(int i=0;i<Num_Shaders;i++){
        
        if(bUseShader[i]){
            
            shaders[i].begin();

            // input variables
            shaders[i].setUniform1f("rand", rand);
            shaders[i].setUniform2fv("blur_vec", v);
            shaders[i].setUniform1f("timer", ofGetElapsedTimef());
            shaders[i].setUniform1f("val2", val[1]);
            shaders[i].setUniform1f("val3", val[2]);
            shaders[i].setUniform1f("imgWidth", ofGetScreenWidth());
            shaders[i].setUniform1f("imgHeight", ofGetScreenHeight());

            // begin writing down shadingBuffer
            shadingBuffer.begin();
            ofClear(0,0,0,0);

            glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
            layoutBuffer.draw(0, 0);

            shadingBuffer.end();
            shaders[i].end();
            
        
            // writing down targetBuffer for adding shader layer
            layoutBuffer.begin();
            ofClear(0,0,0,0);
            
            glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
            shadingBuffer.draw(0, 0);
            
            layoutBuffer.end();

        }
    }
}

//--------------------------------------------------------------
void ofxiOSPostGlitch::draw(int x, int y){

    layoutBuffer.draw(x, y);
    
}

//--------------------------------------------------------------
void ofxiOSPostGlitch::setShaderOn(int n){
    
    bUseShader[n] = true;
    
}

//--------------------------------------------------------------
void ofxiOSPostGlitch::setShaderOff(int n){

    bUseShader[n] = false;
    
}











