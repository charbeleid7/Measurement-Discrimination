function result = Qubit(teta, phi)

result = [cos(teta/2)^2 , exp(-1i*phi)*sin(teta/2)*cos(teta/2) ; 
          exp(1i*phi)*sin(teta/2)*cos(teta/2) , sin(teta/2)^2];

end

