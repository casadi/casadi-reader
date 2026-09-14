function test_reader(fixtures)
    for name = {'arithmetic', 'mapping', 'slice', 'assignment', 'sparse'}
        document = casadi_reader.read(fullfile(fixtures, [name{1} '.casadi']));
        assert(strcmp(document.format, 'casadi_json'));
        objects = document.objects;
        if iscell(objects), root = objects{document.root+1}; else, root = objects(document.root+1); end
        oracle = jsondecode(fileread(fullfile(fixtures, [name{1} '.json'])));
        assert(strcmp(root.name, oracle.name));
        assert(numel(root.instructions) == numel(oracle.nodes));
        expected = fullfile(fixtures, [name{1} '.reader.json']);
        if isfile(expected), assert(isequaln(document, jsondecode(fileread(expected)))); end
    end
    document = casadi_reader.Document(fullfile(fixtures, 'resource.casadi'), true, true);
    cleanup = onCleanup(@() delete(document));
    assert(document.blobSize(1) == 1144);
    assert(isequal(document.readBlob(1, 0, 4), uint8([80 75 3 4])));
    data = document.data();
    assert(strcmp(data.resource.blob.kind, 'deferred_bytes'));
    failed = false;
    try, document.readBlob(1, 1143, 4); catch, failed = true; end
    assert(failed);
    disp('MATLAB reader fixtures and lazy Resource passed');
end
