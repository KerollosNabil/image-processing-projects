function KNN(n, imgname)

    x = imread(imgname);
    class(x)
    imshow(x);
    [r, c, s] = size(x);
    sample_region = false([r, c, n]);
    f = figure;
    for i = 1:n
        set(f, 'name', ['select samole for region ' (i+'0')]);
        sample_region(:,:,i)=roipoly(x);
    end
    close(f);
    for i = 1:n
        figure
        imshow(sample_region(:,:,i));
        title(['sample region' (i+'0')])
    end
    
    
    l=x(:,:,1);
    a=x(:,:,2);
    b=x(:,:,3);
    
    color_marker=repmat(0,[n,3]);
    colorss=repmat(0,[n,3]);
    for i = 1:n
        color_marker(i,2)=mean2(a(sample_region(:,:,i)));
        color_marker(i,3)=mean2(b(sample_region(:,:,i)));
        color_marker(i,1)=mean2(l(sample_region(:,:,i)));
        
        
    end
    colorss=color_marker;
    color_lables = 0:n-1;
    a=double(a);
    b=double(b);
    l=double(l);
    distance = repmat(0,[size(a),n]);
    for i = 1:n
        distance(:,:,i)=(((a-color_marker(i,2)).^2)+((b-color_marker(i,3)).^2)+((l-color_marker(i,1)).^2)).^0.5;
        
    end
    [value,labels]=min(distance,[],3);
    labels=color_lables(labels);
    y=zeros(size(x));
    ll=double(labels)+1;
    colorss = int16(colorss);
   
    
    for m = 1:r
        for n = 1:c
            y(m,n,:)=colorss(ll(m,n),:);
        end
    end
    y=uint8(y);
    figure; imshow(y)
    colorbar
   
    
end