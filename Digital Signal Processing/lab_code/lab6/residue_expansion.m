function [rou,lamda,k] = residue_expansion(b,a)

[r, p, k] = residue(b,a);
rou = -r./p;
lamda = 1./p;
end