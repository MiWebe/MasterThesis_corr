close all
clear all
clc
cd 'D:\OneDrive\013 - Master\06 - Masterarbeit\05-WrittenPart-trustful\04_MaterialMethods\img\working folder\SchematicBalanceSystem'

N = 100;
X0 = linspace(0,10,N);
Y0 = X0;

figure
% surface layer
n = linspace(-1.5,2,N);
[X1,Y1,Z1] = peaks(n);
Z1 = Z1+2;
s = surf(X0,Y0,Z1);
s.FaceAlpha = 1.0;
s.FaceColor = [0.4660 0.6740 0.1880];
s.LineStyle = 'none';
s.FaceLighting = 'gouraud';
s.AmbientStrength = 0.7;
s.DiffuseStrength = 0.6;
s.SpecularStrength = 0.3;
light("Style","infinite","Position",[-1 -10 20])
hold on
% second layer
n = linspace(-1.0,2.0,N);
[X2,Y2,Z2] = peaks(n);
Z2 = Z2/1.4-5;
s = surf(X0,Y0,Z2);
s.FaceColor = [0.5 0.5 0.5];
s.LineStyle = 'none';
% third layer
n = linspace(-0.5,1.5,N);
[X3,Y3,Z3] = peaks(n);
Z3 = Z3/1.7-10;
s = surf(X0,Y0,Z3);
s.FaceAlpha = 1.0;
s.FaceColor = [0.3010 0.7450 0.9330];
s.LineStyle = 'none';
% fourth layer
n = linspace(0,2.0,N);
[X4,Y4,Z4] = peaks(n);
Z4 = -transpose(Z4)/2-15;
s = surf(X0,Y0,Z4);
s.FaceAlpha = 1.0;
s.FaceColor = [0.3010 0.7450 0.9330];
s.LineStyle = 'none';

% side faces

% front left
X = [min(X0) min(X0)];
Y = transpose([Y0; Y0]);
Z12 = [Z1(:,1) Z2(:,1)];
Z23 = [Z2(:,1) Z3(:,1)];
Z34 = [Z3(:,1) Z4(:,1)];
%Zfl12 = [Z1(:,1) Z2(:,1)];
s12 = surf(X,Y,Z12);
s23 = surf(X,Y,Z23);
s34 = surf(X,Y,Z34);
s12.EdgeColor = 'none';
s23.EdgeColor = 'none';
s34.EdgeColor = 'none';
s12.FaceColor = [0.9290 0.6940 0.1250];
s23.FaceColor = [0.6 0.6 0.6];
s34.FaceColor = [0.3010 0.7450 0.9330];
s12.AmbientStrength = 0.8;
s23.AmbientStrength = 0.8;
s34.AmbientStrength = 0.8;

% front right
X = [X0; X0];
Y = [min(Y0) min(Y0)];
Z12 = [Z1(1,:); Z2(1,:)];
Z23 = [Z2(1,:); Z3(1,:)];
Z34 = [Z3(1,:); Z4(1,:)];
%Zfl12 = [Z1(:,1) Z2(:,1)];
s12 = surf(X,Y,Z12);
s23 = surf(X,Y,Z23);
s34 = surf(X,Y,Z34);
s12.EdgeColor = 'none';
s23.EdgeColor = 'none';
s34.EdgeColor = 'none';
s12.FaceColor = [0.9290 0.6940 0.1250];
s23.FaceColor = [0.6 0.6 0.6];
s34.FaceColor = [0.3010 0.7450 0.9330];
s12.AmbientStrength = 0.6;
s23.AmbientStrength = 0.6;
s34.AmbientStrength = 0.6;

% graph appearance
xlim([min(X0) max(X0)]);
ylim([min(Y0) max(Y0)]);
zlim([-20 15]);
xlabel("X");
ylabel("Y");
zlabel("Z");
axis('off');

% format and save figure
set(gcf,'units','centimeters','position',[0 0 40 30]);
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition(3:4)],'PaperSize',[screenposition(3:4)]);
FigName = "Fig-VolumeScheme";
print(FigName,'-dpdf')% -painters 
print(FigName,'-dpng')% -painters
