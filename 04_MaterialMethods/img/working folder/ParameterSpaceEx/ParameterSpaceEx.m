clc
close all
clear

%% Parameter optimisation Example
close all

N=1000;
Xm = zeros(N);
for i=1:N
    Xm(:,i) = linspace(-3,3,N);
end
Ym = transpose(Xm);

[X,Y,Z] = peaks(Xm,Ym);
Znew = zeros(N);
for i=1:size(Xm,1)
    for j=1:size(Ym,2)
        Znew(i,j) = 10*Z(i,j)+Xm(i,1)*2-Ym(1,j)*Ym(1,j)-Xm(i,1)^2+(0.15-(-Xm(i,1)^2-Ym(1,j)))+14*abs(Z(i,j));
        if i>10 && i<N-10
            Znew(i,j) = Znew(i,j)+(Znew(ceil((i-10)/2)*2,j)-Znew(floor((i-10)/2)*2+1,j))/3;
        end
    end
end

% normalisation
Znew = transpose(sqrt(Znew-min(min(Znew)))/max(max(Znew)));

newmap = jet;
newmap = newmap(256:-1:128,:);

%% Surface Plot
close all
figure
s = surf(X,Y,Znew);
s.EdgeColor = 'none';
s.FaceAlpha = 1.0;
s.FaceColor = 'interp';
s.FaceLighting = 'gouraud';
s.AmbientStrength = 0.7;
s.DiffuseStrength = 0.6;
s.SpecularStrength = 0.3;
colormap(newmap);

light("Style","infinite","Position",[-1 -10 20])
xlabel("\theta_1");
ylabel("\theta_2");
zlabel("Error");
xlim([-3 3]);
xticks([]);
ylim([-3 3]);
yticks([]);
zticks([0 max(max(Znew))]);
zticklabels(["high" "low"]);
c = colorbar;
c.Ticks = [0.1*max(max(Znew)) 0.9*max(max(Znew))];
c.TickLabels = ["high" "low"];
c.Direction = 'reverse';
c.Label.String = "Error";

% insert surrounding box:
Xmin = min(min(X));
Xmax = max(max(X));
Ymin = min(min(Y));
Ymax = max(max(Y));
Zmin = min(min(Znew));
Zmax = max(max(Znew));
hold on

% x-lines
p = plot3([Xmin Xmax],[Ymin Ymin], [Zmin Zmin]);
p.LineStyle = '-';
p.LineWidth = 1.2;
p.Color = [0 0 0];
p = plot3([Xmin Xmax],[Ymax Ymax], [Zmin Zmin]);
p.LineStyle = '--';
p.LineWidth = 1.2;
p.Color = [0 0 0];
p = plot3([Xmin Xmax],[Ymin Ymin], [Zmax Zmax]);
p.LineStyle = '-';
p.LineWidth = 1.2;
p.Color = [0 0 0];
p = plot3([Xmin Xmax],[Ymax Ymax], [Zmax Zmax]);
p.LineStyle = '-';
p.LineWidth = 1.2;
p.Color = [0 0 0];


% y-lines
p = plot3([Xmin Xmin],[Ymin Ymax], [Zmin Zmin]);
p.LineStyle = '-';
p.LineWidth = 1.2;
p.Color = [0 0 0];
p = plot3([Xmax Xmax],[Ymin Ymax], [Zmin Zmin]);
p.LineStyle = '--';
p.LineWidth = 1.2;
p.Color = [0 0 0];
p = plot3([Xmin Xmin],[Ymin Ymax], [Zmax Zmax]);
p.LineStyle = '-';
p.LineWidth = 1.2;
p.Color = [0 0 0];
p = plot3([Xmax Xmax],[Ymin Ymax], [Zmax Zmax]);
p.LineStyle = '-';
p.LineWidth = 1.2;
p.Color = [0 0 0];


% z-lines
p = plot3([Xmin Xmin],[Ymin Ymin], [Zmin Zmax]);
p.LineStyle = '-';
p.LineWidth = 1.2;
p.Color = [0 0 0];
p = plot3([Xmax Xmax],[Ymin Ymin], [Zmin Zmax]);
p.LineStyle = '-';
p.LineWidth = 1.2;
p.Color = [0 0 0];
p = plot3([Xmin Xmin],[Ymax Ymax], [Zmin Zmax]);
p.LineStyle = '-';
p.LineWidth = 1.2;
p.Color = [0 0 0];
p = plot3([Xmax Xmax],[Ymax Ymax], [Zmin Zmax]);
p.LineStyle = '--';
p.LineWidth = 1.2;
p.Color = [0 0 0];


