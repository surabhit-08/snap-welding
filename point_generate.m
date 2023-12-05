x_max=input('Please input x_max');
y_max=input('Please input y_max');
numberOfCoordinates = 1000;

    for i=1:1:numberOfCoordinates
        x_coord(i)=x_max*rand;      
        y_coord(i)=y_max*rand;
        end
% end
perimeter=0;
% for i=1:1:numberOfCoordinates
%       x=((x_coord(i)+1)-x_coord(i))^2
%       y=((y_coord(i)+1)-y_coord(i))^2
% 	answer=sqrt(sum(x,y))
% 	perimeter=perimeter+answer
% end