fnames = dir('*csv');
X = cell(size(fnames,1),1);

for i=1:size(fnames,1)
    X{i} = fnames(i).name;
end

A = zeros(size(fnames,1),size(fnames,1));
X_new = strrep(X,'.csv','');
X_new = strrep(X_new,'_ ',',');
X_new = strrep(X_new,' ','');

for i=1:size(fnames,1)
    C = readtable(X{i}); %Current prof co-author list%
    C = C(4:end-1,:);  %Formatting for only co-authors%
    C = C{:,:};         %Convert Table to cell%
    C_new = C(:,1);
    Q = ismember(C_new,X_new);
    Q = find(Q);
    for j=1:size(Q,1)
        D = C_new{Q(j)};
        L = ismember(X_new,D);
        L = find(L);
        x = C{Q(j),2};
        x = str2num(x);
        A(i,L) = A(i,L) + x;
    end
end

A = max(A,A');