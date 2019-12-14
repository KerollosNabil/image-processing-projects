function KNN(n, img_name)
    % n => neighbours
    img = imread(img_name);
    class(img)
    imshow(img);
    [r, c, s] = size(img);
    sample_region = false([r, c, n]);
    f = figure;

    for i = 1:n
        set(f, 'name', ['select sample for region ' num2str(i)]);
        sample_region(:, :, i) = roipoly(img);
    end

    close(f);

    for i = 1:n
        figure
        imshow(sample_region(:, :, i));
        title(['sample region' num2str(i)])
    end

    r = img(:, :, 1);
    g = img(:, :, 2);
    b = img(:, :, 3);

    color_marker = repmat(0, [n, 3]);
    colorss = repmat(0, [n, 3]);

    for i = 1:n
        color_marker(i, 1) = mean2(r(sample_region(:, :, i)));
        color_marker(i, 2) = mean2(g(sample_region(:, :, i)));
        color_marker(i, 3) = mean2(b(sample_region(:, :, i)));
    end

    colorss = color_marker;
    color_lables = 0:n - 1;

    r = double(r);
    g = double(g);
    b = double(b);

    distance = repmat(0, [size(g), n]);

    for i = 1:n
        distance(:, :, i) = (((g - color_marker(i, 2)).^2) + ((b - color_marker(i, 3)).^2) + ((r - color_marker(i, 1)).^2)).^0.5;
    end

    [value, labels] = min(distance, [], 3);
    labels = color_lables(labels);
    y = zeros(size(img));
    ll = double(labels) + 1;
    colorss = int16(colorss);

    for m = 1:r

        for n = 1:c
            y(m, n, :) = colorss(ll(m, n), :);
        end

    end

    y = uint8(y);
    figure; imshow(y)
    colorbar

end
