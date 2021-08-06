clear
clc

%Import TrackImport
load('AchnaTrack.mat')

%Add reference coordinates here
reflat =  35.025871;
reflon = 33.799424;
reflatlon = [reflat,reflon];
xoff = 0;
yoff = 0;
zoff = 0;

%for each step in GPS file calculate x distance to ref point
for f = 1:length(TrackImport.Lat)
    newlatlon = [TrackImport.Lat(f),reflon];
    temp = (lldistkm(reflatlon,newlatlon))*1000;
    if reflat > TrackImport.Lat(f)
        xy(f,1)=temp;
    else
        
        xy(f,1)=-temp;
    end
end

%for each step in GPS file calculate Y distance to ref point
for e = 1:length(TrackImport.Long)
    newlatlon = [reflat,TrackImport.Long(e)];
    temp = (lldistkm(reflatlon,newlatlon))*1000;
    if reflon > TrackImport.Long(e)
        xy(e,2)=-temp;
    else
        
        xy(e,2)=temp;
    end
end

% Clear temporary variablessd
clearvars filenameright filenameleft delimiter formatSpec formatSpecRaw fileID TrackImportArray ans;

%Plot XY of track
z = plot(0,0,'*');
hold on
w = plot(xy(:,1)+xoff,xy(:,2)+yoff);
legend('ref','XY')
title('XY conversion of GPS data')
xlim([-400 400])
ylim([-400 400])


