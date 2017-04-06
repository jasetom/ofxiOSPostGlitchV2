#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    ofBackground(0, 0, 0);
    
    myFbo.allocate(ofGetScreenWidth(), ofGetScreenHeight());

    

    image.loadImage("0.jpg");
    image.resize(ofGetWidth(), ofGetWidth()*image.getHeight() / (float)image.getWidth());

    postGlitch.setupFBO(&myFbo);
    
    effectNumber = 0;
}

//--------------------------------------------------------------
void ofApp::update(){
    
    myFbo.begin();
    ofClear(0,0,0,0);
    ofSetColor(255);
    image.draw(0,0);
    myFbo.end();
    
    postGlitch.update(&myFbo);

    
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(0,255,0);
    
    ofSetColor(255);

    postGlitch.draw(0,0);

//    ofBackground(0,255,0);
    
    //myFbo.draw(0,0);
    
//    ofSetColor(255,0,255);
//    ofRectangle(10,10,100,100);
    ofSetColor(255,0,255);
    ofDrawBitmapString("helllooo", ofGetScreenWidth()/2, ofGetScreenHeight()/2);
    ofDrawRectangle(ofGetScreenWidth()/2,ofGetScreenHeight()/2+50,50,50);
    ofSetColor(255);


}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    
    for(int i=0;i<Num_Shaders;i++){
        
        if(Pattern[effectNumber][i] == 1)
            postGlitch.setShaderOn(i);
        
    }
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    
    for(int i=0;i<Num_Shaders;i++){
        
        if(Pattern[effectNumber][i] == 1)
            postGlitch.setShaderOff(i);
        
    }
    
    effectNumber ++;
    if(effectNumber >= Num_Pattern)
        effectNumber = 0;
    
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    
}
