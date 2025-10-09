function M = ThreeOutQubitMeasChan(theta, phi)

X = [0 1; 1 0];
Y = [0 -1i; 1i 0];
Z = [1 0; 0 -1];
M = zeros(2,2,3);

for j = 1:3
M(:,:,j) = 1/3 * (eye(2) + cos(theta + (j-1)*2*pi/3)*X + sin(theta + (j-1)*2*pi/3 )*cos(phi)*Y + sin(theta + (j-1)*2*pi/3 )*sin(phi)*Z);
end

end