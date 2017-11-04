function ind = findnearest(val, arr)

    dist = abs(arr - val);
    ind = find(dist == min(dist));

end