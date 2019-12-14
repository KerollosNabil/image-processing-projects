function KNN(n, img_name)
    % n => neighbours
    img = imread(img_name);
    class(img)
    imshow(img);
    [rows_, columns_, ~] = size(img);
    sample_region = false([rows_, columns_, n]);
    f = figure;

    for i = 1:n
        set(f, 'name', ['select sample for region ' num2str(i)]);
        sample_region(:, :, i) = roipoly(img);
    end

    close(f);

    for i = 1:n
        figure
        imshow(sample_region(:, :, i));
        title(['sample region ' num2str(i)])
    end

    r = img(:, :, 1);
    g = img(:, :, 2);
    b = img(:, :, 3);

    color_marker = zeros([n, 3]);

    for i = 1:n
        color_marker(i, 1) = mean2(r(sample_region(:, :, i)));
        color_marker(i, 2) = mean2(g(sample_region(:, :, i)));
        color_marker(i, 3) = mean2(b(sample_region(:, :, i)));
    end

    colorss = color_marker;
    color_lables = 1:n;

    r = double(r);
    g = double(g);
    b = double(b);

    distance = zeros([size(g), n]);

    for i = 1:n
        distance(:, :, i) = (((r - color_marker(i, 1)).^2) + ((g - color_marker(i, 2)).^2) + ((b - color_marker(i, 3)).^2)).^0.5;
    end

    [~, labels] = min(distance, [], 3);
    labels = color_lables(labels);
    y = zeros(size(img));
    ll = double(labels);
    colorss = int16(colorss);

    for i = 1:rows_

        for j = 1:columns_
            y(i, j, :) = colorss(ll(i, j), :);
        end

    end

    y = uint8(y);
    figure; imshow(y)
    colorbar

end
