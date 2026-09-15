function test_reader(fixtures)
    paths = dir(fullfile(fixtures, '*.casadi'));
    for i = 1:numel(paths)
        name = paths(i).name;
        type = '';
        if strcmp(name,'resource.casadi'), type = 'Resource'; end
        document = casadi_reader.read(fullfile(fixtures, name), type);
        assert(strcmp(document.format, 'casadi_serialization'));
        expected = fullfile(fixtures, [name(1:end-7) '.reader.json']);
        assert(isfile(expected));
        assert(isequaln(document, jsondecode(fileread(expected))), name);
    end
    document = casadi_reader.Document(fullfile(fixtures, 'resource.casadi'), true, true);
    cleanup = onCleanup(@() delete(document));
    assert(document.blobSize(1) == 1144);
    assert(isequal(document.readBlob(1, 0, 4), uint8([80 75 3 4])));
    data = document.data();
    root = data.objects;
    if iscell(root), root = root{data.root+1}; else, root = root(data.root+1); end
    fields = root.fields;
    if iscell(fields), fields = [fields{:}]; end
    payload = fields(strcmp({fields.name}, 'ZipMemResource::blob')).value;
    assert(strcmp(payload.kind, 'deferred_bytes'));
    failed = false;
    try, document.readBlob(1, 1143, 4); catch, failed = true; end
    assert(failed);
    delete(document);
    failed = false;
    try, document.json(); catch, failed = true; end
    assert(failed);
    fprintf('MATLAB: %d structural fixture comparisons, lazy payload and lifetime passed\n', numel(paths));
end
