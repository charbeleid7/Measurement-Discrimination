function M = LudInstChan(N)

isPOVM = checkPOVM(N);

if isPOVM == 0
    return;
end


d = size(N);
M = zeros(d(1)*d(1)*d(3));

ketbra = zeros(d(1),d(1),d(1),d(1));

for i = 1:d(1)
    for j = 1:d(1)
        ketbra(:,:,i,j)=zeros(d(1));
        ketbra(i,j,i,j)=1;
    end
end

ketbraa =   zeros(d(3),d(3),d(3),d(3));

for i = 1:d(3)
    ketbraa(i,i,i,i) = 1;
end

warning('off', 'MATLAB:sqrtm:singularMatrix');
 
for i = 1:d(3)
    for j = 1:d(1)
        for k = 1:d(1)
            M = M +  kron( kron(ketbra(:,:,j,k), sqrtm( N(:,:,i) ) * ketbra(:,:,j,k) * sqrtm(N(:,:,i)) ), ketbraa(:,:,i,i) );
        end
    end
end

warning('on', 'MATLAB:sqrtm:singularMatrix');


end