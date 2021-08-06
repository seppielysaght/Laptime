clear all
close all
clc

%Load Track 
load('AchnaTrack.mat')

%Load Car 
load('RadicalChris.mat')

%Load Tyre
load('Main_Tyre_Load.mat')

%RunSim
Output = Simulation(Track, Car, Tyre);