%% Contour Plot
close all
figure
p = contourf(X,Y,Znew,10);
label_x = xlabel("\theta_1");
label_x.Position = [3 -3.05 1];
label_x.FontWeight = 'normal';
label_y = ylabel("\theta_2");
label_y.Position = [-3.25 2.6 1];
label_y.Rotation = 0;
label_y.FontWeight = 'normal';
label_z = zlabel("\delta_{SM}");
xlim([-3 3]);
ylim([-3 3]);
xticks([]);
xticklabels(["\theta_{1,min}" "\theta_{1,max}"])
yticks([]);
yticklabels(["\theta_{2,min}" "\theta_{2,max}"])
zticks([0 max(max(Znew))]);
zticklabels(["large" "small"]);
colormap(newmap);
c = colorbar;
c.Ticks = [0.05*max(max(Znew)) 0.85*max(max(Znew))];
c.TickLabels = ["large" "small"];
c.Direction = 'reverse';
c.Label.String = label_z.String;
c.TickLength = 0;
c.Location = "Eastoutside";
c.Label.FontWeight = 'bold';
c.Label.Position = [1.5 0.0341 0];
%c.Position = [0.95 0.1111 0.0434 0.8148];
hold on

% add Marker of Showcase-Local Optimum:
Xlo = 0.00;
Ylo = 1.33;
% x-line
p = plot([Xlo Xlo],[Ymin Ylo]);
p.LineWidth = 1.2;
p.LineStyle = "--";
p.Color = [0 0 0];
% y-line
p = plot([Xmin Xlo],[Ylo Ylo]);
p.LineWidth = 1.2;
p.LineStyle = "--";
p.Color = [0 0 0];
% Marker
p = plot(Xlo,Ylo);
p.LineWidth = 4;
p.Color = [0.4940 0.1840 0.5560];
p.Marker = "x";
p.MarkerFaceColor = [0.4940 0.1840 0.5560];
p.MarkerSize = 15;
% add axis-ticks
xticks(Xlo);
yticks(Ylo);
xticklabels("\theta_{1,a}");
yticklabels("\theta_{2,a}");

% Global Optimum:
Xgo = 1.58;
Ygo = -0.015;
% x-line
p = plot([Xgo Xgo],[Ymin Ygo]);
p.LineStyle = "none";
p.LineWidth = 1.2;
p.LineStyle = "--";
p.Color = [0 0 0];
% y-line
p = plot([Xmin Xgo],[Ygo Ygo]);
p.LineWidth = 1.2;
p.LineStyle = "--";
p.Color = [0 0 0];
% Marker
p = plot(Xgo,Ygo);
p.LineStyle = "none";
p.LineWidth = 4;
p.Color = [0.4940 0.1840 0.5560];
p.Marker = "x";
p.MarkerFaceColor = [0.4940 0.1840 0.5560];
p.MarkerSize = 15;
% add axis-ticks
xticks([Xlo Xgo]);
yticks([Ygo Ylo]);
xticklabels(["\theta_{1,lo}" "\theta_{1,go}"]);
yticklabels(["\theta_{2,go}" "\theta_{2,lo}"]);
title("Modelling Error \delta_{SM} in Parameter Space \Theta")

leg1 = plot(-999,-999);
leg1.LineStyle = "none";
leg1.LineWidth = 2;
leg1.Color = [0.4940 0.1840 0.5560];
leg1.Marker = "x";
leg1.MarkerFaceColor = [0.4940 0.1840 0.5560];
leg1.MarkerSize = 15;

l = legend(leg1, "Parameter Sets");
l.BoxFace.ColorType = 'truecoloralpha';
l.BoxFace.ColorData = uint8(255*[1; 1; 1; 0.5]);

% format and save figure
set(gcf,'units','centimeters','position',[0 0 13 8]);
screenposition = get(gcf,'Position');
set(gcf,'PaperPosition',[0 0 screenposition(3:4)],'PaperSize',[screenposition(3:4)]);
FigName = "Fig-ParamSpaceEx";
print(FigName,'-dpdf')% -painters 
print(FigName,'-dpng')% -painters

% since 3D-Plots when printed as PDFs still are rasterised, here is a
% different approach to manually set the resolution:
PDFResExport = 1;
if PDFResExport
    exportgraphics(gcf,FigName+".pdf",'Resolution',2000,'ContentType','vector')
end