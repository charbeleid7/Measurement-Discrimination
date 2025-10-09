function M = MeasChan(N)


isPOVM = checkPOVM(N);

if isPOVM == 0
    return;
end

d = size(N);

M = zeros(d(1)*d(3));



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

for i = 1: d(3)
    M = M + kron(transpose(N(:,:,i)), ketbraa(:,:,i,i));

end

end