clear;
y=zeros(1,1);
i=zeros(1,1);
elem_size_start=0.001;
elem_size_end=0.1;
de=0.001;
for i=elem_size_start:de:elem_size_end
    y=[y; bracket_fea(i)];   
    i
end   
[m, n] = size(y);
elem_size=linspace(1,4,m)';
%%
scatter(elem_size, y, 'k')